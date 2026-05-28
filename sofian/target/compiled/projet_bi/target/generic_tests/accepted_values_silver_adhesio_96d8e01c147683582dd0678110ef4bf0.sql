
    
    

with all_values as (

    select
        exercice_paiement as value_field,
        count(*) as n_records

    from "projet_siad_elt"."silver"."silver_adhesion_detail"
    group by exercice_paiement

)

select *
from all_values
where value_field not in (
    '2010','2011','2012'
)


