with 

source as (select * from {{ source('sql_server_dbo', 'date_tiempo') }}),

renamed as (

    select
        zipcode,
        temperature,
        wind_speed,
        humidity,
        date,
        _fivetran_synced

    from source

)

select * from renamed
