SELECT 
  c.driver_id,
  issue_type,
  count(ticket_id) as total_tickets,
  COUNT(CASE WHEN issue_sub_type = 'cold' THEN 1 END) as cold,
  COUNT(CASE WHEN issue_sub_type = 'late' THEN 1 END) as late,
  COUNT(CASE WHEN issue_sub_type = 'no_mask' THEN 1 END) as no_mask,
  COUNT(CASE WHEN issue_sub_type = 'not_delivered' THEN 1 END) as not_delivered,
  COUNT(CASE WHEN issue_sub_type = 'overcharged' THEN 1 END) as overcharged,
  COUNT(CASE WHEN issue_sub_type = 'refund' THEN 1 END) as refund,
  COUNT(CASE WHEN issue_sub_type = 'rude' THEN 1 END) as rude,
  COUNT(CASE WHEN issue_sub_type = 'wrong_item' THEN 1 END) as wrong_item,
  ROUND(AVG(csat_score),2) as csat_score,
  ROUND(AVG(time_to_resolve_minutes),0) as avg_time_to_resolve_minutes,
  ROUND(count(ticket_id)/nullif(AVG(total_delivered_orders),0) * 100 ,2) as ratio_of_complaint_percent,
  ROUND(AVG(CASE WHEN order_type = 'before complaint' THEN driver_rating END),1) as rating_before_complaint,
  ROUND(AVG(CASE WHEN order_type = 'after complaint' THEN driver_rating END),1) as rating_after_complaint
FROM {{ ref('model_int__customer_complaint') }} as c
LEFT join {{ ref('model_stg__drivers_master') }} as d ON c.driver_id = d.driver_id
GROUP BY c.driver_id,issue_type

