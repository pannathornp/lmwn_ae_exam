WITH

source as (
    SELECT * FROM {{ source('source_ae_exam_db', 'customers_master') }}
)


SELECT

    customer_id,
    signup_date,
    customer_segment,
    status,
    referral_source,
    birth_year,
    gender,
    preferred_device
    
FROM source
