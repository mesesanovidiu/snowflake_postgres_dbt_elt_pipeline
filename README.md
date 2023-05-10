
# Postgres -> S3 -> Snowflake ELT Data pipeline

# Introduction
The goal of this project is to build an ELT data pipeline that extracts ecommerce sales data on a daily basis from a Postgres daatbase and stores it in a staging area in a S3 bucket. Based on a storage integration between S3 and Snowflake, as soon as the data is uploaded in S3, Snowflake automatically pulls and inserts it into a sales table and creates two separate tables based on it (an invoices table and an items table).

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
- [Appendix](#appendix)


# The Data Set
The dataset I used in this project is taken from Kaggle. This is a transnactional dataset which contains all the sales transactions occurring between 01/12/2010 and 09/12/2011 for a UK-based online retail. The company mainly sells unique all-occasion gifts. It covers 25900 unique invoices from a pool of 18300 customers. The dataset contains details about the customers and products.

![kaggle_dataset](https://github.com/mesesanovidiu/snowflake_postgres_elt_pipeline/assets/108272657/7dceee86-89b9-4d38-84b2-de30a18b1a0b)

# Used Tools
![Concept map - Page 1 (1)](https://github.com/mesesanovidiu/snowflake_postgres_elt_pipeline/assets/108272657/59583d09-f6f4-4bcf-b7c3-4a5b4fb517dc)

## Client
The source data for the ELT pipeline is located in a transactional database (OLTP) stored in Postgres. The 'ecommerce_sales' table be read by the local python script using psycopg2 library. On a regularly basis, data is pulled from Postgres and stored in S3 in .csv files.
## Storage
S3: Amazon Simple Storage Service is a service that acts as a data lake in this project. Source sales transactions are hosted here for batch/bulk load.

# Data Warehouse
Snowflake: Data warehouse or OLAP database. An integration between S3 and Snowflake has been made and Snowflake is able to see whenever a file is placed in a the staging bucket in S3. Using tasks, the data ingestion from S3 is automated (when a file is uploaded in S3, it is automatically ingested in Snowflake). Furthermore, based on the ecommerce sales table that is being created, two additional tables are created (an invoices table and a products table).

## Visualization
PowerBI: A dasboard is built to visualize the data from the Snowflake.

# Demo
![aws - running command](https://user-images.githubusercontent.com/108272657/236005081-e09af722-f1c9-4111-b6da-4e4917f137db.PNG)
![capture project aws](https://user-images.githubusercontent.com/108272657/236005110-2193e677-905e-40a3-bb95-9512b6704952.PNG)

# Conclusion
Through the completion of this data engineering project, I have gained experience in creating policies/roles using IAM and using S3 and Snowflake. This hands-on experience has enabled me to develop a deeper understanding of Snowflake and its capabilities for integration with S3 for automating data ingestion. As a result of this project, I have gained the confidence and competence to effectively build an ELT pipeline, as well as interacting with databases using python libraries.
