



select
    1
from WORLD_BANK_PROJECT.MART_staging.stg_world_bank_gdp

where not(gdp_usd  > 0)

