with

 source as (select * from {{ ref("stg_time") }}),

 renamed as(

select
      time,
      hour_time

    from source
 )

select*from renamed
