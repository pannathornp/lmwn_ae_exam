SELECT
    campaign_id,
    COUNT(CASE WHEN event_type = 'impression' THEN 1 END) as impressions,
    COUNT(CASE WHEN event_type = 'click' THEN 1 END) as clicks,
    COUNT(CASE WHEN event_type = 'conversion' THEN 1 END) as conversions,
    SUM(ad_cost) as total_ad_cost,
    SUM(revenue) as total_revenue
FROM {{ ref('model_stg__campaign_interactions') }}
GROUP BY campaign_id