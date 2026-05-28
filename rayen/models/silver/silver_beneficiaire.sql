{{ config(alias='beneficiaire') }}

with bronze as (
    select
        nullif(trim(num_beneficiaire), '') as num_beneficiaire_raw,
        upper(nullif(trim(sexe), '')) as sexe_code,
        upper(nullif(trim(regime_social), '')) as regime_social_code
    from {{ source('pg_bronze', 'bronze_beneficiaire') }}
),

typed_rows as (
    select
        cast(num_beneficiaire_raw as integer) as num_beneficiaire,
        sexe_code,
        regime_social_code
    from bronze
    where num_beneficiaire_raw is not null
      and num_beneficiaire_raw ~ '^[0-9]+$'
      and sexe_code is not null
      and regime_social_code is not null
),

valid_rows as (
    select
        num_beneficiaire,
        sexe_code,
        regime_social_code,
        count(*) over (partition by num_beneficiaire) as nb_occurrences_id
    from typed_rows
)

select
    num_beneficiaire,
    case
        when sexe_code = 'M' then 'Homme'
        else 'Femme'
    end as sexe,
    case
        when regime_social_code = 'A' then 'Agricole'
        when regime_social_code = 'G' then 'General'
        else 'Spécial'
    end as regime_social
from valid_rows
where nb_occurrences_id = 1
