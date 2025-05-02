WITH

source as (
    SELECT * FROM {{ source('source_ae_exam_db', 'order_log_incentive_sessions_driver_incentive_logs') }}
)


SELECT 

    log_id,
    driver_id,
    incentive_program,
    bonus_amount,
    applied_date,
    delivery_target,
    actual_deliveries,
    bonus_qualified,
    region

FROM source
