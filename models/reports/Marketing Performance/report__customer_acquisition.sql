
SELECT

campaign_id,
channel,
platform,
customer_id,
ROUND(avg_purchase_value,0) AS avg_purchase_value,
number_of_repeat_order,
ROUND(total_ad_cost,0) AS total_ad_cost,
time_to_purchase,
active_after_first_purchase

FROM {{ ref('model_mart__new_customer_acquisition') }}