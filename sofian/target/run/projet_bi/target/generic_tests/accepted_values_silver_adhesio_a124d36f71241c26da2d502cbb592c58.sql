
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        type_beneficiaire_libelle as value_field,
        count(*) as n_records

    from "projet_siad_elt"."silver"."silver_adhesion_detail"
    group by type_beneficiaire_libelle

)

select *
from all_values
where value_field not in (
    'Assuré principal','Conjoint','Enfant'
)



  
  
      
    ) dbt_internal_test