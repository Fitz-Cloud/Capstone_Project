
  
    

create or replace transient table WORLD_BANK_PROJECT.MART_mart.fct_world_bank_metrics
    

    
    as (

select
  year,
  country_key,
  inflation_code,
  population_code,
  gdp_usd
from WORLD_BANK_PROJECT.MART_staging.stg_world_bank_gdp







--

--select
  year,
  --country_key,
  --inflation_code,
  --population_code,
  --gdp_usd
--from WORLD_BANK_PROJECT.MART_staging.stg_world_bank_gdp
--where gdp_usd is not null
    )
;


  