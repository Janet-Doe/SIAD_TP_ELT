
    
    

select
    adhesion_unique_id as unique_field,
    count(*) as n_records

from "projet_siad_elt"."silver"."silver_adhesion_detail"
where adhesion_unique_id is not null
group by adhesion_unique_id
having count(*) > 1


