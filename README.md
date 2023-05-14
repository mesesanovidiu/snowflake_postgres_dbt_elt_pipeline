
# Postgres -> S3 -> Snowflake ELT Data pipeline

# Introduction
The goal of this project is to build an ELT data pipeline that extracts ecommerce sales data on a daily basis from a Postgres database and stores it in a staging area in a S3 bucket. Based on a storage integration between S3 and Snowflake, as soon as the data is uploaded in S3, Snowflake automatically pulls and inserts it into a sales table and creates two separate tables based on it (an invoices table and a products table).

# Objectives of this project
- Build and understand ELT data pipelines;
- Understand how to use python libraries (Psycopg2) to interact with databases;
- Setup and understand cloud components involved in data storage (S3);
- Setup IAM policies, roles and integration with Snowflake;
- Understand how to create tasks in Snowflake to automate various SQL scripts;
- Understand how to use unittesting python libraries (Unittest) and mocking to perform automated testing;

# Contents

- [The Data Set](#the-data-set)
- [Used Tools](#used-tools)
  - [Client](#client)
  - [Storage](#storage)
  - [Data Warehouse](#datawarehouse)
- [Demo](#demo)
- [Conclusion](#conclusion)


# The Data Set
The dataset I used in this project is taken from Kaggle. This is a transnactional dataset which contains all the sales transactions occurring between 2010-12-01 and 2011-12-01 for a UK-based online retail. The company mainly sells unique all-occasion gifts. It covers 25,900 unique invoices from a pool of 18,300 customers. The dataset contains details about the customers and products.

![kaggle_dataset](https://github.com/mesesanovidiu/snowflake_postgres_elt_pipeline/assets/108272657/7dceee86-89b9-4d38-84b2-de30a18b1a0b)

# Used Tools
![Concept map - Page 1 (1)](https://github.com/mesesanovidiu/snowflake_postgres_elt_pipeline/assets/108272657/59583d09-f6f4-4bcf-b7c3-4a5b4fb517dc)

## Client
The source data for the ELT pipeline is located in a transactional database (OLTP) stored in Postgres. The 'ecommerce_sales' table be read by the local python script using psycopg2 library. On a regularly basis, data is pulled from Postgres and stored in S3 in .csv files.
## Storage
S3: Amazon Simple Storage Service is a service that acts as a data lake in this project. Source sales transactions are hosted here for batch/bulk load.

# Data Warehouse
Snowflake: Data warehouse or OLAP database. An integration between S3 and Snowflake has been made and Snowflake is able to see whenever a file is placed in a the staging bucket in S3. Using tasks, the data ingestion from S3 is automated (when a file is uploaded in S3, it is automatically ingested in Snowflake). Furthermore, based on the ecommerce sales table that is being created, two additional tables (an invoices table and a products table) are created and automatically updated at a pre-defined interval. After the data from staging area has been ingested, the staging table is automatically dropped by a 'snowflake task'.

## Visualization
PowerBI: A dasboard is built to visualize the data from the Snowflake.

# Demo
- Running Python script
![running_elt_snowflake](https://github.com/mesesanovidiu/snowflake_postgres_elt_pipeline/assets/108272657/7ff113fe-2e6c-4986-b9ec-79ff33e40fe1)
- S3 staging
![s3_staging](https://github.com/mesesanovidiu/snowflake_postgres_elt_pipeline/assets/108272657/3d934485-5a61-4067-97f0-a094d666c0e1)
- Visualize the files in the staging area (S3) from Snowflake
![list_stage](https://github.com/mesesanovidiu/snowflake_postgres_elt_pipeline/assets/108272657/18dbc68d-8dba-4c6f-9f3e-152979c829c4)
- Query sales table in Snowflake
![results snow_flake](https://github.com/mesesanovidiu/snowflake_postgres_elt_pipeline/assets/108272657/60db7a44-de01-48a2-a933-c54205ce7b3f)
- Snapshot of database in Snowflake (stages and tasks as well)
![schema](https://github.com/mesesanovidiu/snowflake_postgres_elt_pipeline/assets/108272657/10afeab6-97d8-4650-ad86-5beb3d4b37b6)


# Conclusion
Through the completion of this data engineering project, I have gained experience in creating policies/roles using IAM and using S3 and Snowflake. This hands-on experience has enabled me to develop a deeper understanding of Snowflake and its capabilities for integration with S3 for automating data ingestion. As a result of this project, I have gained the confidence and competence to effectively build an ELT pipeline, as well as interacting with databases using python libraries.
