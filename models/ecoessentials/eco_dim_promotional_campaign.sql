{{ config(materialized='table') }}

SELECT
    campaign_id AS promotional_campaign_key,
    campaign_id,
    campaign_name,
    campaign_discount
FROM {{ ref('stg_eco_promotional_campaign') }}