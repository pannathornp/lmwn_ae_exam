select
  t.driver_id,
  region,
  bonus_amount,
  delivery_assigned,
  delivery_completed,
  late,
  not_delivered,
  round(avg_delivery_time_minute,2) as avg_delivery_time_minute,
  round(avg_delivery_distance_km,2) as avg_delivery_distance_km,
  driver_rating
  
from {{ ref('model_mart__support_ticket_detail') }} as t
left join {{ ref('model_int__driver_delivery_detail') }} as d
on t.driver_id = d.driver_id
left join {{ ref('model_int__driver_incentive_detail') }} as i
on t.driver_id = i.driver_id