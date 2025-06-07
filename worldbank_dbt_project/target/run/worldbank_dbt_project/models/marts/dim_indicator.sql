
  
    

create or replace transient table WORLD_BANK_PROJECT.MART_mart.dim_indicator
    

    
    as (

select distinct
  inflation_code,
  population_code
from WORLD_BANK_PROJECT.MART_staging.stg_world_bank_gdp
where inflation_code is not null or population_code is not null
    )
;


  