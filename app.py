from flask import Flask, render_template, request, jsonify, redirect
from flask_cors import CORS
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
import numpy as np
import mysql.connector
import json

app = Flask(__name__)
CORS(app)

# MySQL Database configuration
db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'advertising-system'
}

class AdRecommender:
    def __init__(self, db_config):
        self.db_config = db_config
        self.ads = self.load_ads_from_db()
        self.ads = self.ads.drop_duplicates(subset=['id'])  # Ensure unique ads by id
        self.ads['category'] = self.ads['category'].fillna('')
        self.ads['keywords'] = self.ads['keywords'].fillna('')
        self.ads['features'] = self.ads['category'] + " " + self.ads['keywords']

        self.vectorizer = TfidfVectorizer(stop_words='english')
        self.ad_vectors = self.vectorizer.fit_transform(self.ads['features'])
        
    def load_ads_from_db(self):
        conn = mysql.connector.connect(**self.db_config)
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT id, title, description, category, keywords, target_url, image_url, scores FROM ads WHERE 1")
        rows = cursor.fetchall()
        cursor.close()
        conn.close()
        return pd.DataFrame(rows)

    def get_past_click_categories(self, past_clicks):
        """Get categories of past clicked ads"""
        if not past_clicks:
            return set()
        past_click_ads = self.ads[self.ads['id'].isin(past_clicks)]
        return set(past_click_ads['category'].dropna().unique())
    
    def get_user_feedback(self, user_id):
        conn = mysql.connector.connect(**self.db_config)
        cursor = conn.cursor()
        cursor.execute("SELECT id, user_clicked FROM ads WHERE JSON_CONTAINS(user_clicked, '\"like\"', '$.\"{}\"') OR JSON_CONTAINS(user_clicked, '\"dislike\"', '$.\"{}\"')".format(user_id, user_id))
        feedback = cursor.fetchall()
        cursor.close()
        conn.close()

        liked = set()
        disliked = set()

        for ad_id, feedback_json in feedback:
            if not feedback_json:
                continue
            try:
                feedback_data = json.loads(feedback_json)
                action = feedback_data.get(user_id)
                if action == 'like':
                    liked.add(ad_id)
                elif action == 'dislike':
                    disliked.add(ad_id)
            except:
                continue

        return liked, disliked
    
    def compute_scores(self, filtered_ads, interests, past_dislikes):
        interests_set = set(w.lower() for w in interests if w.strip())
        
        scores = []
        for _, ad in filtered_ads.iterrows():
            ad_keywords = set((ad['keywords'] or '').lower().split())
            ad_category = (ad['category'] or '').lower()
            
            # Keyword overlap score
            keyword_overlap = len(interests_set.intersection(ad_keywords))
            
            # Category match score (1 if user interests mention category, else 0)
            category_score = 1 if ad_category in interests_set else 0
            
            # Base score from TF-IDF cosine similarity if possible
            base_score = 0.0
            if interests:
                user_profile = " ".join(interests).lower()
                user_vector = self.vectorizer.transform([user_profile])
                ad_vector = self.vectorizer.transform([ad['features']])
                base_score = cosine_similarity(user_vector, ad_vector)[0,0]
            
            # Combine scores with weights
            total_score = (0.5 * keyword_overlap) + (1.0 * category_score) + (0.5 * base_score)
            
            # Penalize disliked ads
            if ad['id'] in past_dislikes:
                total_score *= 0.5
            
            scores.append(total_score)
        return np.array(scores)

    def get_recommendations(self, user_id, current_page, interests, past_clicks):
        filtered_ads = self.ads.copy()

        # Convert past_clicks to list if it's a string
        if isinstance(past_clicks, str):
            try:
                past_clicks = json.loads(past_clicks)
            except:
                past_clicks = [int(x) for x in past_clicks.split(',') if x.isdigit()]

        # Get past liked/disliked keywords
        past_likes = []
        past_dislikes = []
        conn = mysql.connector.connect(**self.db_config)
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT id, user_clicked, keywords FROM ads")
        for row in cursor.fetchall():
            try:
                user_clicks = json.loads(row['user_clicked'] or '{}')
                if user_clicks.get(user_id) == 'like':
                    past_likes.extend((row['keywords'] or '').lower().split())
                elif user_clicks.get(user_id) == 'dislike':
                    past_dislikes.append(row['id'])
            except:
                continue
        cursor.close()
        conn.close()

        # Build user profile vector
        if interests:
            cleaned_interests = [i.lower().strip() for i in interests if i.strip()]
            user_profile = " ".join(cleaned_interests)
            user_vector = self.vectorizer.transform([user_profile])
            similarity_scores = cosine_similarity(user_vector, self.vectorizer.transform(filtered_ads['features'])).flatten()
        else:
            page_context = current_page.split('/')[1] if current_page.count('/') > 1 else current_page
            user_vector = self.vectorizer.transform([page_context])
            similarity_scores = cosine_similarity(user_vector, self.ad_vectors).flatten()

        filtered_ads['scores'] = similarity_scores[:len(filtered_ads)]

        # Apply dislike penalty
        filtered_ads['was_disliked'] = filtered_ads['id'].apply(lambda x: x in past_dislikes)
        filtered_ads['scores'] = filtered_ads.apply(
            lambda row: row['scores'] * 0.5 if row['was_disliked'] else row['scores'], axis=1
        )

        # Mark clicked status
        filtered_ads['was_clicked'] = filtered_ads['id'].isin(past_clicks)

        # Get current category
        current_category = current_page.lstrip('/').lower()
        if not current_category:
            current_category = 'home'
        
        # ✅ STRICT INTEREST-BASED FILTERING LOGIC FOR ALL CATEGORIES (INCLUDING HOME)
        if interests:
            cleaned_interests = [i.lower().strip() for i in interests if i.strip()]
            interest_keywords = set(cleaned_interests)
            
            print(f"🎯 STRICT INTEREST FILTERING: User interests: {', '.join(cleaned_interests)}")
            
            # Function to check if ad matches user's specific interests
            def matches_user_interests(ad_keywords, ad_title, ad_description):
                if not ad_keywords:
                    ad_keywords = ""
                
                # Combine all searchable text
                searchable_text = f"{ad_keywords} {ad_title} {ad_description}".lower()
                
                # Check if any user interest matches the ad content
                return any(interest in searchable_text for interest in interest_keywords)
            
            # Apply strict interest filtering for ALL categories (including home)
            before_count = len(filtered_ads)
            filtered_ads = filtered_ads[
                filtered_ads.apply(
                    lambda row: matches_user_interests(
                        row.get('keywords', ''), 
                        row.get('title', ''), 
                        row.get('description', '')
                    ), 
                    axis=1
                )
            ]
            after_count = len(filtered_ads)
            
            print(f"🔍 STRICT FILTERING APPLIED: Filtered from {before_count} to {after_count} ads based on interests")
            
            # Set matching flags
            filtered_ads['keyword_match'] = 1  # All remaining ads match interests
            
        else:
            # No interests provided - use past likes for keyword matching
            liked_keywords = set(past_likes)
            filtered_ads['keyword_match'] = filtered_ads['keywords'].apply(
                lambda kw: sum(1 for k in (kw or "").lower().split() if k in liked_keywords)
            )
            
            print(f"📝 NO INTERESTS PROVIDED: Using past likes for filtering: {', '.join(past_likes) if past_likes else 'None'}")
        
        # Apply category filtering for non-home pages
        if current_category != 'home':
            print(f"🏷️ CATEGORY FILTERING: Filtering for category '{current_category}'")
            before_category_count = len(filtered_ads)
            filtered_ads = filtered_ads[filtered_ads['category'].str.lower() == current_category]
            after_category_count = len(filtered_ads)
            print(f"🏷️ CATEGORY FILTERING RESULT: {before_category_count} -> {after_category_count} ads")
            
            filtered_ads['category_match'] = 1
        else:
            # Home page - still apply interest filtering but allow all categories
            past_click_categories = self.get_past_click_categories(past_clicks)
            filtered_ads['category_match'] = filtered_ads['category'].apply(
                lambda x: 1 if x in past_click_categories else 0
            )
            print(f"🏠 HOME PAGE MODE: Showing ads from all categories with strict interest filtering")

        # Compute combined score
        scores = self.compute_scores(filtered_ads, interests, past_dislikes)
        filtered_ads['scores'] = scores

        # Update DB scores
        self.update_scores_in_db(filtered_ads)

        # Final sort - prioritize by relevance score
        filtered_ads = filtered_ads.sort_values(
            by=['scores', 'was_disliked', 'was_clicked'],
            ascending=[False, True, True]
        )

        # Build recommendations
        recommendations = []
        top_recommendations = filtered_ads.head(20)

        # Get past click categories for is_similar_to_past field
        past_click_categories = self.get_past_click_categories(past_clicks)

        for _, ad in top_recommendations.iterrows():
            recommendations.append({
                'id': int(ad['id']),
                'title': ad['title'],
                'description': ad['description'],
                'category': ad['category'],
                'image_url': ad['image_url'],
                'target_url': ad['target_url'],
                'scores': float(ad['scores']),
                'category_match': bool(ad.get('category_match', 0)),
                'keyword_match': bool(ad.get('keyword_match', 0)),
                'is_similar_to_past': ad['category'] in past_click_categories if past_click_categories else False,
                'strict_filtering_applied': bool(interests),  # Indicates if strict filtering was used
                'current_category': current_category
            })

        print(f"✅ FINAL RESULT: Returning {len(recommendations)} recommendations for category '{current_category}'")
        return recommendations


    def update_scores_in_db(self, ads): 
        try:
            conn = mysql.connector.connect(**self.db_config)
            cursor = conn.cursor()
            for _, ad in ads.iterrows():
                # print(f"Updating ad ID {ad['id']} with score {ad['scores']}")  # Debug print
                cursor.execute(
                    "UPDATE ads SET scores = %s WHERE id = %s",
                    (float(ad['scores']), int(ad['id']))
                )
            conn.commit()
            cursor.close()
            conn.close()
        except Exception as e:
            print(f"Error updating scores in DB: {e}")
            
