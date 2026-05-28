
    
    

with all_values as (

    select
        sexe as value_field,
        count(*) as n_records

    from "Projet_Siad"."Silver"."beneficiaire"
    group by sexe

)

select *
from all_values
where value_field not in (
    'Homme','Femme'
)


