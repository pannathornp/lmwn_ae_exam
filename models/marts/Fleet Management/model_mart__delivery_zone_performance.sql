SELECT
  delivery_zone,
  count(order_id) as total_order,
  count(distinct driver_id) as total_driver,
  COUNT(CASE WHEN order_status = 'completed' THEN 1 END) as completed,
  COUNT(CASE WHEN order_status = 'canceled' THEN 1 END) as canceled,
  COUNT(CASE WHEN order_status = 'failed' THEN 1 END) as failed,
  round(COUNT(CASE WHEN order_status = 'completed' THEN 1 END) / count(order_id) * 100,2) as order_completion_rate_percent,
  round(avg(datediff('minute', pickup_datetime, delivery_datetime)),2) as avg_delivery_time_minute,
  round(COUNT(CASE WHEN order_status = 'canceled' THEN 1 END) / count(order_id) * 100,2) as order_canceled_rate_percent,
  round(COUNT(CASE WHEN order_status = 'failed' THEN 1 END) / count(order_id) * 100,2) as order_failed_rate_percent,
FROM {{ ref('model_stg__order_transactions') }}
GROUP by delivery_zone