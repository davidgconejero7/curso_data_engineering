with 

source as (

    select * from {{ source('sql_server_dbo', 'products') }}

),

renamed as (

    select
        product_id as id_product,
        price as price_euro,
        name,
        inventory,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed