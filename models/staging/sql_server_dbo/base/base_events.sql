
with 
 
 source as (select * from {{ source("sql_server_dbo", "events") }}),
 

renamed as (

    select
        event_id as id_event,
        page_url,
        event_type,
        user_id as id_user,
        decode(product_id, null , 'not id_product', product_id) as id_product,
        session_id as id_session,
        cast(created_at as timestamp_ntz) as created_at_utc,
        decode(order_id,null, 'not id_order', order_id) as id_order,
        concat( id_order, ' - ', id_product) as order_products,
        _fivetran_deleted,
        _fivetran_synced

    from source
)
select * from renamed
