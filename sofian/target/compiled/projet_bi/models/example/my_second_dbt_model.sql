
-- Use the `ref` function to select from other models

select *
from "projet_siad_elt"."silver"."my_first_dbt_model"
where id = 1