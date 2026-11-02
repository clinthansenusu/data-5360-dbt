{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    CERTIFICATION_COMPLETION_ID AS certification_completion_id,
    EMPLOYEE_ID AS employee_id,
    FIRST_NAME AS first_name,
    LAST_NAME AS last_name,
    EMAIL AS email,

    PARSE_JSON(CERTIFICATION_JSON):certification_name::VARCHAR
        AS certification_name,

    PARSE_JSON(CERTIFICATION_JSON):certification_cost::NUMBER(10,2)
        AS certification_cost,

    PARSE_JSON(CERTIFICATION_JSON):certification_awarded_date::DATE
        AS certification_awarded_date

FROM {{ source('oliver_landing', 'employee_certifications') }}