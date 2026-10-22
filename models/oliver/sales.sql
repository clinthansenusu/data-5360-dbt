  {{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}

{{ config(
    materialized='table'
) }}

select
    f.quantity,
    f.dollars_sold,
    f.unit_price,
    d.date_day,
    d.day_of_week,
    d.month_of_year,
    d.quarter_of_year,
    d.year_number,
    c.customer_id,
    c.first_name as customer_first_name,
    c.last_name as customer_last_name,
    c.email as customer_email,
    c.phone_number as customer_phone,
    c.state as customer_state,
    s.store_id,
    s.store_name,
    s.street as store_street,
    s.city as store_city,
    s.state as store_state,
    p.product_id,
    p.product_name,
    p.description as product_description,
    e.employee_id,
    e.first_name as employee_first_name,
    e.last_name as employee_last_name,
    e.email as employee_email,
    e.phone_number as employee_phone,
    e.hire_date,
    e.position

from {{ ref('fact_sales') }} f

left join {{ ref('oliver_dim_date') }} d
    on f.date_key = d.date_key

left join {{ ref('oliver_dim_customer') }} c
    on f.cust_key = c.cust_key

left join {{ ref('oliver_dim_store') }} s
    on f.store_key = s.store_key

left join {{ ref('oliver_dim_product') }} p
    on f.product_key = p.product_key

left join {{ ref('oliver_dim_employee') }} e
    on f.employee_key = e.employee_key