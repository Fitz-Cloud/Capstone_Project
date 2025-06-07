with gdp_growth as (
  select
    country_key,
    min(year) as start_year,
    max(year) as end_year,
    first_value(gdp_usd) over (partition by country_key order by year) as gdp_start,
    last_value(gdp_usd) over (partition by country_key order by year 
                              rows between unbounded preceding and unbounded following) as gdp_end
  from {{ ref('fct_world_bank_metrics') }}
  where year >= extract(year from current_date()) - 10
  group by country_key, year, gdp_usd
),

growth_calc as (
  select
    country_key,
    ((gdp_end - gdp_start) / nullif(gdp_start, 0)) * 100 as growth_pct
  from gdp_growth
)

select
  c.country_name,
  round(g.growth_pct, 2) as gdp_growth_percent
from growth_calc g
join {{ ref('dim_country') }} c on g.country_key = c.country_key
order by gdp_growth_percent desc

