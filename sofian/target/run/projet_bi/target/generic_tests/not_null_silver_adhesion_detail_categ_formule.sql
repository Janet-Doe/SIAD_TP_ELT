
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select categ_formule
from "projet_siad_elt"."silver"."silver_adhesion_detail"
where categ_formule is null



  
  
      
    ) dbt_internal_test