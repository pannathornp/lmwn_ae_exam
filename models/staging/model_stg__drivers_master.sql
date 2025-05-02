WITH

source as (
    SELECT * FROM {{ source('source_ae_exam_db', 'drivers_master') }}
)


SELECT

    driver_id,
    join_date,
    vehicle_type,
    region,
    active_status,
    driver_rating,
    bonus_tier

FROM source
