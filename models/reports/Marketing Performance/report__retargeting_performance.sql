SELECT
    campaign_id,
    campaign_name,
    targeting_strategy,
    channel,

    COUNT(DISTINCT customer_id) as targeted_customers,

    COUNT(DISTINCT CASE WHEN order_id IS NOT NULL THEN customer_id END) as returned_customers,

    CASE WHEN COUNT(DISTINCT customer_id) = 0 THEN NULL
         ELSE ROUND(
            100.0 * COUNT(DISTINCT CASE WHEN order_id IS NOT NULL THEN customer_id END) / COUNT(DISTINCT customer_id),2) END as return_rate_percentage,

    ROUND(SUM(CASE WHEN order_id IS NOT NULL THEN total_amount 
        ELSE 0 END),0) as total_spent_after_retargeting,

    ROUND(AVG(CASE WHEN order_id IS NOT NULL THEN DATE_DIFF('minute', retargeting_datetime, order_datetime) 
        ELSE NULL END),0) as avg_time_to_return_minutes

FROM {{ ref('model_mart__retargeting_behavior') }} 
GROUP BY
    campaign_id,
    campaign_name,
    targeting_strategy,
    channel
ORDER BY
    total_spent_after_retargeting DESC
