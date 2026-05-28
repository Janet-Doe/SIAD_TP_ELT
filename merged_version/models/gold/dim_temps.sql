{{ config(materialized='table') }}

WITH dates AS (
    SELECT generate_series(
        '2009-01-01'::date,
        '2012-12-31'::date,
        '1 day'::interval
    )::date AS date_id
)

SELECT
    date_id,
    EXTRACT(YEAR FROM date_id)::INTEGER AS annee,
    'Trimestre ' || EXTRACT(QUARTER FROM date_id)::INTEGER AS trimestre,
    CASE EXTRACT(MONTH FROM date_id)::INTEGER
        WHEN 1  THEN 'janvier'
        WHEN 2  THEN 'février'
        WHEN 3  THEN 'mars'
        WHEN 4  THEN 'avril'
        WHEN 5  THEN 'mai'
        WHEN 6  THEN 'juin'
        WHEN 7  THEN 'juillet'
        WHEN 8  THEN 'août'
        WHEN 9  THEN 'septembre'
        WHEN 10 THEN 'octobre'
        WHEN 11 THEN 'novembre'
        WHEN 12 THEN 'décembre'
    END AS mois,
    CASE
        WHEN EXTRACT(MONTH FROM date_id) IN (12, 1, 2)  THEN 'Hiver'
        WHEN EXTRACT(MONTH FROM date_id) IN (3, 4, 5)   THEN 'Printemps'
        WHEN EXTRACT(MONTH FROM date_id) IN (6, 7, 8)   THEN 'Été'
        WHEN EXTRACT(MONTH FROM date_id) IN (9, 10, 11) THEN 'Automne'
    END AS saison,
    EXTRACT(DAY FROM date_id)::INTEGER AS num_jour_mois,
    CASE EXTRACT(DOW FROM date_id)::INTEGER
        WHEN 0 THEN 'dimanche'
        WHEN 1 THEN 'lundi'
        WHEN 2 THEN 'mardi'
        WHEN 3 THEN 'mercredi'
        WHEN 4 THEN 'jeudi'
        WHEN 5 THEN 'vendredi'
        WHEN 6 THEN 'samedi'
    END AS jour
FROM dates