# Initialize recommender
recommender = AdRecommender(db_config)

def get_user_past_clicks(user_id):
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        cursor.execute("SELECT past_clicks FROM users WHERE name = %s", (user_id,))
        result = cursor.fetchone()
        cursor.close()
        conn.close()

        if result and result[0]:
            try:
                past_clicks = json.loads(result[0])
                return [int(click) for click in past_clicks if str(click).isdigit()]
            except json.JSONDecodeError:
                return [int(x) for x in result[0].split(',') if x.isdigit()]
        return []
    except Exception as e:
        print(f"Error fetching past clicks: {e}")
        return []
    

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/verify-user', methods=['POST'])
def verify_user():
    try:
        data = request.get_json()
        user_id = data.get('user_id')
        
        if not user_id:
            return jsonify({'status': 'error', 'message': 'No user ID provided'}), 400

        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)
        
        # Check if user exists
        cursor.execute("SELECT id, name FROM users WHERE name = %s", (user_id,))
        user = cursor.fetchone()
        
        if user:
            # User exists
            response = {
                'status': 'success',
                'name': user['name'],
                'message': 'User verified successfully'
            }
            
        else:
            # Create new user
            cursor.execute(
                "INSERT INTO users (id, name, past_clicks) VALUES (%s, %s, %s)",
                (user_id, f"{user_id}", json.dumps([]))
            )
            conn.commit()
            response = {
                'status': 'success',
                'name': f"{user_id}",
                'message': 'New user created successfully',
                'is_new_user' : True
            }
        
        cursor.close()
        conn.close()
        return jsonify(response)
        
    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e)}), 500

