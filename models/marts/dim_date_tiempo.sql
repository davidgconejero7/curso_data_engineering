with

 source as (select * from {{ ref("stg_date_tiempo") }}),
   
    renamed as (

        select
            zipcode,
            temperature,
            wind_speed,
            humidity,
             date,
            _fivetran_synced

        from {{ ref("stg_date_tiempo") }} 
       
    )

select *
from renamed