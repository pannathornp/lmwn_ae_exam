{{ 
    config(
        materialized='incremental',
        unique_key='ticket_id'
    ) 
}}

SELECT 
    ticket_id,
    order_id,
    customer_id,
    driver_id,
    restaurant_id,
    issue_type,
    issue_sub_type,
    channel,
    opened_datetime,
    resolved_datetime,
    status,
    csat_score,
    compensation_amount,
    resolved_by_agent_id

FROM {{ source('source_ae_exam_db', 'support_tickets') }}

{% if is_incremental() %}

      WHERE opened_datetime > (SELECT max(opened_datetime) FROM {{ this }})
      
{% endif %}