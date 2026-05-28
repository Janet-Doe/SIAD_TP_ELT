
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select num_beneficiaire_unique
from "projet_siad_elt"."silver"."silver_adhesion_detail"
where num_beneficiaire_unique is null



  
  
      
    ) dbt_internal_test