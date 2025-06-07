select
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
from {{ ref('fct_world_bank_metrics') }}
where gdp_usd is not null
