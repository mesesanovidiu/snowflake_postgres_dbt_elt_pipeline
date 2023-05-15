import unittest
from unittest.mock import Mock, patch
from datetime import date
import os
from snowflake_elt_pipeline import (
    connect_to_database,
    create_cursor,
    instantiate_s3_client,
    extract_data_to_staging
)

class TestSnowflakeELTPipeline(unittest.TestCase):

    @patch('snowflake_elt_pipeline.psycopg2')
    @patch('snowflake_elt_pipeline.boto3')
    def test_connect_to_database(self, mock_boto3, mock_psycopg2):
        os.environ['POSTGRES_USER'] = 'test_user'
        os.environ['POSTGRES_PASSWORD'] = 'test_password'
        os.environ['POSTGRES_HOST'] = 'test_host'
        os.environ['POSTGRES_PORT'] = 'test_port'

        connect_to_database()

        mock_psycopg2.connect.assert_called_once_with(
            database='postgres',
            user='test_user',
            password='test_password',
            host='test_host',
            port='test_port'
        )

    @patch('snowflake_elt_pipeline.psycopg2')
    def test_create_cursor(self, mock_psycopg2):
        connection = Mock()
        create_cursor(connection)

        connection.cursor.assert_called_once()

    @patch('snowflake_elt_pipeline.boto3')
    def test_instantiate_s3_client(self, mock_boto3):
        os.environ['AWS_ACCESS_KEY_ID'] = 'test_access_key_id'
        os.environ['AWS_SECRET_ACCESS_KEY'] = 'test_secret_access_key'

        instantiate_s3_client()

        mock_boto3.client.assert_called_once_with(
            's3',
            aws_access_key_id='test_access_key_id',
            aws_secret_access_key='test_secret_access_key'
        )

    @patch('snowflake_elt_pipeline.pd')
    def test_extract_data_to_staging(self, mock_pd):
        cursor = Mock()
        s3_client = Mock()

        mock_pd.DataFrame.return_value.to_csv.return_value = 'csv_data'

        extract_data_to_staging(cursor, s3_client)

        cursor.execute.assert_called_once_with("SELECT * FROM ecommerce_sales")
        cursor.fetchall.assert_called_once()
        mock_pd.DataFrame.assert_called_once()
        mock_pd.DataFrame.return_value.to_csv.assert_called_once_with(index=False)
        s3_client.put_object.assert_called_once()

if __name__ == '__main__':
    unittest.main()
