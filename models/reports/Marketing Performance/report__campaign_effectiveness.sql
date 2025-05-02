SELECT
    campaign_id,
    campaign_name,
    start_date,
    end_date,
    impressions,
    clicks,
    conversions,
    total_ad_cost,
    total_revenue,
    cost_per_acquisition,
    return_on_ad_spend
FROM {{ ref('model_mart__campaign_metrics') }}