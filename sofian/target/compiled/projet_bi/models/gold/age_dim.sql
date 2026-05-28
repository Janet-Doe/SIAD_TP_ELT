

SELECT DISTINCT
    age AS age_id,
    gp_age
FROM "projet_siad_elt"."silver"."silver_adhesion_detail"
WHERE age IS NOT NULL