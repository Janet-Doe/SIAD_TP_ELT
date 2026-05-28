{{ config(materialized='table') }}

WITH prestations AS (
    SELECT DISTINCT
        acte,
        designation_acte
    FROM {{ ref('silver_prestations_sante') }}
    WHERE acte IS NOT NULL
),

categorised AS (
    SELECT
        acte,
        designation_acte,
        CASE
            WHEN UPPER(acte) LIKE '%PHARM%'    OR UPPER(acte) LIKE '%MEDIC%'
              OR UPPER(acte) LIKE '%PREPA%'    OR UPPER(acte) LIKE '%VACCIN%'
              OR UPPER(acte) LIKE '%TABAC%'                                         THEN 'PHARMACIE'
            WHEN UPPER(acte) LIKE '%CONSULTATION%' 
             AND UPPER(acte) NOT LIKE '%SPEC%'                                      THEN 'CONSULTATION_GENERALISTE'
            WHEN UPPER(acte) LIKE '%SPEC%'     OR UPPER(acte) LIKE '%CARDIO%'
              OR UPPER(acte) LIKE '%DERMATO%'  OR UPPER(acte) LIKE '%RADIOLOGUE%'  THEN 'CONSULTATION_SPECIALISTE'
            WHEN UPPER(acte) LIKE '%DENT%'                                          THEN 'ACTES_DENTAIRES'
            WHEN UPPER(acte) LIKE '%CHIR%' 
             AND UPPER(acte) NOT LIKE '%DENT%'                                      THEN 'ACTES_CHIRURGICAUX'
            WHEN UPPER(acte) LIKE '%RADIO%'    OR UPPER(acte) LIKE '%ECHO%'
              OR UPPER(acte) LIKE '%DOPP%'     OR UPPER(acte) LIKE '%SCANN%'       THEN 'IMAGERIE_RADIOLOGIE'
            WHEN UPPER(acte) LIKE '%BIO%'      OR UPPER(acte) LIKE '%LABO%'
              OR UPPER(acte) LIKE '%PRELEV%'                                        THEN 'BIOLOGIE'
            WHEN UPPER(acte) LIKE '%INFIR%'                                         THEN 'INFIRMIER'
            WHEN UPPER(acte) LIKE '%KINE%'                                          THEN 'KINESITHERAPIE'
            WHEN UPPER(acte) LIKE '%SAGE%'                                          THEN 'SAGE_FEMME'
            WHEN UPPER(acte) LIKE '%HOSP%'     OR UPPER(acte) LIKE '%SEJOUR%'      THEN 'HOSPITALISATION'
            WHEN UPPER(acte) LIKE '%URGENCE%'  OR UPPER(acte) LIKE '%SMUR%'
              OR UPPER(acte) LIKE '%TRANSPORT%'                                     THEN 'URGENCES_TRANSPORT'
            WHEN UPPER(acte) LIKE '%APPAREIL%' OR UPPER(acte) LIKE '%ORTH%'
              OR UPPER(acte) LIKE '%MATER%'                                         THEN 'DISPOSITIFS_MEDICAUX'
            WHEN UPPER(acte) LIKE '%FORF%'     OR UPPER(acte) LIKE '%FRAIS%'       THEN 'FORFAITS'
            WHEN UPPER(acte) LIKE '%MAJ%'      OR UPPER(acte) LIKE '%MAJO%'
              OR UPPER(acte) LIKE '%NUIT%'     OR UPPER(acte) LIKE '%DIMANCHE%'    THEN 'MAJORATIONS'
            WHEN UPPER(acte) LIKE '%PSY%'                                           THEN 'PSYCHIATRIE'
            WHEN UPPER(acte) LIKE '%TECH%'                                          THEN 'ACTES_TECHNIQUES'
            WHEN UPPER(acte) LIKE '%PREVENT%'  OR UPPER(acte) LIKE '%CONTRACEPT%'  THEN 'PREVENTION'
            WHEN UPPER(acte) LIKE '%NON REMB%' OR UPPER(acte) LIKE '%HORS NOM%'    THEN 'NON_REMBOURSABLE'
            ELSE 'AUTRES'
        END AS categ_acte
    FROM prestations
)

SELECT
    acte AS acte_id,
    designation_acte,
    categ_acte
FROM categorised