
  
    

  create  table "projet_siad_elt"."silver_gold"."acte_dim__dbt_tmp"
  
  
    as
  
  (
    

WITH raw_acts AS (
    SELECT DISTINCT 
        acte,
        designation_acte
    FROM "projet_siad_elt"."public"."bronze_prestations_sante"
    WHERE acte IS NOT NULL 
      AND acte != 'ACTE'
)

SELECT DISTINCT
    acte AS "Acte",
    INITCAP(TRIM(designation_acte)) AS designation_acte,
    acte AS categ_acte
FROM raw_acts
  );
  