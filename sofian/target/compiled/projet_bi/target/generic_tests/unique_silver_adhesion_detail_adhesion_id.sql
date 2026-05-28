
    
    

select
    adhesion_id as unique_field,
    count(*) as n_records

from "projet_siad_elt"."silver"."silver_adhesion_detail"
where adhesion_id is not null
group by adhesion_id
having count(*) > 1


