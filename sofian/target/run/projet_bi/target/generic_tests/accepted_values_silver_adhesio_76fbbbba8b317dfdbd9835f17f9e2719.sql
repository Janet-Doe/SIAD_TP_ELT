
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

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



  
  
      
    ) dbt_internal_test