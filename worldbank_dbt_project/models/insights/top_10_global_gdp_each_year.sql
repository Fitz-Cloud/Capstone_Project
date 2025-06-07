select *
from (
  select
    f.year,
    c.country_name,
    f.gdp_usd,
    rank() over (partition by f.year order by f.gdp_usd desc) as gdp_rank
  from {{ ref('fct_world_bank_metrics') }} f
  join {{ ref('dim_country') }} c on f.country_key = c.country_key
) ranked
where gdp_rank <= 10
order by year, gdp_rank
