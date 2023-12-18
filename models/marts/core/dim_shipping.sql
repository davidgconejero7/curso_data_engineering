with

    source as (select * from {{ ref("stg_orders") }}),

    renamed as (

        select
        id_shipping_service,
        shipping_service,
        shipping_cost_euros,
        id_order,
        id_address,
        id_tracking,
        id_status,
        created_at_date,
        created_at_time_utc,
        estimated_delivery_at_date,
        estimated_delivery_at_time_utc
    
        from {{ ref("stg_orders") }} orders 
        left join {{ ref("dim_date") }} date
        on orders.created_at_date=date.date
        left join {{ ref("dim_time") }} time
        on orders.created_at_time_utc=time.time

    
    )
 

select *
from renamed