SELECT 
    driver_id,
    issue_type,
    total_tickets,
    no_mask,
    rude,
    csat_score,
    avg_time_to_resolve_minutes,
    ratio_of_complaint_percent,
    rating_before_complaint,
    rating_after_complaint

FROM {{ ref('model_mart__customer_driver_complaint') }}
WHERE issue_type = 'rider'
