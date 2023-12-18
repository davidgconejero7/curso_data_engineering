{{ config(
    materialized='incremental'
    ) 
    }}

WITH stg_incremental_tiempo AS (
    SELECT * 
    FROM {{ source ('sql_server_dbo','date_tiempo') }}
{% if is_incremental() %}

	  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}
    ),

renamed as (

    select
        zipcode,
        temperature,
        wind_speed,
        humidity,
        date,
        _fivetran_synced

    from stg_incremental_tiempo

)

select * from renamed
