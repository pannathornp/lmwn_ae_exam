WITH retargeting_events as (
    SELECT
        ci.customer_id,
        ci.campaign_id,
        cm.campaign_name,
        cm.targeting_strategy,
        cm.channel,
        ci.interaction_datetime as retargeting_datetime
    FROM {{ ref('model_stg__campaign_interactions') }} as ci
    LEFT JOIN {{ ref('model_stg__campaign_master') }} as cm 
      on ci.campaign_id = cm.campaign_id
    WHERE cm.campaign_type = 'retargeting'
),

customer_orders as (
    SELECT
        o.customer_id,
        o.order_id,
        o.order_datetime,
        o.total_amount
    FROM {{ ref('model_stg__order_transactions') }} as o
    WHERE o.order_status = 'completed'
)

SELECT
    re.customer_id,
    re.campaign_id,
    re.campaign_name,
    re.targeting_strategy,
    re.channel,
    re.retargeting_datetime,
    co.order_id,
    co.order_datetime,
    co.total_amount,
    -- find first order after retargeting
    ROW_NUMBER() OVER (
        PARTITION BY re.customer_id, re.campaign_id, re.retargeting_datetime
        ORDER BY co.order_datetime ASC
    ) as row_num
FROM retargeting_events re
LEFT JOIN customer_orders co
    on re.customer_id = co.customer_id
   AND co.order_datetime > re.retargeting_datetime
   -- 30dayss reuturn window
   AND co.order_datetime <= re.retargeting_datetime + INTERVAL '30 days'
