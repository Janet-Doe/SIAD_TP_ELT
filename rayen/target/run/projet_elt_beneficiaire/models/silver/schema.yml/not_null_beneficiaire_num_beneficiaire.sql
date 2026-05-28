select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select num_beneficiaire
from "Projet_Siad"."Silver"."beneficiaire"
where num_beneficiaire is null



      
    ) dbt_internal_test