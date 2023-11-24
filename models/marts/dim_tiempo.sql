with

 source as (select * from {{ ref("stg_time") }}),

 renamed as(

select
      time.fecha_forecast
    , id_date
    , anio
    , mes
    , desc_mes
    , id_anio_mes
    , dia_previo
    , anio_semana_dia
    , semana

    from {{ ref("stg_time") }} time
 )

select*from renamed

