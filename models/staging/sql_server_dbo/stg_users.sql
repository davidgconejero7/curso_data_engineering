with 

source  as (

    select * from {{ source('sql_server_dbo', 'users') }}

),

source  as (

    select * from {{ source('sql_server_dbo', 'addresses') }}

),



renamed as (

    select
        user_id,
        updated_at,
        users.address_id,
        addresses.zipcode,
        addresses.state,
        addresses.country
        last_name,
        created_at,
        phone_number,
        total_orders,
        first_name,
        email,
        users._fivetran_deleted,
        users._fivetran_synced

    from {{ source('sql_server_dbo', 'users') }} users
    left join {{ source('sql_server_dbo', 'addresses') }} addresses
    on users.address_id=addresses.address_id


)

select * from renamed

