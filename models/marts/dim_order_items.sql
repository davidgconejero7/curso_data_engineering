with 


   source as ( select * from {{ ref('stg_order_items') }}),


renamed as (

    select
        order_products,
        id_product,
        id_order,
        quantity,
        _fivetran_synced

)

select * from renamed
