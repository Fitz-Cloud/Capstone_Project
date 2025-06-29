This project showcases a cloud-native ELT (Extract, Load, Transform) pipeline for ingesting GDP data from the World Bank API. The data is loaded into Snowflake using Airbyte (via local CSV), transformed with dbt, and deployed using Docker and AWS (ECR & ECS). The pipeline supports scalable, reproducible analytics workflows and concludes with visual insights powered by Tableau.

## 🚀 Project Stack

Python Script - To extract gdp dataset from World Bank API to CSV

Airbyte OSS - For ingesting CSV data from a local path

Snowflake - Cloud data warehouse

dbt - For transformation (with incremental and snapshot strategies)

Docker - Containerize dbt pipeline

AWS ECR + ECS - Deploy containerized dbt job

VS Code + Conda Environment - Development environment

## 🔄 Pipeline Architecture

Local CSV File (world_bank_gdp.csv)
      ↓
   Airbyte (File Source)  → Snowflake (Destination)
      ↓
   Raw Table in Snowflake (PUBLIC.world_bank_gdp)
      ↓
   dbt Staging → Core Dimensions + Facts → BI Models (Insight Queries)
      ↓
   Dashboard / Tableau / Reporting
## ELT Pipeline Architecture
![alt text](worldbank_dbt_project/elt_pipeline_architecture.png)

## Data Ingestion through Airbyte Connection
   ![alt text](worldbank_dbt_project/airbyte_ingestion.png)

## Snowflake Staging Table image
   ![alt text](worldbank_dbt_project/snowflake_dbs.png)

## AWS ECR
   ![alt text](worldbank_dbt_project/aws_ecr_repo.png)

## Docker Image on AWS ECR
   ![alt text](worldbank_dbt_project/docker_image.png)

## Transformed and Deployed Dataset from AWS to Snowflake Production Table
  ![alt text](worldbank_dbt_project/snowflake_aws.png)

## Transformed Dim Tables   
![alt text](worldbank_dbt_project/dim_tables.png)

## World_Bank GDP Dashboard
  ![alt text](worldbank_dbt_project/dashboard.png)

## Selected World Bank GDP Dashboard
  ![alt text](worldbank_dbt_project/dashboard1.png)

## dbt lineage diagram
  ![alt text](worldbank_dbt_project/lineage.png)

## 📅 Step-by-Step Guide

1. 📂 Prepare Local Files

CSV: world_bank_gdp.csv inside:

worldbank_dbt_project/seeds/world_bank_gdp.csv

Environment Variables: .env

ACCOUNT=********
USER=********
PASSWORD=********
ROLE=********
DATABASE=WORLD_BANK_PROJECT
WAREHOUSE=********
SCHEMA=********

## Profile (profiles.yml):

worldbank_dbt_project_snowflake:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: "{{ env_var('ACCOUNT') }}"
      user: "{{ env_var('USER') }}"
      password: "{{ env_var('PASSWORD') }}"
      role: "{{ env_var('ROLE') }}"
      database: "{{ env_var('DATABASE') }}"
      warehouse: "{{ env_var('WAREHOUSE') }}"
      schema: "{{ env_var('SCHEMA') }}"
      threads: 12

## 2. 🚚 Load CSV to Snowflake with Airbyte

In Airbyte:

Source: File (CSV)

Path: /local/world_bank_gdp.csv

Destination: Snowflake

Namespace: Destination-defined

Schedule: Automated (every 24 hours)

Mount CSV directory in Docker:

# docker-compose.override.yml
services:
  airbyte-server:
    volumes:
      - ./worldbank_dbt_project/seeds:/local
  airbyte-worker:
    volumes:
      - ./worldbank_dbt_project/seeds:/local

Trigger sync from Airbyte UI to populate PUBLIC.world_bank_gdp

## 3. 💡 Build Transformations with dbt

Folder Structure:

models/
├── staging/
│   ├── stg_world_bank_gdp.sql
├── marts/
│   ├── dim_country.sql
│   ├── dim_year.sql
│   ├── dim_indicator.sql
│   ├── fct_world_bank_metrics.sql  # Incremental
│   ├── one_big_table.sql           # Incremental
│   └── top_countries_by_gdp.sql
├── insights/
│   ├── gdp_growth_last_10_years.sql
│   ├── gdp_vs_population_inflation.sql
│   ├── top_10_global_gdp_each_year.sql

Incremental Config Example:

{{ config(
  materialized='incremental',
  unique_key='country_key || year'
) }}

Snapshot:

-- snapshots/dim_year_snapshot.sql
{% snapshot dim_year_snapshot %}
{%
  config(
    target_database='WORLD_BANK_PROJECT',
    target_schema='MART',
    unique_key='year',
    strategy='check',
    check_cols=['year']
  )
%}

SELECT * FROM {{ ref('dim_year') }}
{% endsnapshot %}

Run & Test:

dbt deps
dbt seed
dbt run
dbt snapshot
dbt test

## 4. 🐳 Package and Deploy with Docker & AWS

Dockerfile:

FROM ghcr.io/dbt-labs/dbt-snowflake:1.6.5
WORKDIR /app
COPY . /app
CMD ["dbt", "run"]

Build Docker Image:

docker build -t worldbank-dbt .

Create ECR Repo:

aws ecr create-repository --repository-name worldbank-dbt

Authenticate and Push:

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <your-account-id>.dkr.ecr.us-east-1.amazonaws.com

docker tag worldbank-dbt:latest <your-account-id>.dkr.ecr.us-east-1.amazonaws.com/worldbank-dbt

docker push <your-account-id>.dkr.ecr.us-east-1.amazonaws.com/worldbank-dbt

Deploy to ECS:

Create ECS Task using EC2

Use the ECR image URL

Set container overrides to run:

dbt run
