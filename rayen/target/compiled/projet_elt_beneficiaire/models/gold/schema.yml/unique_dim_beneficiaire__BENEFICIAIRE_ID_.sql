
    
    

select
    "BENEFICIAIRE_ID" as unique_field,
    count(*) as n_records

from "Projet_Siad"."Gold"."dim_beneficiaire"
where "BENEFICIAIRE_ID" is not null
group by "BENEFICIAIRE_ID"
having count(*) > 1


