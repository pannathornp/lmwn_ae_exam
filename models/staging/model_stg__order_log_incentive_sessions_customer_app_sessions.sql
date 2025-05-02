WITH

source as (
    SELECT * FROM {{ source('source_ae_exam_db', 'order_log_incentive_sessions_customer_app_sessions') }}
)


SELECT

    session_id,
    customer_id,
    session_start,
    session_end,
    device_type,
    os_version,
    app_version,
    location

FROM source