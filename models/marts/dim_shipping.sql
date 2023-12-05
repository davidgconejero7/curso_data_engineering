with

    source as (select * from {{ ref("stg_orders") }}),

    renamed as (

        select
        id_order,
        shipping_service,
        shipping_cost_euros,
        id_address,
        id_tracking,
        id_status,
        created_at_date,
        created_at_time_utc,
        estimated_delivery_at_date,
        estimated_delivery_at_time_utc
    
        from source
    
    )
 

select *
from renamed