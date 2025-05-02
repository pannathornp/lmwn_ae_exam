{{ 
    config(
        materialized='incremental',
        unique_key='interaction_id'
    ) 
}}

  SELECT
        interaction_id,
        campaign_id,
        customer_id,
        interaction_datetime,
        event_type,
        platform,
        device_type,
        ad_cost,
        order_id,
        is_new_customer,
        revenue,
        session_id
    FROM {{ source('source_ae_exam_db', 'campaign_interactions') }}


{% if is_incremental() %}

      WHERE interaction_datetime > (SELECT MAX(interaction_datetime) FROM {{ this }})
      
{% endif %}
