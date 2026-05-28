{{ config(materialized='table') }}

WITH source AS (
    SELECT * FROM {{ source('raw_bronze', 'bronze_prestations_sante') }}
    WHERE num_sinistre IS NOT NULL
      AND num_sinistre NOT IN ('', 'NUM_SINISTRE')
)

SELECT
    *,
    CASE
        WHEN num_adhesion IS NULL OR TRIM(num_adhesion) = ''
            THEN 'num_adhesion manquant'
        WHEN num_beneficiaire IS NULL
            THEN 'num_beneficiaire manquant'
        WHEN acte IS NULL OR TRIM(acte) = ''
            THEN 'acte manquant'
        WHEN frais_reel_assure IS NULL
            THEN 'frais_reel_assure manquant'
        WHEN CAST(REPLACE(frais_reel_assure, ',', '.') AS FLOAT) < 0
            THEN 'frais_reel_assure negatif : ' || frais_reel_assure
        WHEN CAST(REPLACE(montant_secu, ',', '.') AS FLOAT) < 0
            THEN 'montant_secu negatif : ' || montant_secu
        WHEN CAST(REPLACE(montant_rembourse, ',', '.') AS FLOAT) < 0
            THEN 'montant_rembourse negatif : ' || montant_rembourse
        WHEN (
            CAST(REPLACE(montant_rembourse, ',', '.') AS FLOAT)
            + CAST(REPLACE(montant_secu, ',', '.') AS FLOAT)
        ) > (CAST(REPLACE(frais_reel_assure, ',', '.') AS FLOAT) + 0.01)
            THEN 'remboursement total superieur aux frais reels'
        WHEN CAST(mois_debut_soins AS INTEGER) NOT BETWEEN 1 AND 12
            THEN 'mois_debut_soins invalide : ' || mois_debut_soins
        WHEN CAST(jour_debut_soins AS INTEGER) NOT BETWEEN 1 AND 31
            THEN 'jour_debut_soins invalide : ' || jour_debut_soins
        WHEN CAST(mois_paiement AS INTEGER) NOT BETWEEN 1 AND 12
            THEN 'mois_paiement invalide : ' || mois_paiement
        WHEN CAST(jour_paiement AS INTEGER) NOT BETWEEN 1 AND 31
            THEN 'jour_paiement invalide : ' || jour_paiement
    END AS raison_anomalie
FROM source
WHERE num_adhesion IS NULL OR TRIM(num_adhesion) = ''
   OR num_beneficiaire IS NULL
   OR acte IS NULL OR TRIM(acte) = ''
   OR frais_reel_assure IS NULL
   OR CAST(REPLACE(frais_reel_assure, ',', '.') AS FLOAT) < 0
   OR CAST(REPLACE(montant_secu, ',', '.') AS FLOAT) < 0
   OR CAST(REPLACE(montant_rembourse, ',', '.') AS FLOAT) < 0
   OR (
        CAST(REPLACE(montant_rembourse, ',', '.') AS FLOAT)
        + CAST(REPLACE(montant_secu, ',', '.') AS FLOAT)
      ) > (CAST(REPLACE(frais_reel_assure, ',', '.') AS FLOAT) + 0.01)
   OR CAST(mois_debut_soins AS INTEGER) NOT BETWEEN 1 AND 12
   OR CAST(jour_debut_soins AS INTEGER) NOT BETWEEN 1 AND 31
   OR CAST(mois_paiement AS INTEGER) NOT BETWEEN 1 AND 12
   OR CAST(jour_paiement AS INTEGER) NOT BETWEEN 1 AND 31
