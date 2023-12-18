{% snapshot snapshot_products %}
{{ 
    config(
      target_schema='snapshots',
      unique_key='id_product',
      strategy='timestamp',
      updated_at='_fivetran_synced',
      invalidate_hard_deletes=True,
    ) 
    }}

select * from {{ ref('stg_products') }}

{% endsnapshot %}