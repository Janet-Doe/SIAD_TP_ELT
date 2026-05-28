select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

with all_values as (

    select
        regime_social as value_field,
        count(*) as n_records

    from "Projet_Siad"."Silver"."beneficiaire"
    group by regime_social

)

select *
from all_values
where value_field not in (
    'Agricole','General','Spécial'
)



      
    ) dbt_internal_test