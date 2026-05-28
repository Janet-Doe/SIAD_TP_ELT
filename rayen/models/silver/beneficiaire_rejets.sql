with bronze as (
    select
        nullif(trim(num_beneficiaire), '') as num_beneficiaire_raw,
        cast(sexe as text) as sexe,
        cast(regime_social as text) as regime_social,
        upper(nullif(trim(sexe), '')) as sexe_code,
        upper(nullif(trim(regime_social), '')) as regime_social_code
    from {{ source('pg_bronze', 'bronze_beneficiaire') }}
),

checked_rows as (
    select
        num_beneficiaire_raw,
        sexe,
        regime_social,
        sexe_code,
        regime_social_code,
        case
            when num_beneficiaire_raw ~ '^[0-9]+$'
                then cast(num_beneficiaire_raw as integer)
        end as num_beneficiaire_int
    from bronze
),

rejected_rows as (
    select
        num_beneficiaire_raw as num_beneficiaire,
        sexe,
        regime_social,
        case
            when num_beneficiaire_raw is null then 'NUM_BENEFICIAIRE manquant'
            when num_beneficiaire_raw !~ '^[0-9]+$' then 'NUM_BENEFICIAIRE non numerique'
            when nb_occurrences_id > 1 then 'NUM_BENEFICIAIRE duplique'
            when sexe_code is null then 'SEXE manquant'
            when regime_social_code is null then 'REGIME_SOCIAL manquant'
        end as motif_rejet
    from (
        select
            *,
            count(*) over (partition by num_beneficiaire_int) as nb_occurrences_id
        from checked_rows
    ) checked
    where num_beneficiaire_raw is null
       or num_beneficiaire_raw !~ '^[0-9]+$'
       or nb_occurrences_id > 1
       or sexe_code is null
       or regime_social_code is null
)

select *
from rejected_rows
