{{ config(materialized='table') }}

WITH customers AS (
    SELECT
        customer_id,
        customer_first_name AS customer_firstname,
        customer_last_name AS customer_lastname,
        customer_email
    FROM {{ ref('stg_eco_customer') }}

    UNION ALL

    SELECT DISTINCT
        NULL AS customer_id,
        subscriber_first_name AS customer_firstname,
        subscriber_last_name AS customer_lastname,
        subscriber_email AS customer_email
    FROM {{ ref('stg_eco_marketing_emails') }} m
    WHERE NOT EXISTS (
        SELECT 1
        FROM {{ ref('stg_eco_customer') }} c
        WHERE c.customer_first_name = m.subscriber_first_name
          AND c.customer_last_name = m.subscriber_last_name
    )
)

SELECT
    ROW_NUMBER() OVER (
        ORDER BY customer_firstname, customer_lastname
    ) AS customer_key,
    customer_id,
    customer_firstname,
    customer_lastname,
    customer_email
FROM customers