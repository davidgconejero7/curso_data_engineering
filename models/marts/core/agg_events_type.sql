
with 

    source as (select * from {{ ref("stg_events") }}),

page_view as(
    select 
    id_user, count(distinct(page_url)) as page_view
    from {{ ref('fact_events') }} 
    group by id_user
),

add_to_cart as(
    select 
    id_user,count(event_type) as add_to_cart
    from {{ ref('fact_events') }} 
    where event_type='add_to_cart'
    group by id_user
),


checkout as(
    select 
    id_user,count(event_type) as checkout
    from {{ ref('fact_events') }} 
    where event_type='checkout'
    group by id_user
),

package_shipped as(
    select 
    id_user,count(event_type) as package_shipped
    from {{ ref('fact_events') }} 
    where event_type='package_shipped'
    group by id_user
),



renamed as (

    select
        distinct(id_session),
        events.id_user,
        first_name,
        last_name,
        page_view,
        add_to_cart,
        checkout,
        package_shipped

    from {{ref('stg_events') }} events 
    left join {{ref('stg_users') }} use 
    on events.id_user=use.id_user
    left join page_view
    on events.id_user=page_view.id_user
    left join add_to_cart
    on events.id_user=add_to_cart.id_user
    left join checkout
    on events.id_user=checkout.id_user
    left join package_shipped 
    on events.id_user=package_shipped.id_user
 
)



select* from renamed