@app.route('/recommend', methods=['POST'])
def recommend_ads():
    try:
        user_data = request.get_json()
        
        if not user_data:
            return jsonify({'status': 'error', 'message': 'No data received'}), 400

        user_id = user_data.get('user_id', None)
        current_page = user_data.get('current_page', '/')
        interests = user_data.get('interests', [])

        # Get past clicks
        past_clicks = get_user_past_clicks(user_id) if user_id else []
        # print(f"Past clicks for user {user_id}: {past_clicks}")  # Debug print

        # Get past click categories
        past_click_categories = recommender.get_past_click_categories(past_clicks)
        # print(f"Categories from past clicks: {past_click_categories}")  # Debug print

        recommendations = recommender.get_recommendations(
            user_id=user_id,
            current_page=current_page,
            interests=interests,
            past_clicks=past_clicks
        )
        
        return jsonify({
            'status': 'success',
            'recommendations': recommendations,
            'debug_info': {
                'past_clicks': past_clicks,
                'past_categories': list(past_click_categories)
            }
        })
    except Exception as e:
        print("Error in recommend_ads:", str(e))
        return jsonify({'status': 'error', 'message': str(e)}), 500
    
@app.route('/debug/ads')
def debug_ads():
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT COUNT(*) as count FROM ads")
        count = cursor.fetchone()['count']
        
        cursor.execute("SELECT * FROM ads LIMIT 5")
        sample_ads = cursor.fetchall()
        
        cursor.close()
        conn.close()
        
        return jsonify({
            'total_ads': count,
            'sample_ads': sample_ads
        })
    except Exception as e:
        return jsonify({'error': str(e)})

