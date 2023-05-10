
# Postgres -> Snowflake ELT Data pipeline

# Introduction
The goal of this project is to build a ELT data pipeline that extracts ecommerce sales data on a daily basis from a Postgres daatbase and stores it in a staging area in a S3 bucket. Based on a storage integration between S3 and Snowflake, as soon as the data is uploaded in S3, Snowflake automatically pulls the data and inserts it into a sales table and creates two separate tables based on it (an invoices table and an items table).

# Objectives of this project
- Build and understand ELT data pipelines;
- Understand how to use python libraries (Psycopg2) to interact with databases;
- Setup and understand cloud components involved in data storage (S3);
- Setup IAM policy, role and integration with Snowflake;
- Understand how to create tasks to automate various SQL scripts in Snowflake;
- Understand how to use unittesting python libraries (Unittest) and mocking to perform automated testing;

# Contents

- [The Data Set](#the-data-set)
- [Used Tools](#used-tools)
  - [Client](#client)
  - [Storage](#storage)
  - [Orchestration](#orchestration)
- [Pipelines](#pipelines)
  - [Batch Processing](#batch-processing)
- [Demo](#demo)
- [Conclusion](#conclusion)
- [Appendix](#appendix)


# The Data Set
The dataset I used in this project is taken from Kaggle. This is a simulated sales transaction dataset containing legitimate transactions. It covers 307 orders (each with multiple line numbers) from a pool of 92 customers. The dataset contains details about the customers, orders and products.

![Model databases - Database ER diagram (crow's foot)](https://user-images.githubusercontent.com/108272657/235597548-e3087281-4b5f-4789-9e18-b99f31b981c9.svg)

# Used Tools
![Diagram - tools](https://user-images.githubusercontent.com/108272657/235611932-d72c0476-c39d-4196-8a6b-58e61102d107.svg)


## Client
The source data for the batch processing pipeline is located in the on a GitHub repo in .csv format. The .csv data will be read by the local python script.
## Storage
S3: Amazon Simple Storage Service is a service that acts as a data lake in this project. Source sales transactions are hosted here for batch/bulk load.
Redshift: Datawareouse or OLAP database. A star schema has been built for this project on this relational database.
## Orchestration
Apache Airflow is used to orchestrate this data pipeline.
## Visualization
Grafana: Dasboards are built to visualize the data from the Redshift data warehouse and S3.

# Pipelines
## Batch Processing
S3 Data Lake: Here are the sales transactions that are dumped in the .csv format.

Amazon Redshift: Redshift is Amazon's analytics database, and is designed to crunch large amounts of data as a data warehouse. A redshift cluster has been created for this project as a OLAP Database. Once the database has been created, a staging table has been created. Then the redshift copy command has been used to copy the .csv data from S3 to the created table. Then the star schema tables has been created in the data warehouse and loaded by the data warehouse procedure. Changes in products and customers dimensions are tracked using SCD type 2.

--- Orchestration to be completed ---

## Visualizations
-- To be completed --

# Demo
![aws - running command](https://user-images.githubusercontent.com/108272657/236005081-e09af722-f1c9-4111-b6da-4e4917f137db.PNG)
![capture project aws](https://user-images.githubusercontent.com/108272657/236005110-2193e677-905e-40a3-bb95-9512b6704952.PNG)

# Conclusion
Through the completion of this data engineering project, I have gained experience in the utilization of fundamental AWS services, including S3 and Redshift. This hands-on experience has enabled me to develop a deeper understanding of the AWS infrastructure and its capabilities for processing large-scale datasets. As a result of this project, I have gained the confidence and competence to effectively execute future data engineering projects within the AWS ecosystem.
