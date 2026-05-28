
    
    

select
    silver_id as unique_field,
    count(*) as n_records

from "projet_siad_elt"."silver"."silver_adhesion_detail"
where silver_id is not null
group by silver_id
having count(*) > 1


