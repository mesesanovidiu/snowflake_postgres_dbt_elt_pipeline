import psycopg2
import boto3
from dotenv import load_dotenv
import os
import pandas as pd
from datetime import date

load_dotenv()

aws_access_key_id = os.environ.get('AWS_ACCESS_KEY_ID')
aws_secret_access_key = os.environ.get('AWS_SECRET_ACCESS_KEY')
s3_bucket_name = 'omesesan-snowflake-bucket'
s3_client = boto3.client('s3', aws_access_key_id=aws_access_key_id,
                         aws_secret_access_key=aws_secret_access_key)
s3_staging_key = f'staging/raw_sales_{date.today()}'

conn = psycopg2.connect(database='postgres', 
                        user=os.environ.get('POSTGRES_USER'), 
                        password=os.environ.get('POSTGRES_PASSWORD'), 
                        host=os.environ.get('POSTGRES_HOST'), 
                        port=os.environ.get('POSTGRES_PORT'))
cursor = conn.cursor()

def extract_data_to_staging():
    cursor.execute("SELECT * FROM ecommerce_sales")
    data = cursor.fetchall()
    df = pd.DataFrame(data, columns=["INVOICENO", "STOCKCODE", "DESCRIPTION", "QUANTITY", "INVOICEDATE", "UNITPRICE", "CUSTOMERID", "COUNTRY"])
    csv_data = df.to_csv(index=False)
    s3_client.put_object(Body=csv_data, Bucket=s3_bucket_name, Key=s3_staging_key)

    print(f"File uploaded to s3://{s3_bucket_name}/{s3_staging_key}")

extract_data_to_staging()

