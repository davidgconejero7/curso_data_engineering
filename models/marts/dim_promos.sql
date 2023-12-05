with

    source as (select * from {{ ref("stg_promos") }}),

    renamed as (

        select
            id_promo,
            desc_id_promo,
            discount,
            id_status,
            _fivetran_deleted,
            _fivetran_synced
    
        from source
    
    )
 

select *
from renamed