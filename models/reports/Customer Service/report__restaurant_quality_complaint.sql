SELECT 
    restaurant_id,
    restaurant_name,
    total_customer_complaint,
    cold,
    wrong_item,
    avg_time_to_resolve_minutes,
    total_compensation,
    ratio_of_complaint_percent

FROM {{ ref('model_mart__customer_restaurant_complaint') }}
WHERE issue_type = 'food'

