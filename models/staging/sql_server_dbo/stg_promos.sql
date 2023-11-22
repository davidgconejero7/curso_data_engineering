with

    source as (select * from {{ source("sql_server_dbo", "promos") }}),
    source as (select * from {{ source("sql_server_dbo", "orders") }}),

    renamed as (

        select
            {{ dbt_utils.generate_surrogate_key(["promo_id",'discount','status','_fivetran_deleted','_fivetran_synced']) }} as id_promo,
            promo_id as desc_id_promo,
            discount,
            {{ dbt_utils.generate_surrogate_key([ ('status')]) }} as id_status,
            _fivetran_deleted,
            _fivetran_synced
    
        from source
    
    )
 

select *
from renamed
union all
(
select 
'9999' as id_promo, 'Not promo' as desc_id_promo, '0' as discount, '0' as status, '0' as _fivetran_deleted, '0'as _fivetran_synced)





