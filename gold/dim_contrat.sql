{{ config(materialized='table') }}

WITH adhesion AS (
    SELECT
        num_adhesion_normalise::VARCHAR 
        || num_beneficiaire_unique::VARCHAR 
        || exercice_paiement::VARCHAR AS c_id,
        formule,
        type_beneficiaire,
        code_profession
    FROM {{ ref('silver_adhesion_detail') }}
),

classification AS (
    SELECT
        code,
        categorie,
        famille_metier,
        intitule
    FROM {{ source('raw_bronze', 'bronze_classification') }}
),

joined AS (
    SELECT
        a.c_id,
        a.formule,
        SPLIT_PART(a.formule, ' ', 1) AS categ_formule,
        a.type_beneficiaire,
        c.categorie AS categ_profession,
        c.famille_metier,
        c.intitule AS libelle_profession
    FROM adhesion a
    INNER JOIN classification c ON TRIM(a.code_profession) = TRIM(c.code)
)

SELECT DISTINCT * FROM joined