SELECT
    CUSTOMER_ID AS customer_id,
    CUSTOMER_FIRST_NAME AS customer_first_name,
    CUSTOMER_LAST_NAME AS customer_last_name,
    CUSTOMER_EMAIL AS customer_email,
    CUSTOMER_PHONE AS customer_phone,
    CUSTOMER_ADDRESS AS customer_address,
    CUSTOMER_CITY AS customer_city,
    CUSTOMER_STATE AS customer_state,
    CUSTOMER_ZIP AS customer_zip
FROM {{ source('ecoessentials_transactional', 'customer') }}