
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select age_at_payment
from "projet_siad_elt"."silver"."silver_adhesion_detail"
where age_at_payment is null



  
  
      
    ) dbt_internal_test