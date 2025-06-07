





with validation_errors as (

    select
        country_name
    from WORLD_BANK_PROJECT.MART_insights.gdp_growth_last_10_years
    group by country_name
    having count(*) > 1

)

select *
from validation_errors


