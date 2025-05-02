WITH complaint_data as (

SELECT
	o.order_id,
	o.customer_id,
	o.restaurant_id,
    r.restaurant_name,
    r.restaurant_rating,
	o.driver_id,
	o.order_datetime,
	o.pickup_datetime,
	o.delivery_datetime,
	o.order_status,
	o.delivery_zone,
	o.total_amount,
	o.payment_method,
	o.is_late_delivery,
	o.delivery_distance_km,
    c.ticket_id,
    c.ticket_opened_datetime,
    c.time_to_resolve_minutes,
    c.first_complaint_datetime,
    c.issue_type,
    c.issue_sub_type,
    c.order_type,
    c.compensation_amount
FROM {{ ref('model_stg__order_transactions') }} as o
LEFT JOIN {{ ref('model_stg__restaurants_master') }} as r on o.restaurant_id = r.restaurant_id
LEFT JOIN {{ ref('model_int__customer_complaint') }} as c on o.order_id = c.order_id
)

SELECT 
    restaurant_id,
    restaurant_name,
	issue_type,
    count(ticket_id) as total_customer_complaint,
    COUNT(CASE WHEN issue_sub_type = 'cold' THEN 1 END) as cold,
    COUNT(CASE WHEN issue_sub_type = 'late' THEN 1 END) as late,
    COUNT(CASE WHEN issue_sub_type = 'no_mask' THEN 1 END) as no_mask,
    COUNT(CASE WHEN issue_sub_type = 'not_delivered' THEN 1 END) as not_delivered,
    COUNT(CASE WHEN issue_sub_type = 'overcharged' THEN 1 END) as overcharged,
    COUNT(CASE WHEN issue_sub_type = 'refund' THEN 1 END) as refund,
    COUNT(CASE WHEN issue_sub_type = 'rude' THEN 1 END) as rude,
    COUNT(CASE WHEN issue_sub_type = 'wrong_item' THEN 1 END) as wrong_item,
    ROUND(AVG(time_to_resolve_minutes),0) as avg_time_to_resolve_minutes,
    SUM(compensation_amount) as total_compensation,
    COUNT(ticket_id)/COUNT(order_id) * 100 as ratio_of_complaint_percent
FROM complaint_data
GROUP by restaurant_id, restaurant_name, issue_type
