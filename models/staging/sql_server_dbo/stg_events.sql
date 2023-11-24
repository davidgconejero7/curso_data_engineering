
with 

   source as ( select * from {{ ref('base_events') }}),

renamed as (

    select
        id_event,
        page_url,
        event_type,
        id_user,
        id_product,
        id_session,
        created_at_utc,
        id_order,
        order_products,
        _fivetran_deleted,
        _fivetran_synced

    from source
)
select * from renamed
