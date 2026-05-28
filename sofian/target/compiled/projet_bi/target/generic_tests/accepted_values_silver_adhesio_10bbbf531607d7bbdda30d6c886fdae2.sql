
    
    

with all_values as (

    select
        code_garantie as value_field,
        count(*) as n_records

    from "projet_siad_elt"."silver"."silver_adhesion_detail"
    group by code_garantie

)

select *
from all_values
where value_field not in (
    'NA','NB','NC','ND','NE','NF','N1','N2','N3','N4','N5','N6'
)


