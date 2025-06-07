
  
    

create or replace transient table WORLD_BANK_PROJECT.MART_mart.dim_year
    

    
    as (

select distinct
  year
from WORLD_BANK_PROJECT.MART_staging.stg_world_bank_gdp
    )
;


  