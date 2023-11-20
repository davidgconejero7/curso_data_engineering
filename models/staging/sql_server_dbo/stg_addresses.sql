with

    source as (select * from {{ source("sql_server_dbo", "addresses") }}),

    source as (

    select * from {{ source('sql_server_dbo', 'users') }}

),

    renamed as (

        select
            addresses.address_id,
            decode(users.user_id,null ,'not user', users.user_id)as user_id,
            zipcode,
            country,
            address,
            state,
            addresses._fivetran_deleted,
            addresses._fivetran_synced

        from {{ source("sql_server_dbo", "addresses") }} addresses
        left join {{ source('sql_server_dbo', 'users') }} users
        on addresses.address_id=users.address_id

    )

select *
from renamed
