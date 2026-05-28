
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select birth_date
from "projet_siad_elt"."silver"."silver_adhesion_detail"
where birth_date is null



  
  
      
    ) dbt_internal_test