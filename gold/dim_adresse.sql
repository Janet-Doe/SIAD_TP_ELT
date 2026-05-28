{{ config(materialized='table') }}

WITH adhesion AS (
    SELECT DISTINCT
        code_postal
    FROM {{ ref('silver_adhesion_detail') }}
    WHERE code_postal IS NOT NULL
),

dept_region AS (
    SELECT
        departmentcode,
        departmentname,
        regionname
    FROM {{ ref('silver_dept_region') }}
),

joined AS (
    SELECT
        a.code_postal,
        d.departmentname AS departement,
        d.regionname AS region
    FROM adhesion a
    INNER JOIN dept_region d 
        ON CAST(
            CASE 
                WHEN a.code_postal >= 97000 
                    THEN SUBSTRING(CAST(a.code_postal AS VARCHAR), 1, 3)
                ELSE SUBSTRING(LPAD(CAST(a.code_postal AS VARCHAR), 5, '0'), 1, 2)
            END 
        AS INTEGER) = d.departmentcode
)

SELECT
    ROW_NUMBER() OVER (ORDER BY code_postal) AS adresse_id,
    code_postal,
    departement,
    region
FROM joined