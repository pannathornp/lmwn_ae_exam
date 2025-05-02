  SELECT
    incentive_program,
    driver_id,
    bonus_amount,
    avg_delivery_assigned,
    avg_delivery_completed,
    driver_rating,
    total_revenue
FROM {{ ref('model_mart__driver_incentive') }}