{{ config(materialized='table') }}

SELECT
    ROW_NUMBER() OVER (ORDER BY event_type) AS event_type_key,
    event_type AS event_type_name
FROM (
    SELECT DISTINCT
        event_type
    FROM {{ ref('stg_eco_marketing_emails') }}
    WHERE event_type IS NOT NULL
)