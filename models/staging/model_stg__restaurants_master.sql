WITH

source as (
    SELECT * FROM {{ source('source_ae_exam_db', 'restaurants_master') }}
)



SELECT 

    restaurant_id,
    name as restaurant_name,
    category,
    city,
    average_rating as restaurant_rating,
    active_status,
    prep_time_min

FROM source
