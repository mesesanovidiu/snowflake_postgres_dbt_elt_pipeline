import psycopg2
from psycopg2 import sql
from dotenv import load_dotenv
import os
import requests
import pandas as pd

load_dotenv()


conn = psycopg2.connect(database='postgres', 
                        user=os.environ.get('POSTGRES_USER'), 
                        password=os.environ.get('POSTGRES_PASSWORD'), 
                        host=os.environ.get('POSTGRES_HOST'), 
                        port=5432)
cursor = conn.cursor()

def import_sales_data():
    url = "https://raw.githubusercontent.com/mesesanovidiu/sales-data-pipeline/main/raw_files/data.csv"

    df = pd.read_csv(url, delimiter=',')
    
    for row in df.itertuples(index=False):
        cursor.execute("""
            INSERT INTO ecommerce_sales (
                INVOICENO, STOCKCODE, DESCRIPTION, QUANTITY, INVOICEDATE, UNITPRICE, CUSTOMERID, COUNTRY
            ) VALUES (
                %s, %s, %s, %s, %s, %s, %s, %s
            )
        """, row)
    
    # Commit the changes and close the connection
    conn.commit()
    cursor.close()
    conn.close()
    
    print("Data inserted successfully!")

import_sales_data()
