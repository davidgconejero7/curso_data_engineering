
with

total_shipping_cost_euros as(
    select
    id_shipping_service, 
    shipping_service,
    sum(shipping_cost_euros) as total_shipping_cost_euros
    from {{ ref('stg_orders') }}
    group by id_shipping_service, shipping_service
),

total_shipping_service as(
    select 
    id_shipping_service, 
    shipping_service,
    count(shipping_service) as total_shipping_service
    from {{ ref('stg_orders') }}
    group by id_shipping_service, shipping_service
),

avg_shipping_service_cost as(
    select 
    id_shipping_service, 
    shipping_service,
    avg(shipping_cost_euros) as avg_shipping_service_cost
    from {{ ref('stg_orders') }}
    group by id_shipping_service, shipping_service
),

renamed as (

    select
        distinct(ors.id_shipping_service),
        ors.shipping_service,
        total_shipping_cost_euros,
        total_shipping_service,
        avg_shipping_service_cost

    from {{ ref('stg_orders') }} ors
    left join total_shipping_cost_euros ts 
    on ors.id_shipping_service=ts.id_shipping_service
    left join total_shipping_service tss 
    on ors.id_shipping_service=tss.id_shipping_service
    left join avg_shipping_service_cost avsc
    on ors.id_shipping_service=avsc.id_shipping_service

)

select * from renamed