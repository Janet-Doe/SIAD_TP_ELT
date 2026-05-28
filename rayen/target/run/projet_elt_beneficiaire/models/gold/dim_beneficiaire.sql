
  
    

  create  table "Projet_Siad"."Gold"."dim_beneficiaire__dbt_tmp"
  
  
    as
  
  (
    

select
    cast(num_beneficiaire as integer) as "BENEFICIAIRE_ID",
    cast(sexe as text) as "SEXE",
    cast(regime_social as text) as "REGIME_SOCIAL"
from "Projet_Siad"."Silver"."beneficiaire"
  );
  