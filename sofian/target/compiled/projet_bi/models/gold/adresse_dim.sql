

WITH zip_codes AS (
    SELECT DISTINCT 
        code_postal AS cp_full,
        CASE 
            WHEN LENGTH(CAST(code_postal AS TEXT)) >= 2 THEN 
                CASE 
                    WHEN LEFT(CAST(code_postal AS TEXT), 3) IN ('971', '972', '973', '974', '976') THEN LEFT(CAST(code_postal AS TEXT), 3)
                    ELSE LEFT(CAST(code_postal AS TEXT), 2)
                END
            ELSE '0'
        END AS dept_code
    FROM "projet_siad_elt"."silver"."silver_adhesion_detail"
    WHERE code_postal IS NOT NULL 
)

SELECT DISTINCT
    z.cp_full AS cp,
    d.departement,
    d.region
FROM zip_codes z
LEFT JOIN "projet_siad_elt"."silver"."silver_dept_region" d ON CAST(z.dept_code AS VARCHAR) = CAST(d.cp AS VARCHAR)
WHERE z.cp_full IS NOT NULL
-- Suppression du DISTINCT ON violent
ORDER BY cp