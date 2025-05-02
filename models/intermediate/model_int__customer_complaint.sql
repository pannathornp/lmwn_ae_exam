WITH complaint_data as (

  SELECT 
  ticket_id,
  order_id,
  driver_id,
  opened_datetime,
  resolved_datetime,
  issue_type,
  issue_sub_type,
  compensation_amount,
  MIN(opened_datetime) OVER (PARTITION by driver_id) as first_complaint_datetime,
  csat_score,
  DATE_DIFF('minute', opened_datetime, resolved_datetime) as time_to_resolve_minutes
  FROM {{ ref('model_stg__support_tickets') }}

)

SELECT 
  o.order_id,
  o.driver_id,
  o.order_datetime,
  o.order_status,
  o.delivery_distance_km,
  c.csat_score,
  c.ticket_id,
  c.opened_datetime as ticket_opened_datetime,
  c.first_complaint_datetime,
  c.issue_type,
  c.issue_sub_type,
  c.time_to_resolve_minutes,
  c.compensation_amount,
  COUNT(o.order_id) over (PARTITION by o.driver_id) as total_delivered_orders,
    CASE 
      WHEN order_datetime < first_complaint_datetime THEN 'before complaint' 
    ELSE 'after complaint' END as order_type
FROM {{ ref('model_stg__order_transactions') }} as o
LEFT JOIN complaint_data c ON o.order_id = c.order_id
