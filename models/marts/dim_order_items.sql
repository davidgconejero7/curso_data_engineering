with 


   source as ( select * from {{ ref('stg_order_items') }}),


renamed as (

    select
        order_products,
        id_product,
        id_order,
        quantity,
        _fivetran_deleted,
        _fivetran_synced

    from {{ ref('stg_order_items') }} order_items
    left join {{ ref('stg_time')}} time
    on order_items._fivetran_synced=time.fecha_forecast

)

select * from renamed
