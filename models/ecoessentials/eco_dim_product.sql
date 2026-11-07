{{ config(materialized='table') }}

SELECT
    product_id AS product_key,
    product_id,
    product_name,
    product_category,
    unit_price
FROM {{ ref('stg_eco_product') }}