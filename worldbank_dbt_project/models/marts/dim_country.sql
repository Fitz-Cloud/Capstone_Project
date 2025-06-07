{{ config(materialized='table') }}

select distinct
  country_key,
  country_name
from {{ ref('stg_world_bank_gdp') }}
where country_key is not null
