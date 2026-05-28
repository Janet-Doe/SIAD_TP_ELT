
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        categ_formule as value_field,
        count(*) as n_records

    from "projet_siad_elt"."silver"."silver_adhesion_detail"
    group by categ_formule

)

select *
from all_values
where value_field not in (
    'Confort','Privilege','TM+'
)



  
  
      
    ) dbt_internal_test