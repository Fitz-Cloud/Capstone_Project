with ranked_gdp as (
  select
    f.year,
    c.country_name,
    f.gdp_usd,
    rank() over (partition by f.year order by f.gdp_usd desc) as rank
  from WORLD_BANK_PROJECT.MART_mart.fct_world_bank_metrics f
  join WORLD_BANK_PROJECT.MART_mart.dim_country c on f.country_key = c.country_key
  where f.year = 2023  -- 🔁 Replace with dynamic input
)

select *
from ranked_gdp
--where country_name = 'Nigeria'