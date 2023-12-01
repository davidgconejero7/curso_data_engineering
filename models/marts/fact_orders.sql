with
    
   source as (select * from {{ ref("stg_orders") }}),

renamed2 as(

        select
        orders.id_order,
        shipping_service,
        shipping_cost_euros,
        addresses.id_address ,
        created_at_date,
        created_at_time_utc,
        promos.id_promo,
        estimated_delivery_at_date,
        estimated_delivery_at_time_utc,
        order_cost_euros ,
        id_user,
        order_total_euros,
        delivered_at_date,
        delivered_at_time_utc,
        id_tracking,
        promos.id_status

    from {{ ref("stg_orders") }} orders
    left join {{ ref('stg_time')}} time
    on orders.created_at_date=time.fecha_forecast
    left join {{ ref('stg_addresses')}} addresses
    on orders.id_address=addresses.id_address
     left join {{ ref('stg_promos')}} promos
    on orders.id_promo=promos.id_promo



)

select * from renamed2



