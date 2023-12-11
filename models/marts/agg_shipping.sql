
with


 shipping_services AS (
    select distinct
        id_shipping_service,
        shipping_service,
        sum(shipping_cost_euros) as total_shipping_cost_euros,
        count(shipping_service) as total_shipping_service,
        avg(shipping_cost_euros) as avg_shipping_service_cost

    from {{ ref('stg_orders') }}
    group by id_shipping_service, shipping_service
)

select
    id_shipping_service,
    shipping_service,
    total_shipping_cost_euros,
    total_shipping_service,
    avg_shipping_service_cost
from shipping_services