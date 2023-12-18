{{ config(
    materialized='incremental'
    ) 
    }}

WITH dim_incremental_tiempo AS (
    SELECT * 
    FROM {{ ref ('stg_date_tiempo') }}
{% if is_incremental() %}

	  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}
    ),
   
    renamed as (

        select
            dt.zipcode,
            temperature,
            wind_speed,
            humidity,
            dt.date,
            dt._fivetran_synced

        from dim_incremental_tiempo dt
        left join  {{ ref("stg_addresses") }} ad 
        on dt.zipcode=ad.zipcode
        left join {{ ref("dim_date") }} dat 
        on dt.date=dat.date
       
    )

select *
from renamed