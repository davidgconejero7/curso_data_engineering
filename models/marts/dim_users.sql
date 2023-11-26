with 


   source as ( select * from {{ ref('stg_users') }}),



renamed as (

    select
        id_user,
        updated_at_date,
        updated_at_time_utc,
        id_address,
        last_name,
        created_at_date,
        created_at_time_utc,
        phone_number,
        total_orders,
        first_name,
        email,
        _fivetran_synced

    from {{ ref('stg_users') }} users
    left join {{ ref('stg_time')}} time
    on users.created_at_date=time.fecha_forecast

)

select * from renamed
