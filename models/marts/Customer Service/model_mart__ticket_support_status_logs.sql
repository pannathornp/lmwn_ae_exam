
select *,
DATE_DIFF('minute', opened_datetime, resolved_datetime) AS time_to_resolve_minutes
from {{ ref('model_stg__support_tickets') }}

