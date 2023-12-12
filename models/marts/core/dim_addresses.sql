with

 source as (select * from {{ ref("stg_addresses") }}),
   
    renamed as (

        select
            id_address,
            zipcode,
            country,
            address,
            state,
            _fivetran_synced

        from source 
       
    )

select *
from renamed