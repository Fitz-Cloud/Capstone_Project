{{ config(materialized='table') }}

select distinct
  year
from {{ ref('stg_world_bank_gdp') }}
