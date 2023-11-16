
  select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

with child as (
    select promo_id as from_field
    from ALUMNO14_DEV_BRONZE_DB.sql_server_dbo.orders
    if  length(promo_id)>0
),

parent as (
    select promo_id as to_field
    from ALUMNO14_DEV_SILVER_DB.dbt_davidgarciaconejero.stg_promos
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



      
    ) 