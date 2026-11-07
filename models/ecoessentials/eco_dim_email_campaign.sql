{{ config(materialized='table') }}

SELECT DISTINCT
    campaign_id AS email_campaign_key,
    campaign_id,
    campaign_name
FROM {{ ref('stg_eco_marketing_emails') }}
WHERE campaign_id IS NOT NULL