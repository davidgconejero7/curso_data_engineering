with
    
   source as (select * from {{ ref("stg_orders") }}),

renamed2 as(

        select
        orders.id_order,
        id_product,
        order_products,
        quantity,
        promos.id_promo,
        promos.id_status,
        order_cost_euros,
        order_total_euros,
        orders._fivetran_synced

    from {{ ref("stg_orders") }} orders
     left join {{ ref('stg_promos')}} promos
    on orders.id_promo=promos.id_promo
    left join {{ ref('stg_order_items')}} oi
    on orders.id_order=oi.id_order



)

select * from renamed2



