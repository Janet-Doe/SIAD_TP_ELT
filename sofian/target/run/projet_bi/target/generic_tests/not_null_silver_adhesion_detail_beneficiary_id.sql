
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select beneficiary_id
from "projet_siad_elt"."silver"."silver_adhesion_detail"
where beneficiary_id is null



  
  
      
    ) dbt_internal_test