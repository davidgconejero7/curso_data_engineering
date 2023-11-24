with

 source as (select * from {{ ref("stg_addresses") }}),
   
    renamed as (

        select
            addresses.id_address,
            decode(users.id_user, null, 'not user', users.id_user) as id_user,
            zipcode,
            country,
            address,
            state,
            addresses._fivetran_deleted,
            addresses._fivetran_synced

        from source addresses
        left join {{ ref('stg_users') }} users
        on addresses.id_address=users.id_address
       
    )

select *
from renamed