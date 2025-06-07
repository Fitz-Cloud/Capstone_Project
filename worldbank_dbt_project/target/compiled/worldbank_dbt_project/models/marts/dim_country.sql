

select distinct
  country_key,
  country_name
from WORLD_BANK_PROJECT.MART_staging.stg_world_bank_gdp
where country_key is not null