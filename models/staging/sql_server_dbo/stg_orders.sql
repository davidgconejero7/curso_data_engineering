{{
    config(
        materialized='incremental',
        unique_key='id_order',
        on_schema_change='fail'
    )
}}



WITH stg_orders AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'orders') }}
{% if is_incremental() %}

	  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}
    ),


renamed as (

    select
        order_id as id_order,
        decode(shipping_service,'','not service', shipping_service)as shipping_service,
        shipping_cost,
        address_id as id_address,
        created_at,
        decode(promo_id,'', '9999', promo_id) as id_promo,
        decode(estimated_delivery_at, NULL, '9999', estimated_delivery_at) as estimated_delivery_at,
        order_cost,
        user_id as id_user,
        order_total,
        decode(delivered_at, NULL, '9999', delivered_at) as delivered_at,
        decode(tracking_id,'','not date',tracking_id) as id_tracking,
        status,
        _fivetran_deleted,
        _fivetran_synced
 
    from stg_orders

),


renamed2 as(
    select
        id_order,
        shipping_service,
        shipping_cost as shipping_cost_euros,
        id_address ,
        cast(created_at as timestamp_ntz) as created_at_utc,
        cast( case 
                when id_promo= '9999' then '9999'
                else {{dbt_utils.generate_surrogate_key(["id_promo"]) }}
                end as varchar(50)) as id_promo,
        cast(estimated_delivery_at as timestamp_ntz) as  estimated_delivery_at_utc,
        order_cost as order_cost_euros ,
        id_user,
        order_total as order_total_euros,
        cast(delivered_at as timestamp_ntz) as delivered_at_utc,
        id_tracking,
        status,
        _fivetran_deleted,
        _fivetran_synced

    from renamed

)

select * from renamed2


