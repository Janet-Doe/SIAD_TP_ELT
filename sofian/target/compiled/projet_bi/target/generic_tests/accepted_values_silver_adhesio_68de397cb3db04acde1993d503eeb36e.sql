
    
    

with all_values as (

    select
        code_fractionnement as value_field,
        count(*) as n_records

    from "projet_siad_elt"."silver"."silver_adhesion_detail"
    group by code_fractionnement

)

select *
from all_values
where value_field not in (
    'A','S','T','M','P'
)


