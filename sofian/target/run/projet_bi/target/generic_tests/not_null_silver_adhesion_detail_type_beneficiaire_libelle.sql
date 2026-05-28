
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select type_beneficiaire_libelle
from "projet_siad_elt"."silver"."silver_adhesion_detail"
where type_beneficiaire_libelle is null



  
  
      
    ) dbt_internal_test