
  
    

  create  table "projet_siad_elt"."silver_gold"."age_dim__dbt_tmp"
  
  
    as
  
  (
    

SELECT DISTINCT
    age AS age_id,
    gp_age
FROM "projet_siad_elt"."silver"."silver_adhesion_detail"
WHERE age IS NOT NULL
  );
  