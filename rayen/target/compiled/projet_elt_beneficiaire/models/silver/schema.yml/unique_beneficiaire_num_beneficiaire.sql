
    
    

select
    num_beneficiaire as unique_field,
    count(*) as n_records

from "Projet_Siad"."Silver"."beneficiaire"
where num_beneficiaire is not null
group by num_beneficiaire
having count(*) > 1


