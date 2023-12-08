
with 

    source as (select * from {{ ref("stg_events") }}),


renamed as (

    select
        id_event,
        page_url,
        event_type,
        users.id_user,
        products.id_product,
        id_session,
        events.created_at_date,
        events.created_at_time_utc,
        orders.id_order,
        events.order_products,
        events._fivetran_synced

    from {{ref('stg_events') }} events 
    left join {{ ref('stg_users') }} users
    on events.id_user= users.id_user
    left join {{ ref('stg_products') }} products
    on events.id_product=products.id_product
    left join {{ ref('stg_orders') }} orders
    on events.id_order=orders.id_order
    left join {{ ref('stg_date')}} date
    on events.created_at_date=date.date
    left join {{ ref("stg_time") }} time
    on events.created_at_time_utc=time.time
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
        created_at_time_utc,
        decode(id_order, null , 'not orders', id_order) as id_order,
        _fivetran_synced

    from renamed
)

select* from not_null