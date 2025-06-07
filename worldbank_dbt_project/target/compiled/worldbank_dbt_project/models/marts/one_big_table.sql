

select
  year,
  country_key,
  inflation_code,
  population_code,
  gdp_usd
from WORLD_BANK_PROJECT.MART_staging.stg_world_bank_gdp










--

--select
  --f.year,
  --f.country_key,
  --c.country_name,
  --f.inflation_code,
  --f.population_code,
  --f.gdp_usd
--from WORLD_BANK_PROJECT.MART_mart.fct_world_bank_metrics f
--left join WORLD_BANK_PROJECT.MART_mart.dim_country c
  --on f.country_key = c.country_key