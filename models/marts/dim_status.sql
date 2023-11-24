select
distinct(id_status)
from {{ ref("stg_promos") }}


union all


select 
distinct(id_status)
from {{ ref("stg_orders") }}
