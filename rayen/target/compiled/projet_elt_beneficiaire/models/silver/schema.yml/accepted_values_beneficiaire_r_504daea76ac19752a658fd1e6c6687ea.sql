
    
    

with all_values as (

    select
        motif_rejet as value_field,
        count(*) as n_records

    from "Projet_Siad"."Silver"."beneficiaire_rejets"
    group by motif_rejet

)

select *
from all_values
where value_field not in (
    'NUM_BENEFICIAIRE manquant','NUM_BENEFICIAIRE non numerique','NUM_BENEFICIAIRE duplique','SEXE manquant','REGIME_SOCIAL manquant'
)


