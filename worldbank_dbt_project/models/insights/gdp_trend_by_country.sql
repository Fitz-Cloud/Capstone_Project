select
  f.year,
  c.country_name,
  f.gdp_usd
from {{ ref('fct_world_bank_metrics') }} f
join {{ ref('dim_country') }} c on f.country_key = c.country_key
where c.country_name in
('Nigeria', 'India', 'Brazil', 'Australia', 'United States', 'Mexico', 'Sweden', 'China', 'Japan', 'United Kingdom') 
order by c.country_name, f.year
