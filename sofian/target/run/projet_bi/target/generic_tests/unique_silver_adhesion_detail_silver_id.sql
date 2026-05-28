
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    silver_id as unique_field,
    count(*) as n_records

from "projet_siad_elt"."silver"."silver_adhesion_detail"
where silver_id is not null
group by silver_id
having count(*) > 1



  
  
      
    ) dbt_internal_test