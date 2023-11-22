
with 

renamed as (

    select
        event_id,
        page_url,
        event_type,
        id_user,
        products.id_product,
        id_session,
        events.created_at_utc,
        id_order,
        order_items.order_products,
        events._fivetran_deleted,
        events._fivetran_synced

    from {{ref('base_events') }} events 
    left join {{ ref('base_users') }} users
    on events.id_user= users.id_user
    left join {{ ref('base_products') }} products
    on events.id_product=products.id_product
    left join {{ ref('base_orders_items') }} order_items
    on events.id_order=order_items.id_order
)

select * from renamed