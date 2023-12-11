with

 source as (select * from {{ ref("stg_date_tiempo") }}),
   
    renamed as (

        select
            dt.zipcode,
            temperature,
            wind_speed,
            humidity,
            dt.date,
            dt._fivetran_synced

        from {{ ref("stg_date_tiempo") }} dt
        left join  {{ ref("stg_addresses") }} ad 
        on dt.zipcode=ad.zipcode
        left join {{ ref("dim_date") }} dat 
        on dt.date=dat.date
       
    )

select *
from renamed