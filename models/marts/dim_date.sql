with

 source as (select * from {{ ref("stg_date") }}),

 renamed as(

select
      date,
      day_of_week,
      day_of_month,
      week_of_year,
      month_of_year,
      year_number,
      quarter_of_the_year

    from {{ ref("stg_date") }} 
 )

select*from renamed

