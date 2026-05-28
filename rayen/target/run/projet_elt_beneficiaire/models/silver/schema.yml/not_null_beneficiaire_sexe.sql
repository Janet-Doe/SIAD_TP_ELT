select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select sexe
from "Projet_Siad"."Silver"."beneficiaire"
where sexe is null



      
    ) dbt_internal_test