{{ config(materialized='table') }}

WITH ages AS (
    SELECT generate_series(0, 110) AS age_id
)

SELECT
    age_id,
    CASE
        WHEN age_id BETWEEN 0  AND 2   THEN 'Nourrisson'
        WHEN age_id BETWEEN 3  AND 11  THEN 'Enfant'
        WHEN age_id BETWEEN 12 AND 14  THEN 'Pré-adolescent'
        WHEN age_id BETWEEN 15 AND 17  THEN 'Adolescent'
        WHEN age_id BETWEEN 18 AND 25  THEN 'Jeune adulte'
        WHEN age_id BETWEEN 26 AND 59  THEN 'Adulte'
        ELSE 'Senior'
    END AS gp_age
FROM ages