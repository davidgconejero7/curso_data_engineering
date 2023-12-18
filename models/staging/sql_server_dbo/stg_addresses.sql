with

 source as (select * from {{ source("sql_server_dbo", "addresses") }}),
   
    renamed as (

        select
            address_id as id_address,
            zipcode,
            country,
            address,
            state,
            _fivetran_deleted,
            _fivetran_synced

        from source
       
    )

select *
from renamed