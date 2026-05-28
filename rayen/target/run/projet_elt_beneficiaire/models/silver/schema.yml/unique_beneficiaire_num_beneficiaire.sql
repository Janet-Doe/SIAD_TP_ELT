select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    num_beneficiaire as unique_field,
    count(*) as n_records

from "Projet_Siad"."Silver"."beneficiaire"
where num_beneficiaire is not null
group by num_beneficiaire
having count(*) > 1



      
    ) dbt_internal_test