with driver_support_ticket_detail as (
  select 
    driver_id,
    issue_type,
    issue_sub_type,
    count(ticket_id) as total_tickets,
    COUNT(CASE WHEN issue_sub_type = 'cold' THEN 1 END) as cold,
    COUNT(CASE WHEN issue_sub_type = 'late' THEN 1 END) as late,
    COUNT(CASE WHEN issue_sub_type = 'no_mask' THEN 1 END) as no_mask,
    COUNT(CASE WHEN issue_sub_type = 'not_delivered' THEN 1 END) as not_delivered,
    COUNT(CASE WHEN issue_sub_type = 'overcharged' THEN 1 END) as overcharged,
    COUNT(CASE WHEN issue_sub_type = 'refund' THEN 1 END) as refund,
    COUNT(CASE WHEN issue_sub_type = 'rude' THEN 1 END) as rude,
    COUNT(CASE WHEN issue_sub_type = 'wrong_item' THEN 1 END) as wrong_item
  from {{ ref('model_stg__support_tickets') }}
  group by driver_id,issue_type,issue_sub_type

)

select 
  driver_id,
  sum(late) as late,
  sum(not_delivered) as not_delivered 
from driver_support_ticket_detail
group by driver_id
