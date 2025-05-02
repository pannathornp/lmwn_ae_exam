SELECT
    driver_id,
    AVG(DATE_DIFF('minute', pickup_datetime, delivery_datetime)) as avg_delivery_time_minute,
    AVG(delivery_distance_km) as avg_delivery_distance_km
FROM {{ ref('model_stg__order_transactions') }}
GROUP BY driver_id