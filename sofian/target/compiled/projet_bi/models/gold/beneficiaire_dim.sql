

SELECT DISTINCT
    CAST(num_beneficiaire AS INTEGER) AS b_id,
    sexe,
    regime_social
FROM "projet_siad_elt"."silver"."silver_beneficiaire"
WHERE num_beneficiaire IS NOT NULL