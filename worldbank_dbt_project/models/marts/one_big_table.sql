{{ config(
    materialized='incremental',
    unique_key='concat(year, country_key)'
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
  --f.year,
  --f.country_key,
  --c.country_name,
  --f.inflation_code,
  --f.population_code,
  --f.gdp_usd
--from {{ ref('fct_world_bank_metrics') }} f
--left join {{ ref('dim_country') }} c
  --on f.country_key = c.country_key
