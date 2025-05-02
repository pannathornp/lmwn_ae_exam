SELECT
  incentive_program,
  i.driver_id,
  ROUND(SUM(bonus_amount),2) as bonus_amount,
  ROUND(AVG(delivery_target),0) as avg_delivery_assigned,
  ROUND(AVG(actual_deliveries),2) as avg_delivery_completed,
  ROUND(AVG(driver_rating),1) as driver_rating,
  ROUND(SUM(total_amount),0) as total_revenue
FROM  {{ ref('model_stg__order_log_incentive_sessions_driver_incentive_logs') }} as i
LEFT JOIN {{ ref('model_stg__drivers_master') }} as d
on i.driver_id = d.driver_id
LEFT JOIN {{ ref('model_stg__order_transactions') }} as o
on i.driver_id = o.driver_id
WHERE order_status = 'completed'
GROUP by incentive_program,i.driver_id