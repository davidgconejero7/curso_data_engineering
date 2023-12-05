with
    
   source as (select * from {{ ref("stg_orders") }}),

renamed2 as(

        select
        oi.id_order,
        promos.id_promo,
        promos.id_status,
        order_cost_euros,
        users.id_user,
        order_total_euros,
        orders._fivetran_synced

    from {{ ref("stg_orders") }} orders
    left join {{ ref('stg_addresses')}} addresses
    on orders.id_address=addresses.id_address
     left join {{ ref('stg_promos')}} promos
    on orders.id_promo=promos.id_promo
    left join {{ ref('stg_order_items')}} oi
    on orders.id_order=oi.id_order
    left join {{ ref('stg_users')}} users
    on orders.id_user=users.id_user



)

select * from renamed2



