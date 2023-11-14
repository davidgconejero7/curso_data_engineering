
with 

users  as(
    select *from {{ source('sql_server_dbo', 'users')}}
) ,

addresses as (

    select * from {{ source('sql_server_dbo', 'addresses') }}
),

add_user as(

select a.address_id, user_id
from stg_addresses a
inner join stg_users b
on a.address_id=b.address_id

)

select *from add_user