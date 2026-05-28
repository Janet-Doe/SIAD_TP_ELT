select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select regime_social
from "Projet_Siad"."Silver"."beneficiaire"
where regime_social is null



      
    ) dbt_internal_test