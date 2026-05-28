
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select code_garantie
from "projet_siad_elt"."silver"."silver_adhesion_detail"
where code_garantie is null



  
  
      
    ) dbt_internal_test