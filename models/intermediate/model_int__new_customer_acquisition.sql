
WITH new_customer_acquisition as (
SELECT
    o.order_id,
    o.customer_id,
    ci.campaign_id,
    cm.channel,
    ci.platform,
    o.order_datetime,
    ci.interaction_datetime,
    ad_cost,
    revenue,
    order_status,
    is_new_customer
FROM {{ ref('model_stg__order_transactions') }} as o
LEFT JOIN {{ ref('model_stg__campaign_interactions') }} ci 
on o.order_id = ci.order_id
LEFT JOIN  {{ ref('model_stg__campaign_master') }} as cm 
on cm.campaign_id = ci.campaign_id
WHERE o.order_status = 'completed' and is_new_customer = true
)

SELECT 
campaign_id,
channel,
platform,
customer_id,
MIN(interaction_datetime) as first_interaction_datetime,
MIN(order_datetime) as first_order_datetime,
MAX(order_datetime) as last_order_datetime,
AVG(revenue) as avg_purchase_value,
COUNT(customer_id) as number_of_repeat_order,
SUM(ad_cost) as total_ad_cost,
FROM new_customer_acquisition
GROUP by campaign_id,channel,platform,customer_id
