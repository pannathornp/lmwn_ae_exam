WITH

source as (
    SELECT * FROM {{ source('source_ae_exam_db', 'order_log_incentive_sessions_order_status_logs') }}
)


SELECT

    log_id,
    order_id,
    status,
    status_datetime,
    updated_by

FROM source