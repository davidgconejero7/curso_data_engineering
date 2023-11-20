with 

source as (

    select * from {{ source('sql_server_dbo', 'orders') }}

),

renamed as (

    select
        order_id,
        decode(shipping_service,'','not service', shipping_service)as shipping_service,
        shipping_cost,
        address_id,
        created_at,
        decode(promo_id,'', '9999', promo_id),
        decode(estimated_delivery_at, NULL, '9999', estimated_delivery_at) as estimated_delivery_at,
        order_cost,
        user_id,
        order_total,
        decode(delivered_at, NULL, '9999', delivered_at) as delivered_at,
        decode(tracking_id,'','not date',tracking_id) as tracking_id,
        status,
        _fivetran_deleted,
        _fivetran_synced
 
    from source

)


renamed casted as(
    select
    cast(order_id as varchar (50)) as id_order,
    cast(shipping_service as varchar(50)),
    cast(shipping_cost as float),
    cast(address_id as varchar(50)),
    cast(created_at as timestamp_ntz),
    cast({{ dbt_utils.generate_surrogate_key(["promo_id"]) }} as varchar(50)) as id_promo,
    cast(estimated_delivery_at as timestamp_ntz),
    cast(order_cost as float),
    cast(user_id as varchar(50)) as id_user,
    cast

)

select * from renamed


