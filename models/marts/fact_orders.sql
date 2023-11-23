with
    
   source as (select * from {{ ref("stg_orders") }}),

renamed2 as(

        select
        id_order,
        shipping_service,
        shipping_cost_euros,
        id_address ,
        created_at_utc,
         id_promo,
        estimated_delivery_at_utc,
        order_cost_euros ,
        id_user,
        order_total_euros,
        delivered_at_utc,
        id_tracking,
        id_status,
        _fivetran_deleted,
        _fivetran_synced

    from {{ ref("stg_orders") }} orders
    left join {{ ref('stg_time')}} time
    on orders.created_at_utc=time.fecha_forecast

)

select * from renamed2



