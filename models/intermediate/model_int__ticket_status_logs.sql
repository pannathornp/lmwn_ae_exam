
WITH opening_tickets as (

SELECT * FROM {{ ref('model_stg__support_ticket_status_logs') }}
WHERE status = 'opened'

), 

resolved_tickets as (
SELECT * FROM {{ ref('model_stg__support_ticket_status_logs') }}
WHERE status = 'resolved'
)

, ticket_status_logs as (
SELECT
o.log_id,
o.ticket_id as ticket_id,
o.status as opened_status,
r.status as resolved_status,
o.status_datetime as opened_datetime,
r.status_datetime as resolved_datetime,
CASE WHEN r.status is not null THEN 'resolved' ELSE 'opened' END as currect_status,
DATE_DIFF('minute', o.status_datetime, r.status_datetime) AS time_to_resolve_minutes
FROM opening_tickets o
LEFT JOIN resolved_tickets r on o.ticket_id = r.ticket_id
)

SELECT * FROM ticket_status_logs
