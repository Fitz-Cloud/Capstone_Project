
  
    

create or replace transient table WORLD_BANK_PROJECT.MART_insights.gdp_trend_by_country
    

    
    as (select
  f.year,
  c.country_name,
  f.gdp_usd
from WORLD_BANK_PROJECT.MART_mart.fct_world_bank_metrics f
join WORLD_BANK_PROJECT.MART_mart.dim_country c on f.country_key = c.country_key
where c.country_name in
('Nigeria', 'India', 'Brazil', 'Australia', 'United States', 'Mexico', 'Sweden', 'China', 'Japan', 'United Kingdom') 
order by c.country_name, f.year
    )
;


  