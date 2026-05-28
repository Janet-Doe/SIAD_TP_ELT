

SELECT raison_anomalie, count(*) as nb_lignes
FROM "projet_siad_elt"."silver"."anomalies_adhesion"
GROUP BY raison_anomalie
ORDER BY nb_lignes DESC