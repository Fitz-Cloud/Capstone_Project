
  
    

create or replace transient table WORLD_BANK_PROJECT.MART_insights.top_10_global_gdp_each_year
    

    
    as (select *
from (
  select
    f.year,
    c.country_name,
    f.gdp_usd,
    rank() over (partition by f.year order by f.gdp_usd desc) as gdp_rank
  from WORLD_BANK_PROJECT.MART_mart.fct_world_bank_metrics f
  join WORLD_BANK_PROJECT.MART_mart.dim_country c on f.country_key = c.country_key
) ranked
where gdp_rank <= 10
order by year, gdp_rank
    )
;


  