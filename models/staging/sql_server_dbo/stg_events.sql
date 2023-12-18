with 
 
 source as (select * from {{ source("sql_server_dbo", "events") }}),
 

renamed as (

    select
        event_id as id_event,
        page_url,
        event_type,
        user_id as id_user,
        product_id,
        session_id as id_session,
        cast(created_at as date) as created_at_date,
        cast(created_at as time) as created_at_time_utc,
        order_id,
        concat(order_id, ' - ', product_id) as order_products,
        _fivetran_synced

    from source
),

decode as (

  select
        id_event,
        page_url,
        event_type,
        id_user,
        decode(product_id, '' , 'not id_product', product_id) as id_product,
        id_session,
        created_at_date,
        created_at_time_utc,
        decode(order_id,'', 'not id_order', order_id) as id_order,
        order_products,
        _fivetran_synced

    from renamed


)

select * from decode