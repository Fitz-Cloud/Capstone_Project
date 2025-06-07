
  
    

create or replace transient table WORLD_BANK_PROJECT.MART_insights.gdp_vs_population_inflation
    

    
    as (select
  year,
  country_key,
  gdp_usd,
  population_code,
  inflation_code,
  case 
    when try_cast(population_code as float) is not null then try_cast(population_code as float)
    else null
  end as population_est,
  case 
    when try_cast(inflation_code as float) is not null then try_cast(inflation_code as float)
    else null
  end as inflation_est
from WORLD_BANK_PROJECT.MART_mart.fct_world_bank_metrics
where gdp_usd is not null
    )
;


  