
# Postgres -> S3 -> Snowflake -> dbt ELT Data pipeline

# Introduction
The objective of this project is to establish an ELT data pipeline for extracting daily ecommerce sales data from a Postgres database. The extracted data is then stored in a staging area within an S3 bucket. By leveraging the integration capabilities between S3 and Snowflake, the data is automatically pulled into a raw schema in Snowflake as soon as it is uploaded to S3.

The raw data within Snowflake undergoes subsequent transformations using dbt (data build tool). Once the necessary quality checks are successfully completed, the transformed data is migrated to a development schema. Within dbt, two distinct tables are created based on the sales data: an invoices table and a products table.

To streamline the development process, a CI/CD pipeline is implemented. This involves connecting dbt Cloud to the GitHub repository. Upon each pull request made from the 'main' branch, the pipeline triggers the execution of 'dbt run' and 'dbt test' commands. These commands validate the changes made and ensure the integrity and reliability of the data.

# Objectives of this project
- Build and understand ELT data pipelines;
- Understand how to use python libraries (Psycopg2) to interact with databases;
- Setup and understand cloud components involved in data storage (S3);
- Setup IAM policies, roles and integration with Snowflake;
- Understand how to create tasks in Snowflake to automate various SQL scripts;
- Build and understand dbt models and data quality testing in dbt;
- Build a CI/CD pipeline which automatically tests the code when a pull request is made from the 'main' branch;
- Understand how to use unittesting python libraries (Unittest) and mocking to perform automated testing;

# Contents

- [The Data Set](#the-data-set)
- [Used Tools](#used-tools)
  - [Client](#client)
  - [Storage](#storage)
  - [Data Warehouse](#datawarehouse)
  - [Transform](#transform)
- [Demo](#demo)
- [Conclusion](#conclusion)


# The Data Set
The dataset I used in this project is taken from Kaggle. This is a transnactional dataset which contains all the sales transactions occurring between 2010-12-01 and 2011-12-01 for a UK-based online retail. The company mainly sells unique all-occasion gifts. It covers 25,900 unique invoices from a pool of 18,300 customers. The dataset contains details about the customers and products.
![kaggle_dataset](https://github.com/mesesanovidiu/snowflake_postgres_dbt_elt_pipeline/assets/108272657/c39649b1-741b-4a70-bee0-5f227ea549c4)


# Used Tools
![Concept map - Page 1 (2)](https://github.com/mesesanovidiu/snowflake_postgres_dbt_elt_pipeline/assets/108272657/4dff22e7-2135-4cfe-a28a-a455f9f353fc)

## Client
The source data for the ELT pipeline is located in a transactional database (OLTP) stored in Postgres. The 'ecommerce_sales' table is read by the local python script using psycopg2 library. On a regularly basis, data is pulled from Postgres and stored in S3 in .csv files.
## Storage
S3: Amazon Simple Storage Service is a service that acts as a data lake in this project. Source sales transactions are hosted here for batch/bulk load.

# Data Warehouse
In Snowflake, which serves as a data warehouse or OLAP database, an integration has been established with S3. This integration enables Snowflake to detect whenever a file is added to the staging bucket in S3. To automate data ingestion, tasks are utilized, allowing for seamless ingestion of data from S3 into Snowflake. Whenever a file is uploaded to S3, it is automatically ingested into Snowflake in a 'RAW' schema. Once the data from the staging area is successfully ingested, a 'snowflake task' is triggered to automatically drop the staging table.

# Transform
The raw data stored in Snowflake undergoes subsequent transformations utilizing dbt (data build tool). After successfully passing several quality checks and data freshness checks, the transformed data is migrated to a dedicated development schema. Within dbt, two distinct tables are created based on the sales data: an invoices table and a products table.

To enhance the development workflow, a CI/CD pipeline is implemented, integrating dbt Cloud with the GitHub repository. Whenever a pull request is initiated from the 'main' branch, the pipeline automatically triggers the execution of 'dbt run' and 'dbt test' commands. These commands ensure the validation of the implemented changes and reliability of the data. By leveraging this automated process, the project streamlines development activities and ensures the consistent quality of the transformed data.
- dbt run
![dbt run](https://github.com/mesesanovidiu/snowflake_postgres_dbt_elt_pipeline/assets/108272657/91c4b770-8db2-4ff0-814b-9e77d03ba298)
- dbt test
![dbt test](https://github.com/mesesanovidiu/snowflake_postgres_dbt_elt_pipeline/assets/108272657/b890816a-e801-49c7-8e6d-d3c79f37a518)
- dbt source freshness
![dbt source freshness](https://github.com/mesesanovidiu/snowflake_postgres_dbt_elt_pipeline/assets/108272657/15c585a3-9dd3-4a49-ba8d-3c617f74b4ee)

# Demo
- Running Python script
![running_elt_snowflake](https://github.com/mesesanovidiu/snowflake_postgres_dbt_elt_pipeline/assets/108272657/f99c033c-e408-4331-bfe8-54878a819640)
- S3 staging
![s3_staging](https://github.com/mesesanovidiu/snowflake_postgres_dbt_elt_pipeline/assets/108272657/9477c495-0230-4ea4-aa0a-19717cfddffb)
- Visualize the files in the staging area (S3) from Snowflake
![list_stage](https://github.com/mesesanovidiu/snowflake_postgres_dbt_elt_pipeline/assets/108272657/ac0d97a5-b6d2-4229-a63f-d9d7c3ad0196)
- Query sales table in Snowflake
![results snow_flake](https://github.com/mesesanovidiu/snowflake_postgres_dbt_elt_pipeline/assets/108272657/20fe06be-4a04-44fd-a67b-a1bca110a3d8)
- CI/CD pipeline
![CI-CD1](https://github.com/mesesanovidiu/snowflake_postgres_dbt_elt_pipeline/assets/108272657/992ed644-ad05-4a85-808c-c3bb017dd624)
![CD-CD2](https://github.com/mesesanovidiu/snowflake_postgres_dbt_elt_pipeline/assets/108272657/494baf20-7d0d-4f26-ac39-d08501f847f7)

- Snapshot of database in Snowflake (stages and tasks as well)
![Schema2](https://github.com/mesesanovidiu/snowflake_postgres_dbt_elt_pipeline/assets/108272657/71807cca-3c99-4812-8a6f-8031b2f97152)


# Conclusion
Through the completion of this data engineering project, I have gained experience in creating policies/roles using IAM, creating CI/CD pipelines and using S3, Snowflake and dbt. This hands-on experience has enabled me to develop a deeper understanding of Snowflake and its capabilities for integration with S3 for automating data ingestion as well as creating data transformations and quality checks in dbt. As a result of this project, I have gained the confidence and competence to effectively build an ELT pipeline, create a CI/CD pipeline, as well as interact with databases using python libraries.
