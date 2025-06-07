{% snapshot dim_year_snapshot %}
{{
  config(
    target_schema='snapshots',
    unique_key='year',
    strategy='timestamp',
    updated_at='updated_at'
  )
}}

select
  year,
  gdp_usd,
  current_timestamp()::timestamp_ntz as updated_at
from {{ ref('stg_world_bank_gdp') }}

{% endsnapshot %}
