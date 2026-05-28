
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select code_produit
from "projet_siad_elt"."silver"."silver_adhesion_detail"
where code_produit is null



  
  
      
    ) dbt_internal_test