WITH customer_life_time as (
 
 SELECT *,
    DATE_DIFF('minute', first_interaction_datetime, first_order_datetime) AS time_to_purchase_minites,
    DATE_DIFF('minute', first_order_datetime, last_order_datetime) AS active_after_first_purchase_minutes
  FROM {{ ref('model_int__new_customer_acquisition') }}

)

SELECT *,
    CASE 
    WHEN time_to_purchase_minites < 60 THEN 
        CAST(time_to_purchase_minites AS VARCHAR) || ' minutes'
    WHEN time_to_purchase_minites < 1440 THEN 
        CAST(ROUND(time_to_purchase_minites / 60.0, 1) as VARCHAR) || ' hours'
    ELSE 
        CAST(ROUND(time_to_purchase_minites / 1440.0, 1) as VARCHAR) || ' days'
END AS time_to_purchase,

      CASE 
    WHEN active_after_first_purchase_minutes < 60 THEN 
        CAST(active_after_first_purchase_minutes AS VARCHAR) || ' minutes'
    WHEN active_after_first_purchase_minutes < 1440 THEN 
        CAST(ROUND(active_after_first_purchase_minutes / 60.0, 1) as VARCHAR) || ' hours'
    ELSE 
        CAST(ROUND(active_after_first_purchase_minutes / 1440.0, 1) as VARCHAR) || ' days'
END AS active_after_first_purchase

FROM customer_life_time