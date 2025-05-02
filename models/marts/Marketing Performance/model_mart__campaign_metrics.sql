SELECT
    cp.campaign_id,
    cm.campaign_name,
    cm.start_date,
    cm.end_date,
    cm.campaign_type,
    cm.objective,
    cm.channel,
    ROUND(cm.budget,0) as budget,
    cm.cost_model,
    cm.targeting_strategy,
    cm.is_active,
    cm.channel,
    cp.impressions,
    cp.clicks,
    cp.conversions,
    ROUND(cp.total_ad_cost,0) as total_ad_cost,
    ROUND(cp.total_revenue,0) as total_revenue,
    ROUND(cp.total_ad_cost / nullif(cp.conversions,0),0) AS cost_per_acquisition,
    ROUND(cp.total_revenue / nullif(cp.total_ad_cost,0),0) AS return_on_ad_spend
FROM {{ ref('model_int__campaign_performance') }} cp
LEFT JOIN {{ ref('model_stg__campaign_master') }} cm
    ON cp.campaign_id = cm.campaign_id