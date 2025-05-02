{{ 
    config(
        materialized='incremental',
        unique_key='order_id'
    ) 
}}

SELECT

    order_id,
    customer_id,
    restaurant_id,
    driver_id,
    order_datetime,
    pickup_datetime,
    delivery_datetime,
    order_status,
    delivery_zone,
    total_amount,
    payment_method,
    is_late_delivery,
    delivery_distance_km

FROM {{ source('source_ae_exam_db', 'order_transactions') }}

{% if is_incremental() %}

      WHERE order_datetime > (SELECT MAX(order_datetime) FROM {{ this }})
      
{% endif %}