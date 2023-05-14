USE ROLE ACCOUNTADMIN;

CREATE WAREHOUSE IF NOT EXISTS COMPUTE_WH;

CREATE DATABASE IF NOT EXISTS ECOMMERCE;
CREATE SCHEMA IF NOT EXISTS ECOMMERCE.RAW;

USE WAREHOUSE COMPUTE_WH;
USE DATABASE ECOMMERCE;
USE SCHEMA RAW;

CREATE OR REPLACE FILE FORMAT "ECOMMERCE"."RAW".ECOMMERCECSVFORMAT 
COMPRESSION = 'AUTO' 
FIELD_DELIMITER = ',' 
RECORD_DELIMITER = '\n' 
SKIP_HEADER = 1 
FIELD_OPTIONALLY_ENCLOSED_BY = 'NONE' 
TRIM_SPACE = FALSE 
TIMESTAMP_FORMAT = 'YYYY-MM-DD HH:MI:SS';

CREATE STORAGE INTEGRATION s3_storage_integration
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::808477457628:role/MySnowflakeRole'
  STORAGE_ALLOWED_LOCATIONS = ('s3://omesesan-snowflake-bucket/staging/');

DESC INTEGRATION s3_storage_integration;

create or replace stage s3stage
  url = 's3://omesesan-snowflake-bucket/staging/'
  file_format = ECOMMERCECSVFORMAT
  storage_integration = s3_storage_integration;

create or replace TABLE ECOMMERCE.RAW.SALES (
	INVOICENO VARCHAR(38),
	STOCKCODE VARCHAR(38),
	DESCRIPTION VARCHAR(60),
	QUANTITY NUMBER(38,0),
	INVOICEDATE TIMESTAMP,
	UNITPRICE NUMBER(38,0),
	CUSTOMERID VARCHAR(10),
	COUNTRY VARCHAR(20)
);

create or replace task ECOMMERCE.RAW.import_from_stage
	warehouse=COMPUTE_WH
	schedule='1 MINUTE'
	as copy into ECOMMERCE.RAW.SALES from @s3stage;
    
create or replace task ECOMMERCE.RAW.clean_stage
	warehouse=COMPUTE_WH
	after ECOMMERCE.RAW.import_from_stage
	as remove @S3STAGE
              ;

-- create or replace task ECOMMERCE.RAW.create_invoice_table
--     warehouse=COMPUTE_WH
--     schedule='1 MINUTE'
--     as CREATE OR REPLACE TABLE ECOMMERCE.RAW.INVOICES AS( SELECT DISTINCT CUSTOMERID, COUNTRY, INVOICEDATE, INVOICENO
--                FROM ECOMMERCE.RAW.SALES
--               );
-- create or replace task ECOMMERCE.RAW.create_items_table
--     warehouse=COMPUTE_WH
--     after ECOMMERCE.RAW.create_invoice_table
--     as CREATE OR REPLACE TABLE ECOMMERCE.RAW.ITEMS AS ( SELECT STOCKCODE, DESCRIPTION, UNITPRICE,QUANTITY, INVOICENO
--                FROM ECOMMERCE.RAW.SALES
--               );

ALTER TASK ECOMMERCE.RAW.clean_stage RESUME;
ALTER TASK ECOMMERCE.RAW.import_from_stage RESUME;
-- ALTER TASK ECOMMERCE.RAW.create_items_table RESUME;
-- ALTER TASK ECOMMERCE.RAW.create_invoice_table RESUME;

list @s3stage;

show tables;
