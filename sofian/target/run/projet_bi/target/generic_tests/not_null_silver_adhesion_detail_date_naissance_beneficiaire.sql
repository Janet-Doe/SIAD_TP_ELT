
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select date_naissance_beneficiaire
from "projet_siad_elt"."silver"."silver_adhesion_detail"
where date_naissance_beneficiaire is null



  
  
      
    ) dbt_internal_test