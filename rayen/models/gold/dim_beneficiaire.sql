{{ config(materialized='table') }}

select
    cast(num_beneficiaire as integer) as "BENEFICIAIRE_ID",
    cast(sexe as text) as "SEXE",
    cast(regime_social as text) as "REGIME_SOCIAL"
from {{ ref('silver_beneficiaire') }}
