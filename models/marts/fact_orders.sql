with
    
   source as (select * from {{ ref("stg_orders") }}),


renamed2 as(

        select
        id_order,
        id_address,
        created_at_date,
        created_at_time_utc,
        id_promo,
        estimated_delivery_at_date,
        estimated_delivery_at_time_utc,
        order_cost_euros,
        id_user,
        order_total_euros,
        delivered_at_date,
        delivered_at_time_utc,
        id_tracking,
        id_status,
        _fivetran_synced

    from source

)

select * from renamed2