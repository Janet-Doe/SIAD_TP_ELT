
    
    

with all_values as (

    select
        beneficiary_type_label as value_field,
        count(*) as n_records

    from "projet_siad_elt"."silver"."silver_adhesion_detail"
    group by beneficiary_type_label

)

select *
from all_values
where value_field not in (
    'Assuré','Enfant','Conjoint','Autre'
)


