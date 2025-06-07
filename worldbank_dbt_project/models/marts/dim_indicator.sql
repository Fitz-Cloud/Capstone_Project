{{ config(materialized='table') }}

select distinct
  inflation_code,
  population_code
from {{ ref('stg_world_bank_gdp') }}
where inflation_code is not null or population_code is not null
