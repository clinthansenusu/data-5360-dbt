{{ config(materialized='table') }}

SELECT
    ol.order_line_id,
    d.date_key,
    c.customer_key,
    p.product_key,
    pc.promotional_campaign_key,
    o.order_id,
    o.order_timestamp,
    ol.quantity,
    p.unit_price,
    ROUND(
        (p.unit_price * ol.quantity) - ol.price_after_discount, 2
    ) AS discount_amount,
    ol.price_after_discount AS sales_amount

FROM {{ ref('stg_eco_order_line') }} ol

INNER JOIN {{ ref('stg_eco_orders') }} o
    ON ol.order_id = o.order_id

LEFT JOIN {{ ref('eco_dim_date') }} d
    ON CAST(o.order_timestamp AS DATE) = d.full_date

LEFT JOIN {{ ref('eco_dim_customer') }} c
    ON o.customer_id = c.customer_id

LEFT JOIN {{ ref('eco_dim_product') }} p
    ON ol.product_id = p.product_id

LEFT JOIN {{ ref('eco_dim_promotional_campaign') }} pc
    ON ol.campaign_id = pc.campaign_id