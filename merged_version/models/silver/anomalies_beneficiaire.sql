{{ config(materialized='table') }}

WITH source AS (
    SELECT * FROM {{ source('raw_bronze', 'bronze_beneficiaire') }}
)

SELECT
    *,
    CASE
        WHEN num_beneficiaire IS NULL
            THEN 'num_beneficiaire manquant'
        WHEN sexe IS NULL OR TRIM(sexe) = ''
            THEN 'sexe manquant'
        WHEN TRIM(sexe) NOT IN ('M', 'F')
            THEN 'sexe invalide : ' || TRIM(sexe)
        WHEN regime_social IS NULL OR TRIM(regime_social) = ''
            THEN 'regime_social manquant'
    END AS raison_anomalie
FROM source
WHERE num_beneficiaire IS NULL
   OR sexe IS NULL
   OR TRIM(sexe) = ''
   OR TRIM(sexe) NOT IN ('M', 'F')
   OR regime_social IS NULL
   OR TRIM(regime_social) = ''
