WITH

source as (
    SELECT * FROM {{ source('source_ae_exam_db', 'campaign_master') }}
)


SELECT

    campaign_id,
    campaign_name,
    start_date,
    end_date,
    campaign_type,
    objective,
    channel,
    budget,
    cost_model,
    targeting_strategy,
    is_active

FROM source
