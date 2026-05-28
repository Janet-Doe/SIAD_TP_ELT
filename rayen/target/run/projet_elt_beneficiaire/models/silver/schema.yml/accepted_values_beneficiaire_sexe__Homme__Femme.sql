select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

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



      
    ) dbt_internal_test