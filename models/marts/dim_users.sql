with 


   source as ( select * from {{ ref('stg_users') }}),

total_order as(
    select 
    id_user,
    count(distinct(id_order)) as total_order
    from {{ ref('stg_orders') }} 
    group by id_user
),


renamed as (

    select
        distinct(users.id_user),
        last_name,
        first_name,
        users.id_address,
        phone_number,
        email,
        total_order,
        updated_at_date,
        updated_at_time_utc,
        users.created_at_date,
        users.created_at_time_utc,
        users._fivetran_synced

    from {{ ref('stg_users') }} users
    left join {{ ref('dim_date')}} date
    on users.created_at_date=date.date
    left join {{ ref("stg_orders") }} orders
    on users.id_user=orders.id_user
    left join total_order
    on users.id_user=total_order.id_user
    left join {{ ref("dim_time") }} time
    on users.created_at_time_utc=time.time


)

select * from renamed
