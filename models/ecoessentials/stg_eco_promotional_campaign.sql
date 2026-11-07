SELECT
    CAMPAIGN_ID AS campaign_id,
    CAMPAIGN_NAME AS campaign_name,
    CAMPAIGN_DISCOUNT AS campaign_discount
FROM {{ source('ecoessentials_transactional', 'promotional_campaign') }}