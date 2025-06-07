
  
    

create or replace transient table WORLD_BANK_PROJECT.MART_mart.top_countries_by_gdp
    

    
    as (

select
  f.country_key,
  c.country_name,
  sum(f.gdp_usd) as total_gdp
from WORLD_BANK_PROJECT.MART_mart.fct_world_bank_metrics f
join WORLD_BANK_PROJECT.MART_mart.dim_country c
  on f.country_key = c.country_key
group by f.country_key, c.country_name
order by total_gdp desc
    )
;


  