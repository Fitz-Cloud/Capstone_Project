{{ config(materialized='view') }}

select
  cast(DATE as integer) as year,
  COUNTRY as country_name,
  COUNTRYISO3CODE as country_key,
  cast(GDP as float) as gdp_usd,
  INFLATION as inflation_code,
  POPULATION as population_code
from {{ source('public', 'WORLD_BANK_GDP') }}
where GDP is not null
