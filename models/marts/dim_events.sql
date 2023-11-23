
with 

renamed as (

    select
        id_event,
        page_url,
        event_type,
        users.id_user,
        products.id_product,
        id_session,
        events.created_at_utc,
        order_items.id_order,
        events.order_products,
        events._fivetran_deleted,
        events._fivetran_synced

    from {{ref('stg_events') }} events 
    left join {{ ref('stg_users') }} users
    on events.id_user= users.id_user
    left join {{ ref('stg_products') }} products
    on events.id_product=products.id_product
    left join {{ ref('stg_order_items') }} order_items
    on events.id_order=order_items.id_order
)

select * from renamed