SELECT
    ORDER_LINE_ID AS order_line_id,
    ORDER_ID AS order_id,
    PRODUCT_ID AS product_id,
    CAMPAIGN_ID AS campaign_id,
    QUANTITY AS quantity,
    PRICE_AFTER_DISCOUNT AS price_after_discount,
    DISCOUNT AS discount,
    PROMOTIONAL_CAMPAIGN AS promotional_campaign
FROM {{ source('ecoessentials_transactional', 'order_line') }}