{{ config(materialized='table') }}

WITH prestations AS (
    SELECT * FROM {{ ref('silver_prestations_sante') }}
),

adhesion AS (
    SELECT * FROM {{ ref('silver_adhesion_detail') }}
),

meteo AS (
    SELECT * FROM {{ ref('silver_meteo') }}
),

-- ancienneté = exercice_paiement - min(exercice_paiement) par contrat+beneficiaire
anciennete AS (
    SELECT
        num_adhesion_normalise,
        num_beneficiaire_unique,
        MIN(exercice_paiement) AS min_exercice_paiement
    FROM adhesion
    GROUP BY num_adhesion_normalise, num_beneficiaire_unique
),

joined AS (
    SELECT
        p.num_sinistre,
        p.num_beneficiaire_sinistre                                         AS benid,
        -- age au moment des soins
        p.annee_debut_soins 
            - EXTRACT(YEAR FROM a.date_naissance_beneficiaire)::INTEGER     AS age_id,
        -- date soins reconstituée
        TO_DATE(
            LPAD(p.jour_debut_soins::TEXT, 2, '0') || '-' ||
            LPAD(p.mois_debut_soins::TEXT, 2, '0') || '-' ||
            p.annee_debut_soins::TEXT,
            'DD-MM-YYYY'
        )                                                                   AS date_soins,
        -- date remboursement reconstituée
        TO_DATE(
            LPAD(p.jour_paiement::TEXT, 2, '0') || '-' ||
            LPAD(p.mois_paiement::TEXT, 2, '0') || '-' ||
            p.annee_paiement::TEXT,
            'DD-MM-YYYY'
        )                                                                   AS date_remboursement,
        p.acte                                                              AS acte_id,
        -- c_id = clé contrat
        a.num_adhesion_normalise::VARCHAR 
            || a.num_beneficiaire_unique::VARCHAR 
            || a.exercice_paiement::VARCHAR                                 AS contrat_id,
        -- adresse_id via code postal
        a.code_postal                                                       AS adresse_id,
        -- température moyenne du jour des soins dans le département
        (m.tempmin + m.tempmax) / 2                                         AS temperature,
        -- ancienneté
        a.exercice_paiement - anc.min_exercice_paiement                     AS anciennete,
        p.frais_reel_assure                                                 AS frais_reel,
        p.montant_secu,
        p.montant_rembourse
    FROM prestations p
    -- jointure adhesion : NUM_ADHESION = NUM_ADHESION_NORMALISE et NUM_BENEFICIAIRE_SINISTRE = NUM_BENEFICIAIRE_UNIQUE et ANNEE_DEBUT_SOINS = EXERCICE_PAIEMENT
    INNER JOIN adhesion a
        ON p.num_adhesion = a.num_adhesion_normalise
        AND p.num_beneficiaire_sinistre = a.num_beneficiaire_unique
        AND p.annee_debut_soins = a.exercice_paiement
    -- jointure météo : date soins + département déduit du code postal
    INNER JOIN meteo m
        ON m.date = TO_DATE(
                LPAD(p.jour_debut_soins::TEXT, 2, '0') || '-' ||
                LPAD(p.mois_debut_soins::TEXT, 2, '0') || '-' ||
                p.annee_debut_soins::TEXT, 'DD-MM-YYYY')
        AND m.departement = CASE
                WHEN a.code_postal >= 97000
                    THEN SUBSTRING(LPAD(a.code_postal::TEXT, 5, '0'), 1, 3)
                ELSE SUBSTRING(LPAD(a.code_postal::TEXT, 5, '0'), 1, 2)
            END
    -- jointure ancienneté
    INNER JOIN anciennete anc
        ON anc.num_adhesion_normalise = a.num_adhesion_normalise
        AND anc.num_beneficiaire_unique = a.num_beneficiaire_unique
)

SELECT * FROM joined