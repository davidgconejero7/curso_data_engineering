with
    
   source as (select * from {{ source("sql_server_dbo", "orders") }}),


renamed as (

    select
        order_id as id_order,
        decode(shipping_service,'','not service', shipping_service)as shipping_service,
        shipping_cost as shipping_cost_euros,
        address_id as id_address,
        cast(created_at as date) as created_at_date,
        cast(created_at as time) as created_at_time_utc,
        decode(promo_id,'', '9999', promo_id) as id_promo,
        cast(estimated_delivery_at as date) as  estimated_delivery_at_date,
        cast(estimated_delivery_at as time) as  estimated_delivery_at_time_utc,
        order_cost,
        user_id as id_user,
        order_total,
        cast(delivered_at as date) as delivered_at_date,
        cast(delivered_at as time) as delivered_at_time_utc,
        decode(tracking_id,'','not date',tracking_id) as id_tracking,
        status,
        _fivetran_deleted,
        _fivetran_synced 
 
 
    from  source

),


renamed2 as(

        select
        id_order,
        shipping_service,
        shipping_cost_euros,
        id_address,
        created_at_date,
        created_at_time_utc,
        cast( case 
                when id_promo= '9999' then '9999'
                else {{dbt_utils.generate_surrogate_key(["id_promo"]) }}
                end as varchar(50)) as id_promo,
        estimated_delivery_at_date,
        estimated_delivery_at_time_utc,
        order_cost as order_cost_euros,
        id_user,
        order_total as order_total_euros,
        delivered_at_date,
        delivered_at_time_utc,
        id_tracking,
        {{ dbt_utils.generate_surrogate_key([ ('status')]) }} as id_status,
        _fivetran_deleted,
        _fivetran_synced

    from renamed

)

select * from renamed2
