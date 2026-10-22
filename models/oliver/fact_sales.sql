{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

with order_lines as (
    select
        ol.order_line_id,
        ol.order_id,
        ol.product_id,
        ol.quantity,
        ol.unit_price,
        o.order_date,
        o.customer_id,
        o.employee_id,
        o.store_id
    from {{ source('oliver_landing', 'orderline') }} ol
    inner join {{ source('oliver_landing', 'orders') }} o
        on ol.order_id = o.order_id
)

select
    c.cust_key,
    d.date_key,
    s.store_key,
    p.product_key,
    e.employee_key,
    ol.quantity,
    ol.quantity * ol.unit_price as dollars_sold,
    ol.unit_price
from order_lines ol
left join {{ ref('oliver_dim_customer') }} c on ol.customer_id = c.customer_id
left join {{ ref('oliver_dim_date') }} d on ol.order_date = d.date_day
left join {{ ref('oliver_dim_store') }} s on ol.store_id = s.store_id
left join {{ ref('oliver_dim_product') }} p on ol.product_id = p.product_id
left join {{ ref('oliver_dim_employee') }} e on ol.employee_id = e.employee_id