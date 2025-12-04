import psycopg2
import csv
from datetime import date
from pathlib import Path

# --- 1. Database Connection Configuration ---
DB_NAME = "bank_reviews"
# IMPORTANT: Use your actual Termux user if different!
DB_USER = "u0_a256" 

# --- 2. Data File Path Update ---
# Find the root directory of the project. 
# Script location: <project_root>/scripts/insert_data.py
PROJECT_ROOT = Path(__file__).resolve().parent.parent

# Construct the full path to the CSV file: <project_root>/data/processed/reviews_final.csv
CSV_FILE_PATH = PROJECT_ROOT / "data" / "processed" / "reviews_final.csv"

def insert_data():
    """Connects to Postgres and inserts data from the CSV."""
    conn = None
    try:
        # Establish connection
        conn = psycopg2.connect(
            dbname=DB_NAME,
            user=DB_USER,
        )
        cursor = conn.cursor()

        print(f"Connected to database '{DB_NAME}' successfully.")
        print(f"Attempting to load data from: {CSV_FILE_PATH}") # Check the path!

        # --- A. Initialization ---
        # A dictionary to track unique banks and map their name to the generated ID
        unique_banks = {} 
        bank_id_map = {}
        bank_id_counter = 1 

        # --- B. Read and Insert Data Row by Row ---
        with open(CSV_FILE_PATH, mode='r', encoding='utf-8') as file:
            reader = csv.DictReader(file)
            
            for row in reader:
                bank_name = row['bank_name']
                app_name = row.get('app_name', bank_name)
                
                # --- Insert into Banks table (If bank is new) ---
                if bank_name not in unique_banks:
                    insert_bank_query = """
                    INSERT INTO Banks (bank_id, bank_name, app_name) 
                    VALUES (%s, %s, %s)
                    ON CONFLICT (bank_name) DO NOTHING;
                    """
                    cursor.execute(insert_bank_query, (bank_id_counter, bank_name, app_name))
                    bank_id_map[bank_name] = bank_id_counter
                    unique_banks[bank_name] = True
                    bank_id_counter += 1

                # Get the FK bank_id for the Reviews table
                current_bank_id = bank_id_map.get(bank_name)

                # --- Insert into Reviews table ---
                insert_review_query = """
                INSERT INTO Reviews (bank_id, review_text, rating, review_date, sentiment_label, sentiment_score, source) 
                VALUES (%s, %s, %s, %s, %s, %s, %s);
                """
                
                # Prepare and clean data types
                review_date_str = row['review_date']
                try:
                    review_date_obj = date.fromisoformat(review_date_str)
                except ValueError:
                    review_date_obj = None # Use None for invalid dates

                sentiment_score_float = float(row['sentiment_score'])
                rating_int = int(row['rating'])
                
                cursor.execute(insert_review_query, (
                    current_bank_id,
                    row['review_text'],
                    rating_int,
                    review_date_obj,
                    row['sentiment_label'],
                    sentiment_score_float,
                    row['source'] 
                ))

        conn.commit()
        print("\nData insertion successful! All changes committed to the database.")

    except psycopg2.Error as e:
        print(f"\nDatabase Error: {e}")
        if conn:
            conn.rollback() # Rollback changes on error
    except FileNotFoundError:
        print(f"\nError: CSV file not found at the expected path: {CSV_FILE_PATH}")
        print("Please ensure 'reviews_final.csv' is in the 'data/processed' folder.")
    except Exception as e:
        print(f"\nAn unexpected error occurred: {e}")
    finally:
        if conn:
            conn.close()
            print("Database connection closed.")

if __name__ == "__main__":
    insert_data()

