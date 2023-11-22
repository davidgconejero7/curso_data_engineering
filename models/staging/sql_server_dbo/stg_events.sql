
with 


renamed as (

    select
        event_id,
        page_url,
        event_type,
        users.user_id as id_user,
        decode(products.product_id, null , 'not id_product', products.product_id) as id_product,
        session_id as id_session,
        cast(events.created_at as timestamp_ntz) as created_at_utc,
        decode(order_items.order_id,null, 'not id_order', order_items.order_id) as id_order,
        concat( id_order, ' - ', id_product) as order_products,
        events._fivetran_deleted,
        events._fivetran_synced

    from {{source('sql_server_dbo', 'events') }} events 
    left join {{ source('sql_server_dbo', 'users') }} users
    on events.user_id= users.user_id
    left join {{ source('sql_server_dbo', 'products') }} products
    on events.product_id=products.product_id
    left join {{ source('sql_server_dbo', 'order_items') }} order_items
    on events.order_id=order_items.order_id
)

select * from renamed
