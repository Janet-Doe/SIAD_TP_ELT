
  
    

  create  table "projet_siad_elt"."silver"."silver_dept_region__dbt_tmp"
  
  
    as
  
  (
    

WITH raw_data AS (
    SELECT * FROM "projet_siad_elt"."public"."bronze_dept_region"
),

filtered_data AS (
    SELECT * 
    FROM raw_data
    WHERE "departmentcode" IS NOT NULL 
      AND TRIM("departmentcode") != ''
      AND "departmentname" IS NOT NULL
),

cleaned_data AS (
    SELECT
        CAST("departmentcode" AS INTEGER) AS departmentcode,
        TRIM("departmentname") AS departmentname,
        CAST("regioncode" AS INTEGER) AS regioncode,
        TRIM("regionname") AS regionname
    FROM filtered_data
)

SELECT DISTINCT *
FROM cleaned_data
  );
  