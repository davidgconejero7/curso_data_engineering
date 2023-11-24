with 


   source as ( select * from {{ ref('base_order_items') }}),


renamed as (

    select
        order_products,
        id_product,
        id_order,
        quantity,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed
