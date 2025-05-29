-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 27, 2025 at 06:54 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `advertising-system`
--

-- --------------------------------------------------------

--
-- Table structure for table `ads`
--

CREATE TABLE `ads` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `category` varchar(255) NOT NULL,
  `keywords` text NOT NULL,
  `target_url` text NOT NULL,
  `image_url` text NOT NULL,
  `scores` float NOT NULL DEFAULT 0,
  `user_clicked` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ads`
--

INSERT INTO `ads` (`id`, `title`, `description`, `category`, `keywords`, `target_url`, `image_url`, `scores`, `user_clicked`) VALUES
(2, 'New Smartphone', 'Latest smartphone with advanced features', 'technology', 'smartphone, mobile, tech', 'https://www.amazon.in/s?k=smartphone&crid=3OMADW4HT3PIP&sprefix=smartphon%2Caps%2C224&ref=nb_sb_noss_2', 'https://i.ytimg.com/vi/JkRXhe3KaPE/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLDZw98Svj4VOuLy178RazpvG0SGt', 0, ''),
(3, 'Wireless Earbuds', 'High-quality wireless earbuds', 'technology', 'earbuds, audio, wireless', 'https://www.amazon.in/s?k=earbuds&crid=31XCXTYI5718I&sprefix=earbuds%2Caps%2C223&ref=nb_sb_noss_2', 'https://i.rtings.com/assets/pages/swLQ6KZD/best-iphone-earbuds-20230427-medium.jpg?format=auto', 0, '{\"pdevil\": \"like\"}'),
(4, '4K Monitor', 'Ultra HD monitor for professionals', 'technology', 'monitor, display, 4k', 'https://www.amazon.in/s?k=4k+monito&crid=SVD1BLR2AVER&sprefix=4k+monito%2Caps%2C226&ref=nb_sb_noss_2', 'https://m.media-amazon.com/images/I/81QpkIctqPL._AC_UF1000,1000_QL80_.jpg', 0, ''),
(5, 'Gaming Laptop', 'High-performance gaming laptop', 'technology', 'laptop, gaming, computer', 'https://www.amazon.in/s?k=gaming+laptop&crid=1QG337370HOFM&sprefix=gaming+laptop%2Caps%2C229&ref=nb_sb_noss_2', 'https://sm.ign.com/t/ign_ap/deal/s/save-500-o/save-500-off-the-most-powerful-alienware-gaming-laptop-of-20_tmn7.1280.jpg', 0, ''),
(6, 'Smart Watch', 'Fitness tracking smartwatch', 'technology', 'watch, fitness, wearable', 'https://www.amazon.in/s?k=smart+watch&crid=3O201HTMMNAE8&sprefix=smart+watch%2Caps%2C232&ref=nb_sb_noss_2', 'https://miro.medium.com/v2/resize:fit:1400/0*IzWxL7-1KGVLB3DR', 0, ''),
(7, 'Running Shoes', 'Lightweight running shoes', 'sports', 'running, shoes, fitness', 'https://www.nike.com/in/w/mens-shoes-nik1zy7ok', 'https://hips.hearstapps.com/hmg-prod/images/run-nike-shoes-66db0a2eabc2f.jpg', 0, ''),
(8, 'Yoga Mat', 'Non-slip yoga mat', 'sports', 'yoga, fitness, exercise', 'https://www.nike.com/w/yoga-mats-8c1ht', 'https://d3gqasl9vmjfd8.cloudfront.net/377c56c1-a957-4418-b56b-a311c74929b0.jpg', 0, '{\"pdevil\": \"dislike\"}'),
(9, 'Dumbbell Set', 'Adjustable weight dumbbells', 'sports', 'weights, fitness, exercise', 'https://www.amazon.in/s?k=dumbe&crid=DHCR5ER6B6NG&sprefix=dumbe%2Caps%2C225&ref=nb_sb_noss_1', 'https://www.dmoose.com/cdn/shop/articles/1_06f4bc5e-476a-4356-991f-56ae4cdb90af.jpg?v=1646922445', 0, '{\"pdevil\": \"like\"}'),
(10, 'Travel Backpack', 'Durable backpack for travelers', 'travel', 'backpack, travel, adventure', 'https://www.amazon.in/s?k=travel+backpack&crid=2QQ9EX2ET6FR&sprefix=travel+backpack%2Caps%2C225&ref=nb_sb_noss_2', 'https://www.journalofnomads.com/wp-content/uploads/2019/05/Backpack-Campz-trekking-and-traveling-1024x768.jpg', 0, ''),
(11, 'Noise Cancelling Headphones', 'Perfect for travel', 'travel', 'headphones, audio, travel', 'https://www.amazon.in/s?k=headphone&crid=9GEPA05YW2J1&sprefix=headphone%2Caps%2C223&ref=nb_sb_noss_2', 'https://www.harmanaudio.com/dw/image/v2/BFND_PRD/on/demandware.static/-/Sites-siteCatalog_HA_US_Imported/default/dwf6304dea/categoryimage/JBL_Live_660NC_Lifestyle%20Image_01_Battery_Life_904x560px.jpg?sw=800&sh=400', 0, ''),
(12, 'Organic Coffee', 'Premium organic coffee', 'food', 'coffee, organic, beverage', 'https://www.arakucoffee.in/products/signature?srsltid=AfmBOoq4uUrLek7_PEAG_45bH5CSBYAmFLPSNouhRqM8uxYHNuyh2qX_', 'https://caffecorsini.com/cdn/shop/articles/Immagine_il_caffe_biologico.jpg?v=1695973290&width=2048', 0, ''),
(13, 'Blender', 'High-speed blender for smoothies', 'food', 'blender, kitchen, appliance', 'https://www.amazon.in/s?k=belnders&i=kitchen&crid=361HK3CTDO9ME&sprefix=belnders%2Ckitchen%2C213&ref=nb_sb_noss_2', 'https://contentgrid.homedepot-static.com/hdus/en_US/DTCCOMNEW/Articles/best-blenders-for-your-kitchen-2022-section-1.jpg', 0, ''),
(14, 'AI Assistant', 'Next-gen AI assistant for smart homes', 'technology', 'AI, smart home, voice assistant', 'https://www.amazon.in/s?k=ai+assistant&ref=nb_sb_noss_2', 'https://www.newhorizons.com/Portals/2/EasyDNNnews/1078/freepik-export-20240927165358ZymJ.jpeg', 0, ''),
(15, 'Mirrorless Camera', 'Professional 4K mirrorless camera', 'technology', 'camera, photography, 4K', 'https://www.sony.co.in/electronics/interchangeable-lens-cameras', 'https://static-cse.canva.com/blob/982974/thomholmes594272unsplash.jpg\"', 0, ''),
(16, 'VR Headset', 'Immersive virtual reality gaming headset', 'technology', 'VR, gaming, headset', 'https://www.oculus.com/quest-2/', 'https://fortune.com/img-assets/wp-content/uploads/2024/06/Virtual-Reality-Workouts.jpg?w=1440&q=75', 0, ''),
(17, 'Mountain Bike', 'All-terrain mountain bike for adventure', 'sports', 'bike, cycling, outdoor', 'https://www.trekbikes.com/international/', 'https://www.panoramaresort.com/assets/Bike-Park/pano-mtb-june29-46-2000-v2__FocusFillWzE4MDAsMTA4MCwieSIsNjBd.jpg', 0, '{\"pdevil\": \"like\"}'),
(18, 'Home Gym', 'Compact home gym with resistance bands', 'sports', 'gym, fitness, home workout', 'https://www.amazon.in/home-gym/s?k=home+gym', 'https://www.garagegymreviews.com/wp-content/uploads/best-home-gym.png', 0, ''),
(19, 'Swim Goggles', 'Anti-fog swimming goggles for professionals', 'sports', 'swimming, goggles, fitness', 'https://www.speedo.com/international/', 'https://cam2.com.hk/cdn/shop/files/FORM-FMEQO001_4.png?v=1722497026&width=1214', 0, '{\"pdevil\": \"like\"}'),
(20, 'Travel Suitcase', 'Lightweight hard-shell suitcase with TSA lock', 'travel', 'suitcase, travel, luggage', 'https://www.american-tourister.com/', 'https://i.pinimg.com/736x/e4/f1/ca/e4f1ca51452d699df220fd7782aef174.jpg', 0, ''),
(21, 'Camping Tent', '4-person waterproof camping tent', 'travel', 'camping, outdoor, adventure', 'https://www.decathlon.in/', 'https://content.jdmagicbox.com/comp/def_content_category/waterproof-tent-dealers/360-f-849125052-u3tfmaoz1gxoochxcgalwsnfwfop2bmt-waterproof-tent-dealers-5-endt0.jpg', 0, ''),
(22, 'Herbal Tea', 'Organic detox herbal tea blend', 'food', 'tea, organic, healthy', 'https://www.teabox.com/', 'https://cdn.shopify.com/s/files/1/0648/1955/files/main_hot_herbal_tea.jpg?v=1610077387', 0, ''),
(23, 'Air Fryer', 'Low-oil air fryer for healthy cooking', 'food', 'air fryer, kitchen, healthy', 'https://www.amazon.in/air-fryer/s?k=air+fryer', 'https://www.reliant.co.uk/blog/wp-content/uploads/2023/09/Airfryer.jpg', 0, ''),
(24, 'Foldable Phone', 'Ultra-thin foldable display with multi-tasking', 'technology', 'foldable, smartphone, innovative', 'https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://www.samsung.com/us/mobile/phones/galaxy-z/&ved=2ahUKEwjcqKCg_LiNAxUcSmwGHUXZBTwQFnoECB0QAQ&usg=AOvVaw2ZmxPBcWP4vt9fzlfwtduZ', 'https://images.unsplash.com/photo-1671097027085-77ebeb8f67d3?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Zm9sZGFibGUlMjBwaG9uZXxlbnwwfHwwfHx8MA%3D%3D', 0, ''),
(25, 'AI Home Assistant', 'Voice-controlled smart assistant with ChatGPT', 'technology', 'AI, smart home, voice assistant', 'https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://www.aboutamazon.com/news/devices/new-alexa-generative-artificial-intelligence&ved=2ahUKEwi7u-DR_LiNAxW5wjgGHdlQAIMQFnoECCMQAQ&usg=AOvVaw0olCCJOce02UNxOGoG9YTy', 'https://images.unsplash.com/photo-1568910748155-01ca989dbdd6?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YWxleGF8ZW58MHx8MHx8fDA%3D', 0, ''),
(26, '8K Camera', 'Professional-grade 8K video recording', 'technology', 'camera, 8K, videography', 'https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://www.canon-europe.com/pro/stories/eos-r5-8k-advantage/&ved=2ahUKEwisrdGf_biNAxVV4jgGHVSIOZYQFnoECD8QAQ&usg=AOvVaw3diiuq6DiiJNDCNhSAB8_K', 'https://i1.adis.ws/i/canon/pro-eos-r5-8k-advantage-1-1140?$og-image$', 0, ''),
(27, 'Gaming Laptop', '240Hz refresh rate with RTX 4090', 'technology', 'gaming, laptop, RTX', 'https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://www.asus.com/in/laptops/for-gaming/all-series/&ved=2ahUKEwjSiunb_biNAxUnRCoJHb8THs0QFnoECD8QAQ&usg=AOvVaw0tT5zpn6gpl2UyMWo5nWL6', 'https://media-ik.croma.com/prod/https://media.croma.com/image/upload/v1715933482/Croma%20Assets/Computers%20Peripherals/Laptop/Images/245802_0_kds7fu.png', 0, ''),
(28, 'Wireless Charger', '15W fast charging pad (3-device)', 'technology', 'charger, wireless, Qi', 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.amazon.in%2FAnker-Wireless-Powerwave-Upgraded-Fast-Charging%2Fdp%2FB07THHQMHM&psig=AOvVaw2hSOhKjXYkt6XKMf5pJcZZ&ust=1748068840573000&source=images&cd=vfe&opi=89978449&ved=0CBcQjhxqFwoTCICJtoX-uI0DFQAAAAAdAAAAABAE', 'https://m.media-amazon.com/images/I/614+4XNwpML.jpg', 0, ''),
(29, 'Smart Glasses', 'AR-enabled glasses with notifications', 'technology', 'AR, glasses, wearable', 'https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://www.amazon.in/Smartglasses/b%3Fie%3DUTF8%26node%3D11599657031&ved=2ahUKEwif4I_D_riNAxVMRmwGHVTQOk8QFnoECCUQAQ&usg=AOvVaw0mzqOvRxQz2Xf85JWBtAIc', 'https://api.thesecretariat.in/the-secretariat-api/public//file/download-content-attachment?fileId=e109893f878040c6b3f7fa1fdf7f6d97', 0, ''),
(30, 'SSD 2TB', 'NVMe SSD with 7000MB/s read speed', 'technology', 'SSD, storage, upgrade', 'https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://www.amazon.in/2TB-SSD/s%3Fk%3D2TB%2BSSD&ved=2ahUKEwiZiISJ_7iNAxUPSmwGHXJlJhYQFnoECDkQAQ&usg=AOvVaw0tSdRjksm4le7sghift2rp', 'https://image.coolblue.nl/624x351/content/ab36372e0371a24cbb36636d49028426', 0, ''),
(31, 'Drones Pro 4K', '60-min flight time with obstacle avoidance', 'technology', 'drone, 4K, aerial', 'https://www.amazon.in/s?k=drones&crid=3PBRI6HZCJY1W&sprefix=drone%2Caps%2C218&ref=nb_sb_noss_2', 'https://se-cdn.djiits.com/stormsend/uploads/2207ca2a98fe292604060fa7d44b3b0a.jpg?h=960&thumb=rvcFFQR0iKd6l3iHVY%2BGOHpwqgim&w=750', 0, ''),
(32, 'Electric Scooter', '30-mile range with app control', 'technology', 'scooter, electric, commute', 'https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://www.tvsmotor.com/electric-scooters/tvs-iqube&ved=2ahUKEwiI29z0grmNAxX3yTgGHUIkF8gQFnoECE4QAQ&usg=AOvVaw1MODnRuX4kltOWMLFhuAUu', 'https://www.tvsmotor.com/electric-scooters/tvs-iqube/-/media/Vehicles/Feature/Iqube/Variant/TVS-iQube-O9/Color_Images/Titanium-Grey-Glossy/left.webp', 0, ''),
(33, 'Mechanical Keyboard', 'RBG backlit with tactile switches', 'technology', 'keyboard, gaming, mechanical', 'https://www.amazon.in/s?k=mechanical+gaming+keyboard&crid=1XN6WKVL6DJGI&sprefix=mechani%2Caps%2C255&ref=nb_sb_ss_ts-doa-p_1_7', 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcQV34L4X2iNKdYzkXhaiOmJ6q5jvpMsMgKgRqGM5axEzmWZgHoAwgWEMB6VGOlDN8oif1CHTcQa5wDORuK-2Fc-nNgaXDuf98r9V2UYV2cnuPpZiqSSRk5RAw', 0, ''),
(34, '3D Printer', '0.05mm precision for home use', 'technology', '3D printer, maker, DIY', 'https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://www.amazon.in/3D-Printers/b%3Fie%3DUTF8%26node%3D6804061031&ved=2ahUKEwiA2uC1g7mNAxWy8TgGHczZMggQFnoECFMQAQ&usg=AOvVaw3V7UoW5W-TiCdqaDuLDH6t', 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcTdRybI--QOhfsYFK9z9lIQ38JLCQ2chh6A0yk5BlpQKiWw3iAuaG1BZest5ZNDgmbq5mf78w4zfCcsI5OgmbZAtGaM2qVEpznd9_XwbFh2XOuuaTqQqrPOyg', 0, ''),
(35, 'WiFi 6 Router', 'Whole-home mesh system', 'technology', 'router, WiFi 6, networking', 'https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://www.amazon.in/TP-Link-Archer-AX10-Triple-Core-Wireless/dp/B07YP3T5H7&ved=2ahUKEwih5v24hLmNAxW6fGwGHSBOPJYQFnoECDEQAQ&usg=AOvVaw3hRz33g2iWN8FE_91LJcfd', 'https://m.media-amazon.com/images/I/41kHxeOdw+L.AC_UF1000,1000_QL80.jpg', 0, ''),
(36, 'Smart Thermostat', 'Learns your schedule to save energy', 'technology', 'smart home, thermostat, eco', 'https://www.googleadservices.com/pagead/aclk?sa=L&ai=DChcSEwiW4ejthLmNAxUepWYCHbp_JXkYABAPGgJzbQ&co=1&gclid=EAIaIQobChMIluHo7YS5jQMVHqVmAh26fyV5EAYYASABEgK0tfD_BwE&ohost=www.google.com&cid=CAASJeRoZNxX_bH8HMY-U_sde0HsOHaTxt-00CG2DHXSkQrk_YppW2I&sig=AOD64_3Mg7WmRa97qM9irZ2zkuvMnMe2DQ&ctype=5&q=&ved=2ahUKEwiE5-LthLmNAxWizjgGHRriADIQ9aACKAB6BAgHEA0&adurl=', 'https://m.media-amazon.com/images/I/61A+x8c9VeL.AC_UF894,1000_QL80.jpg', 0, ''),
(37, 'VR Treadmill', 'Omni-directional VR movement platform', 'technology', 'VR, gaming, fitness', 'https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://www.kat-vr.com/%3Fsrsltid%3DAfmBOoochnHkR0ufLbZ-Y-Wmzm7ExQXHNc6hSJYICjLIhAwYSLNk3Pwm&ved=2ahUKEwj266rChbmNAxUCzDgGHcoWKx8QFnoECBQQAQ&usg=AOvVaw3lDSZGv1ThwsnyBg3ADvcV', 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcQ6MQm3zuUnE2gszAGZYwuIn_8EM_qw1RBFNmuKytW6VHDN5xhv_UY_En8s2TO_ykjllp507yd_JXrI2s5cEoVRcRhZpTDDxtXFjvedWYrI', 0, ''),
(38, 'Portable Monitor', '15.6\" 4K touchscreen USB-C', 'technology', 'monitor, portable, USB-C', 'https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://in.msi.com/Portable-Monitor/Products&ved=2ahUKEwjCtvH1hbmNAxVRyTgGHSPNMmsQFnoECDQQAQ&usg=AOvVaw3iWrExofW6AVkf14PnqEZc', 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcT53lY1Et_Xo4VWnxcYT0B3LpROJIwrJNfrKdUkWDZQf6W2fplx8adAe0igk9m1olAngjqOpSzyIbPoKTMsj4_ZBQxlpNiA7HA91b3q3nkTcqp7r89DnbrS', 0, ''),
(39, '', '', '', '', '', '', 0, ''),
(40, 'Butter Chicken', 'Creamy tomato-based curry with tender chicken', 'food', 'indian, curry, chicken', 'https://www.swiggy.com/butter-chicken-dish-restaurants-near-me', 'https://masalaandchai.com/wp-content/uploads/2022/03/Butter-Chicken.jpg', 0, ''),
(41, 'Margherita Pizza', 'Classic pizza with tomato sauce and mozzarella', 'food', 'pizza, italian, vegetarian', 'https://www.pizzahut.co.in/', 'https://grandecheese.com/wp-content/uploads/2025/02/Margherita-Pizza-deck-oven.jpg.webp', 0, ''),
(42, 'Sushi Platter', 'Assorted fresh sushi with soy sauce and wasabi', 'food', 'japanese, seafood, raw', 'https://www.swiggy.com/city/bangalore/sushi-cuisine-restaurants', 'https://i.redd.it/84obefjhqt6b1.jpg', 0, ''),
(43, 'Chocolate Lava Cake', 'Warm chocolate cake with a molten center', 'food', 'dessert, chocolate, sweet', 'https://www.zeptonow.com/pn/choco-lava-cake/pvid/edf76459-7bbf-4ee6-9af4-507c7234368e', 'https://bakingamoment.com/wp-content/uploads/2018/02/IMG_6237-chocolate-molten-lava-cakes-recipe-horizontal.jpg', 0, ''),
(44, 'Paneer Tikka', 'Grilled cottage cheese with spices', 'food', 'indian, vegetarian, appetizer', 'https://www.swiggy.com/city/bangalore/paneer-tikka-dish-restaurants', 'https://www.cookforindia.com/wp-content/uploads/2016/08/Paneer-Tikka-_LR-1140x500.jpg', 0, ''),
(45, 'Pad Thai', 'Stir-fried rice noodles with peanuts and tofu', 'food', 'thai, noodles, stir-fry', 'https://www.bigbasket.com/pd/279406/chings-noodles-pad-thai-original-130-g-carton/', 'https://cdn.apartmenttherapy.info/image/upload/f_jpg,q_auto:eco,c_fill,g_auto,w_1500,ar_16:9/k%2FPhoto%2FRecipes%2F2024-04-pad-thai-190%2Fpad-thai-190-251', 0, ''),
(46, 'Chicken Biryani', 'Fragrant rice with spiced chicken and herbs', 'food', 'indian, rice, non-veg', 'https://www.swiggy.com/chicken-biryani-dish-restaurants-near-me', 'https://recipe30.com/wp-content/uploads/2023/03/chicken-Biryani.jpg', 0, ''),
(47, 'Caesar Salad', 'Fresh romaine lettuce with croutons and dressing', 'food', 'salad, healthy, vegetarian', 'https://www.loveandlemons.com/caesar-salad/', 'https://www.cuisinart.com/dw/image/v2/ABAF_PRD/on/demandware.static/-/Sites-us-cuisinart-sfra-Library/default/dw92573286/images/recipe-Images/classic-caesar-salad-recipe.jpg?sw=1200&sh=1200&sm=fit', 0, ''),
(48, 'Tiramisu', 'Italian coffee-flavored dessert', 'food', 'dessert, coffee, italian', 'https://www.thekitchn.com/tiramisu-recipe-23695524', 'https://pekis.net/sites/default/files/styles/wide/public/2025-02/Tiramisu%20z%20mascarpone%20kremo.jpg?itok=9JnFQ88d', 0, ''),
(49, '', '', '', '', '', '', 0, ''),
(50, 'Women\'s Cotton Silk Saree', 'Handwoven Banarasi saree with zari border', 'fashion', 'saree, ethnic, banarasi, women', 'https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://www.myntra.com/cotton-silk-saree&ved=2ahUKEwjosd7XrbmNAxW8XGwGHUgoHBMQFnoECBwQAQ&usg=AOvVaw21_gETlUpN704aiv09wfei', 'https://images.jdmagicbox.com/quickquotes/images_main/-lnqf9rfi.jpg', 0, ''),
(51, 'Men\'s Slim Fit Shirt', 'Formal cotton shirt with spread collar', 'fashion', 'shirt, men, formal, cotton', 'https://www.google.com/url?sa=i&url=https%3A%2F%2Flevi.in%2Fproducts%2Fmens-navy-collar-shirt-342260037&psig=AOvVaw1t41Smae8-zFWU3vdRQ_dQ&ust=1748081689984000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCNCFwv6tuY0DFQAAAAAdAAAAABAE', 'https://levi.in/cdn/shop/files/342260037_01_Style_Shot_f8ed652c-5e38-4852-b9c2-a96564abbac5.jpg?v=1695730952', 0, ''),
(52, 'Leather Crossbody Bag', 'Genuine leather women\'s handbag', 'fashion', 'bag, women, leather, accessories', 'https://www.google.com/imgres?q=Leather%20Crossbody%20Bag%20shoping%20link&imgurl=https%3A%2F%2Fcdn-images.farfetch-contents.com%2F22%2F09%2F44%2F57%2F22094457_51930325_600.jpg&imgrefurl=https%3A%2F%2Fwww.farfetch.com%2Fin%2Fshopping%2Fwomen%2Fmichael-michael-kors-jet-set-chain-link-leather-crossbody-bag-item-22094457.aspx&docid=I66K6j_c1MNDWM&tbnid=UOItVw2rSBo5BM&vet=12ahUKEwjp4Z3SrrmNAxXERWwGHfgBINEQM3oECBsQAA..i&w=600&h=801&hcb=2&ved=2ahUKEwjp4Z3SrrmNAxXERWwGHfgBINEQM3oECBsQAA', 'https://i.natgeofe.com/n/761f9cb3-9832-460c-8be3-2d76827544ac/shutterstock_2336636013.jpg', 0, ''),
(53, 'Men\'s Running Shoes', 'Air-cushioned sports shoes size 7-12', 'fashion', 'shoes, sports, men, running', 'https://www.google.com/imgres?q=Men%27s%20Running%20Shoes%20&imgurl=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FI%2F71KNWunXvTS.AC_UY1000.jpg&imgrefurl=https%3A%2F%2Fwww.amazon.in%2FRunning-Sneakers-Lightweight-Breathable-Trainers%2Fdp%2FB091GQDVQK&docid=PNeYUvs8w62dFM&tbnid=oLoalfbn-vi3MM&vet=12ahUKEwjA6sX6rrmNAxXM-jgGHU7-Jb8QM3oECBwQAA..i&w=978&h=1000&hcb=2&ved=2ahUKEwjA6sX6rrmNAxXM-jgGHU7-Jb8QM3oECBwQAA', 'https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/aa0bd45abac541d29ff40b492e15cfa4_9366/Runfalcon_5_Running_Shoes_Black_IH7758_HM1.jpg', 0, '{\"pdevil\": \"like\"}'),
(54, 'Women\'s Gold Plated Earrings', 'Traditional jhumka design', 'fashion', 'jewelry, earrings, women, ethnic', 'https://www.google.com/url?sa=i&url=https%3A%2F%2Frubans.in%2Fproducts%2Frubans-22k-antique-gold-plated-pearl-studded-statement-chandbali-earring&psig=AOvVaw3_z0Orm1zqctbYQdMESZuI&ust=1748082194798000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCKiuvZewuY0DFQAAAAAdAAAAABAE', 'https://rubans.in/cdn/shop/files/rubans-22k-antique-gold-plated-pearl-studded-statement-chandbali-earring-earrings-34721826537646.jpg?v=1696832906', 0, '{\"pdevil\": \"dislike\"}'),
(55, 'Boys\' Printed T-Shirt', 'Cotton superhero graphic tee ages 5-12', 'fashion', 'kids, tshirt, cotton, boys', 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.printmate.in%2Fmarvel-avenger-character-graphic-printed-kids-t-shirts-1486.html&psig=AOvVaw3MKQnuiEINEsuBQY2tjPzt&ust=1748082381947000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCMDp_7-wuY0DFQAAAAAdAAAAABAE', 'https://www.printmate.in/media/catalog/product/y/l/ylw-hs-1103.jpg', 0, ''),
(56, 'Women\'s Yoga Pants', 'High-waisted workout leggings', 'fashion', 'leggings, women, fitness, yoga', 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.indiamart.com%2Fproddetail%2Fwomen-s-yoga-pant-20824244812.html&psig=AOvVaw2HSDcmVIgq9TFSvIPa7vCF&ust=1748082451475000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCNDb-eewuY0DFQAAAAAdAAAAABAE', 'https://5.imimg.com/data5/YB/VR/SK/SELLER-42499681/women-s-yoga-pant-500x500.jpg', 0, ''),
(57, 'Men\'s Formal Blazer', 'Slim fit wool blend blazer', 'fashion', 'blazer, men, formal, officewear', 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fmrbutton.in%2Fproducts%2Fvintage-vincet-blazer&psig=AOvVaw2HJuiqQPePfEwlgZ9X3rV9&ust=1748082534780000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCODi5pGxuY0DFQAAAAAdAAAAABAE', 'https://mrbutton.in/cdn/shop/files/2_566b3828-8856-415d-9a47-3641d848abc3.jpg?v=1744099254', 0, ''),
(58, 'Women\'s Designer Kurti', 'Printed cotton kurti with palazzo', 'fashion', 'kurti, ethnic, women, casual', 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.myntra.com%2Fdesigner-kurtis&psig=AOvVaw3DGxFhf9w-pIMsc1kuFJ1V&ust=1748082603249000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCLCg162xuY0DFQAAAAAdAAAAABAL', 'https://assets.myntassets.com/dpr_1.5,q_60,w_400,c_limit,fl_progressive/assets/images/28886594/2024/4/12/c5d9d5d7-36af-478a-84fb-323c39e28a791712915149334AnoukWomenFlaredSleevesKurta6.jpg', 0, ''),
(59, 'Unisex Backpack', 'Waterproof laptop backpack 15.6\"', 'fashion', 'bag, backpack, unisex, laptop', 'https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco/fe1b62fe-1124-4c4c-b947-949cfdafd9d2/NK+HERITAGE+BKPK.png', 'https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco/fe1b62fe-1124-4c4c-b947-949cfdafd9d2/NK+HERITAGE+BKPK.png', 0, ''),
(60, 'Men\'s Analog Watch', 'Chronograph stainless steel watch', 'fashion', 'watch, men, accessories, formal', 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.farfetch.com%2Fau%2Fshopping%2Fwomen%2Fpatek-philippe-2022-pre-owned-nautilus-57121a-001-moon-phase-tiffany-co-405mm-item-23792449.aspx&psig=AOvVaw0QVV8Fwdkx4uocHlOqsCMF&ust=1748082719961000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCIiYxOSxuY0DFQAAAAAdAAAAABAU', 'https://cdn-images.farfetch-contents.com/23/79/24/49/23792449_57944073_600.jpg', 0, ''),
(61, 'Women\'s Sunglasses', 'UV protection cat-eye sunglasses', 'fashion', 'sunglasses, women, accessories', 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.ajio.com%2Fcarlton-london-women-uv-protected-lens-oval-sunglasses--a30102-a1%2Fp%2F463211869_black&psig=AOvVaw0U6loIunVoJSEGLuQLpExF&ust=1748082943170000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCNja_siyuY0DFQAAAAAdAAAAABAE', 'https://assets.ajio.com/medias/sys_master/root/20230808/UjLU/64d1d9b6eebac147fcb1ae5f/-473Wx593H-463211869-black-MODEL.jpg', 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `past_clicks` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `past_clicks`) VALUES
(8, 'harish', '[61, 51, 9, 4]'),
(9, 'pdevil', '[7, 56, 3, 17, 19]');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ads`
--
ALTER TABLE `ads`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ads`
--
ALTER TABLE `ads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
