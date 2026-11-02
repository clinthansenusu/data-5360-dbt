
{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    d.date_key,
    e.employee_key,
    c.certification_name,
    c.certification_cost

FROM {{ ref('stg_employee_certifications') }} c

LEFT JOIN {{ ref('oliver_dim_date') }} d
    ON c.certification_awarded_date = d.date_day

LEFT JOIN {{ ref('oliver_dim_employee') }} e
    ON c.employee_id = e.employee_id
