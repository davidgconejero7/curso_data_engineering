with 

source  as (

    select * from {{ source('sql_server_dbo', 'users') }}

),


renamed as (

    select
        user_id as id_user,
        cast(updated_at as date) as updated_at_date,
        cast(updated_at as time) as updated_at_time_utc,
        address_id as id_address,
        last_name,
        cast(created_at as date) as created_at_date,
        cast(created_at as time) as created_at_time_utc,
        phone_number,
        decode(total_orders,NULL, '0', total_orders) as total_orders,
        first_name,
        email,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed
