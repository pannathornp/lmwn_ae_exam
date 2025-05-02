SELECT
    YEAR(opened_datetime) as year,
    QUARTER(opened_datetime) as quarter,
    MONTH(opened_datetime) as month,
    COUNT(ticket_id) as total_opened_tickets,
    COUNT(CASE WHEN issue_type = 'payment' THEN 1 END) as payment,
    COUNT(CASE WHEN issue_type = 'food' THEN 1 END) as food,
    COUNT(CASE WHEN issue_type = 'delivery' THEN 1 END) as delivery,
    COUNT(CASE WHEN issue_type = 'rider' THEN 1 END) as rider,
    COUNT(CASE WHEN status = 'resolved' THEN 1 END) as total_resolved_tickets,
    COUNT(CASE WHEN status <> 'resolved' THEN 1 END) as total_unresolved_tickets,
    ROUND(AVG(time_to_resolve_minutes),0) as avg_time_to_resolve_minutes,
    SUM(compensation_amount) as total_compensation,
FROM {{ ref('model_mart__ticket_support_status_logs') }}
GROUP by year, quarter, month