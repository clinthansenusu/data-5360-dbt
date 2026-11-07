SELECT
    ORDER_ID AS order_id,
    CUSTOMER_ID AS customer_id,
    ORDER_TIMESTAMP AS order_timestamp
FROM {{ source('ecoessentials_transactional', 'order') }}