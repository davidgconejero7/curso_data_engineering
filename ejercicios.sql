#1.1

select count(distinct(id_user))
from {{ ref("stg_users") }}


#1.2


select  avg(datediff(day,created_at_utc,delivered_at_utc))
from {{ ref("stg_orders") }}
where delivered_at_utc between '2020-01-01' and '2024-01-01'


#1.3
with

numeros as(

select 
id_user,
count(distinct (id_order)) as compras
from {{ ref("stg_orders") }}
group by id_user

),

resultados as(
select
case
    when count(compras)>=3 then +3
    else compras
    end as order_numbers,
    count(distinct (id_user))
from numeros
group by id_user

)

select * from resultados


#4 En promedio, ¿Cuántas sesiones únicas tenemos por hora?


whit

primero(

select 
distinct(id_session)
from  {{ref('dim_events') }}


)



