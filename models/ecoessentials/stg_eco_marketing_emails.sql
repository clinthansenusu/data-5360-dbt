SELECT
    EMAILEVENTID AS email_event_id,
    EMAILID AS email_id,
    EMAILNAME AS email_name,
    CAMPAIGNID AS campaign_id,
    CAMPAIGNNAME AS campaign_name,
    CUSTOMERID AS customer_id,
    SUBSCRIBERID AS subscriber_id,
    SUBSCRIBEREMAIL AS subscriber_email,
    SUBSCRIBERFIRSTNAME AS subscriber_first_name,
    SUBSCRIBERLASTNAME AS subscriber_last_name,
    SENDTIMESTAMP AS send_timestamp,
    EVENTTYPE AS event_type,
    EVENTTIMESTAMP AS event_timestamp
FROM {{ source('ecoessentials_email_events', 'marketing_emails') }}