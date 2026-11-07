SELECT
    PRODUCT_ID AS product_id,
    PRODUCT_NAME AS product_name,
    PRODUCT_TYPE AS product_category,
    PRICE AS unit_price
FROM {{ source('ecoessentials_transactional', 'product') }}