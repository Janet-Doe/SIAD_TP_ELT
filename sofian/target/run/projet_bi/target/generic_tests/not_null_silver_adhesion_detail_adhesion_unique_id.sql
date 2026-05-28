
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select adhesion_unique_id
from "projet_siad_elt"."silver"."silver_adhesion_detail"
where adhesion_unique_id is null



  
  
      
    ) dbt_internal_test