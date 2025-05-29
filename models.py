import pandas as pd
import numpy as np
from sklearn.metrics.pairwise import cosine_similarity
from sklearn.feature_extraction.text import TfidfVectorizer
import sqlite3
from datetime import datetime
import json

class AdRecommender:
    def __init__(self, ad_data_path, db_path):
        self.db_path = db_path
        self.ads = pd.read_csv(ad_data_path)
        self.initialize_database()
        self.train_model()
    
    def initialize_database(self):
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        # Create users table
        cursor.execute('''
        CREATE TABLE IF NOT EXISTS users (
            user_id TEXT PRIMARY KEY,
            interests TEXT,
            last_updated TIMESTAMP
        )
        ''')
        
        # Create user clicks table
        cursor.execute('''
        CREATE TABLE IF NOT EXISTS user_clicks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id TEXT,
            ad_id TEXT,
            click_time TIMESTAMP,
            FOREIGN KEY(user_id) REFERENCES users(user_id)
        )
        ''')
        
        # Create user preferences table
        cursor.execute('''
        CREATE TABLE IF NOT EXISTS user_preferences (
            user_id TEXT,
            ad_id TEXT,
            preference INTEGER,
            timestamp TIMESTAMP,
            PRIMARY KEY (user_id, ad_id),
            FOREIGN KEY(user_id) REFERENCES users(user_id)
        )
        ''')
        
        conn.commit()
        conn.close()
    
    def train_model(self):
        self.ads['content_features'] = self.ads['category'] + " " + self.ads['keywords']
        self.tfidf = TfidfVectorizer(stop_words='english')
        self.tfidf_matrix = self.tfidf.fit_transform(self.ads['content_features'])
        self.content_similarity = cosine_similarity(self.tfidf_matrix)
    
    def get_strict_category_recommendations(self, category, n=5):
        category_ads = self.ads[self.ads['category'].str.lower() == category.lower()]
        if category_ads.empty:
            return []
        return category_ads.sample(min(n, len(category_ads))).to_dict('records')
    
    # ... (other methods remain the same)