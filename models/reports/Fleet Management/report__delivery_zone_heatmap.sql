SELECT 
  delivery_zone,
  total_order,
  total_driver,
  completed,
  canceled,
  failed,
  order_completion_rate_percent,
  avg_delivery_time_minute
 FROM {{ ref('model_mart__delivery_zone_performance') }}
