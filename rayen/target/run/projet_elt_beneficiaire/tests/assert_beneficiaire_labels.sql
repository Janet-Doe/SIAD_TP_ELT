select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      select *
from "Projet_Siad"."Silver"."beneficiaire"
where sexe not in ('Homme', 'Femme')
   or regime_social not in ('Agricole', 'General', 'Spécial')
      
    ) dbt_internal_test