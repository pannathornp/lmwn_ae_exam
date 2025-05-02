SELECT 
    d.driver_id,
    d.join_date,
    d.region,
    ROUND(AVG(driver_rating), 1) as driver_rating,
    ROUND(SUM(bonus_amount), 0) as bonus_amount,
    ROUND(AVG(delivery_target), 0) as delivery_assigned,
    ROUND(AVG(actual_deliveries), 0) as delivery_completed
FROM {{ ref('model_stg__drivers_master') }} as d
LEFT JOIN {{ ref('model_stg__order_log_incentive_sessions_driver_incentive_logs') }} i
    ON d.driver_id = i.driver_id
GROUP BY
    d.driver_id,
    d.join_date,
    d.region