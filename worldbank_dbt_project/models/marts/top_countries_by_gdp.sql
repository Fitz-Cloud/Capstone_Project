{{ config(materialized='table') }}

select
  f.country_key,
  c.country_name,
  sum(f.gdp_usd) as total_gdp
from {{ ref('fct_world_bank_metrics') }} f
join {{ ref('dim_country') }} c
  on f.country_key = c.country_key
group by f.country_key, c.country_name
order by total_gdp desc
