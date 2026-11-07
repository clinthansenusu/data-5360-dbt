{{ config(materialized='table') }}

SELECT
    e.email_event_id,
    d.date_key,
    c.customer_key,
    ec.email_campaign_key,
    et.event_type_key,
    e.email_id,
    e.event_timestamp,
    1 AS event_count

FROM {{ ref('stg_eco_marketing_emails') }} e

LEFT JOIN {{ ref('eco_dim_date') }} d
    ON CAST(e.event_timestamp AS DATE) = d.full_date

LEFT JOIN {{ ref('eco_dim_customer') }} c
    ON e.subscriber_first_name = c.customer_firstname
    AND e.subscriber_last_name = c.customer_lastname

LEFT JOIN {{ ref('eco_dim_email_campaign') }} ec
    ON e.campaign_id = ec.campaign_id

LEFT JOIN {{ ref('eco_dim_event_type') }} et
    ON e.event_type = et.event_type_name