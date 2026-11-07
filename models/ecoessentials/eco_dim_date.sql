{{ config(materialized='table') }}

WITH source_dates AS (

    SELECT CAST(order_timestamp AS DATE) AS full_date
    FROM {{ ref('stg_eco_orders') }}

    UNION

    SELECT CAST(event_timestamp AS DATE) AS full_date
    FROM {{ ref('stg_eco_marketing_emails') }}

),

date_range AS (

    SELECT
        MIN(full_date) AS min_date,
        MAX(full_date) AS max_date
    FROM source_dates

),

date_spine AS (

    SELECT
        DATEADD(
            day,
            seq4(),
            (SELECT min_date FROM date_range)
        ) AS full_date
    FROM TABLE(GENERATOR(ROWCOUNT => 36525))

),

final AS (

    SELECT
        TO_NUMBER(TO_CHAR(full_date, 'YYYYMMDD')) AS date_key,
        CAST(full_date AS DATE) AS full_date,
        YEAR(full_date) AS year,
        QUARTER(full_date) AS quarter,
        MONTH(full_date) AS month_number,
        MONTHNAME(full_date) AS month_name,
        DAY(full_date) AS day
    FROM date_spine
    WHERE full_date <= (SELECT max_date FROM date_range)

)

SELECT *
FROM final
ORDER BY full_date
