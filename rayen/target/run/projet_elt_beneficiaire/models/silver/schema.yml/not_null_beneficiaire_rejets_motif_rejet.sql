select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select motif_rejet
from "Projet_Siad"."Silver"."beneficiaire_rejets"
where motif_rejet is null



      
    ) dbt_internal_test