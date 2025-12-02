# Fintech-Analytics
KAIM Week 2 Customer Experience Analytics for Fintech Apps
This repository contains the full data science pipeline for analyzing user reviews of three selected Ethiopian bank mobile applications (Commercial Bank of Ethiopia (CBE), Bank of Abyssinia (BOA), and Dashen Bank).
​The goal is to provide actionable recommendations to improve app features, enhance customer support efficiency, and ultimately boost user satisfaction and retention.
​Business Objective & Key Scenarios
​The primary objective is to transform unstructured user feedback into measurable insights. This project directly addresses the following consulting scenarios:
​User Retention: Analyze if issues like slow loading/transfers are widespread pain points.
​Feature Enhancement: Extract desired features (e.g., fingerprint login, faster loading) for competitive recommendations.
​Complaint Management: Cluster and track common complaints (e.g., login error) to guide AI chatbot integration and support strategy.
​Project Pipeline and Methodology
​The project follows a structured four-phase data science and engineering workflow.
​Phase 1: Data Collection and Preprocessing (Task 1) - Completed
​Source: Google Play Store reviews scraped from three target bank apps.
​Data Size: 1,200+ reviews collected (minimum 400 per bank).
​Preprocessing: Handled duplicates and normalized dates using Python/Pandas. Data saved to data/raw_reviews.csv.
​Phase 2: Sentiment and Thematic Analysis (Task 2) - Completed
​This task used advanced NLP to quantify user emotion and categorize specific feedback topics.
​Sentiment Model: A Hybrid NLP approach used DistilBERT (sst-2 fine-tuned) for robust classification, augmented with VADER to handle the Neutral class. Sentiment was aggregated by bank and rating.
​Thematic Analysis: Keywords extracted via TF-IDF were clustered using a Rule-Based approach into 3-5 actionable themes per bank (e.g., 'Account Access', 'Transaction Performance', 'Reliability').
​Output: Generated processed_reviews.csv with sentiment_label, sentiment_score, and identified_theme(s).
​Phase 3: Database Storage (Task 3) - Next Up
​The cleaned and processed data will be integrated into a robust relational database for persistent storage and efficient querying.
​Database: PostgreSQL
​Tables: banks and reviews (structured with foreign key relationships).
​Tool: Python with psycopg2 or SQLAlchemy for data insertion.
​Phase 4: Insights and Recommendations (Task 4) - Final Step
​The final phase involves deriving business intelligence from the processed data and visualizations.
​Output: Comprehensive report identifying drivers (satisfaction) and pain points (dissatisfaction), providing 2+ actionable recommendations per bank.
