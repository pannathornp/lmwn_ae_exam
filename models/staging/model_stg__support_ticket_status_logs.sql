WITH

source as (
    SELECT * FROM {{ source('source_ae_exam_db', 'support_ticket_status_logs') }}
)


SELECT

    log_id,
    ticket_id,
    status,
    status_datetime,
    agent_id

FROM source
