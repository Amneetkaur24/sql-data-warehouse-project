Data Warehouse and Analytics Project

Welcome to the Data Warehouse and Analytics Project repository! 🚀

This project demonstrates the end-to-end development of a modern data warehouse using SQL Server, including ETL processes, data modeling, and SQL-based analytics.

Designed as a portfolio project, it highlights practical skills in data engineering and business intelligence following industry best practices.

🏗️ Data Architecture
<img width="955" height="563" alt="image" src="https://github.com/user-attachments/assets/7edcd12f-f80b-40bd-be51-ece59d6f31a2" />

## Key Capabilities Demonstrated

• ETL pipeline development
• Data warehouse architecture
• Star schema modeling
• SQL analytics queries
• Data quality validation

This project follows a modern layered architecture inspired by the Medallion approach:

🥉 Bronze Layer – Raw Data

Stores raw data extracted directly from source systems.

ERP and CRM data are imported from CSV files into SQL Server.

No transformations are applied at this stage.

🥈 Silver Layer – Cleaned & Transformed Data

Data cleansing and validation.

Standardization and normalization.

Resolves data quality issues before analytics.

🥇 Gold Layer – Business-Ready Data

Data modeled into a star schema.

Fact and dimension tables optimized for analytical queries.

Designed for reporting and business insights.

📖 Project Overview

This project includes:

Data Architecture Design – Building a structured and scalable data warehouse.

ETL Development – Extracting, transforming, and loading ERP & CRM data.

Data Modeling – Creating fact and dimension tables for analytics.

SQL Analytics & Reporting – Generating business insights using SQL queries.

🎯 Project Objectives
1️⃣ Building the Data Warehouse (Data Engineering)

Objective:
Develop a modern SQL Server data warehouse that consolidates sales data for analytical reporting and decision-making.

Specifications:

Import data from two source systems (ERP and CRM) provided as CSV files.

Clean and resolve data quality issues.

Integrate both sources into a unified analytical model.

Focus only on the latest dataset (no historical tracking required).

Document the data model clearly for business and technical users.

2️⃣ BI: Analytics & Reporting (Data Analytics)

Objective:
Develop SQL-based analytics to generate insights into:

Customer Behavior

Product Performance

Sales Trends

These insights provide stakeholders with key business metrics to support strategic decisions.

🛠️ Tools & Technologies Used

SQL Server Express

SQL Server Management Studio (SSMS)

CSV Data Sources (ERP & CRM)

Draw.io (Architecture & Data Modeling)

Git & GitHub

📂 Repository Structure
data-warehouse-project/
│
├── datasets/                # ERP and CRM raw CSV files
│
├── docs/                    # Documentation and architecture files
│   ├── data_architecture.drawio
│   ├── data_models.drawio
│   ├── data_flow.drawio
│   ├── data_catalog.md
│
├── scripts/
│   ├── bronze/              # Raw data loading scripts
│   ├── silver/              # Data cleansing & transformation scripts
│   ├── gold/                # Star schema & analytical model scripts
│
├── tests/                   # Data validation and testing queries
│
├── README.md
├── LICENSE
└── .gitignore
🚀 Who This Project Is For

This repository demonstrates practical skills relevant to:

SQL Developer

Data Analyst

Data Engineer

BI Developer

Data Warehouse Developer

It is suitable for students and professionals looking to showcase hands-on experience in building a complete data warehouse solution.

📜 License

This project is licensed under the MIT License.
You are free to use, modify, and distribute this project with proper attribution.

⭐ About Me

Hi! I’m Amneet Kaur 👋

I’m passionate about data analytics and enjoy transforming raw data into structured systems that generate meaningful insights.

This project reflects my hands-on experience in:

Data warehousing

SQL development

ETL processes

Business intelligence reporting

I’m continuously improving my skills in data engineering and analytics by building practical, real-world portfolio projects.

LinkedIn: [https://www.linkedin.com/in/amneetkaur24/]
