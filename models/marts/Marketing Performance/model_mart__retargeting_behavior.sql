SELECT
    customer_id,
    campaign_id,
    campaign_name,
    targeting_strategy,
    channel,
    retargeting_datetime,
    order_id,
    order_datetime,
    total_amount
FROM {{ ref('model_int__retargeting_customer_orders') }}
WHERE row_num = 1 OR row_num IS NULL
