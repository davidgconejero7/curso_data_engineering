
with 

    renamed as (

    select
        id_event,
        page_url,
        event_type,
        users.id_user,
        events.id_product,
        id_session,
        events.created_at_date,
        order_items.id_order,
        events.order_products,
        events._fivetran_synced

    from {{ref('stg_events') }} events 
    left join {{ ref('stg_users') }} users
    on events.id_user= users.id_user
    left join {{ ref('stg_products') }} products
    on events.id_product=products.id_product
    left join {{ ref('stg_order_items') }} order_items
    on events.id_order=order_items.id_order
    left join {{ ref('stg_time')}} time
    on events.created_at_date=time.fecha_forecast
),


        not_null as (

    select
        id_event,
        page_url,
        event_type,
        id_user,
        id_product,
        id_session,
        created_at_date,
        decode(id_order, null , 'not orders', id_order) as id_order,
        order_products,
        _fivetran_synced

    from renamed
)

select* from not_null