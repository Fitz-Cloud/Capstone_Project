{{ config(
    materialized='incremental',
    unique_key=['year', 'country_key']
) }}

select
  year,
  country_key,
  inflation_code,
  population_code,
  gdp_usd
from {{ ref('stg_world_bank_gdp') }}

{% if is_incremental() %}
  where year > (select max(year) from {{ this }})
{% endif %}





--{{ config(materialized='table') }}

--select
  year,
  --country_key,
  --inflation_code,
  --population_code,
  --gdp_usd
--from {{ ref('stg_world_bank_gdp') }}
--where gdp_usd is not null