@app.route('/redirect/<int:id>')
def redirect_to_ad(id):
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT target_url FROM ads WHERE id = %s", (id,))
        ad = cursor.fetchone()
        cursor.close()
        conn.close()

        if not ad:
            return "Ad not found", 404

        # Update past_clicks if user_id provided as query param
        user_id = request.args.get('user_id')
        if user_id:
            conn = mysql.connector.connect(**db_config)
            cursor = conn.cursor()

            cursor.execute("SELECT past_clicks FROM users WHERE name = %s", (user_id,))
            result = cursor.fetchone()
            if result and result[0]:
                try:
                    clicks = json.loads(result[0])
                except json.JSONDecodeError:
                    clicks = [int(x) for x in result[0].split(',') if x.isdigit()]
            else:
                clicks = []

            if id not in clicks:
                clicks.append(id)
                clicks_json = json.dumps(clicks)
                cursor.execute("UPDATE users SET past_clicks = %s WHERE name = %s", (clicks_json, user_id))
                conn.commit()
            cursor.close()
            conn.close()

        return redirect(ad['target_url'], code=302)
    except Exception as e:
        return str(e), 500
    
@app.route('/feedback', methods=['POST'])
def feedback():
    try:
        data = request.get_json()
        user_id = data.get('user_id')
        ad_id = data.get('ad_id')
        action = data.get('action')  # 'like' or 'dislike'

        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        # Get current clicks
        cursor.execute("SELECT user_clicked FROM ads WHERE id = %s", (ad_id,))
        result = cursor.fetchone()
        current_clicks = json.loads(result[0] or '{}')

        # Update the JSON
        if action in ['like', 'dislike']:
            current_clicks[user_id] = action

        # Update the database
        cursor.execute("UPDATE ads SET user_clicked = %s WHERE id = %s", (json.dumps(current_clicks), ad_id))
        conn.commit()
        cursor.close()
        conn.close()

        return jsonify({'status': 'success', 'message': 'Feedback recorded'})
    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e)})
if __name__ == '__main__':
    app.run(debug=True)
