{{ config(materialized='table') }}

{% if var('enable_gold_fait_sinistre_source', false) %}

with silver_sinistre as (
    select *
    from {{ source('pg_silver', 'silver_sinistre') }}
)

select
    cast("Benid" as integer) as "Benid",
    cast(null as integer) as "Age",
    cast(null as date) as "DateSoins",
    cast(null as date) as "DateRemb",
    cast(null as integer) as "acteid",
    cast(null as integer) as "contratid",
    cast(null as integer) as "adresseid",
    cast("Temperature" as numeric) as "Temperature",
    cast("Anciennete" as integer) as "Anciennete",
    cast("Frais Reel" as numeric) as "Frais Reel",
    cast("MontantSecu" as numeric) as "MontantSecu",
    cast("MontantMut" as numeric) as "MontantMut"
from silver_sinistre

{% else %}

select
    cast(null as integer) as "Benid",
    cast(null as integer) as "Age",
    cast(null as date) as "DateSoins",
    cast(null as date) as "DateRemb",
    cast(null as integer) as "acteid",
    cast(null as integer) as "contratid",
    cast(null as integer) as "adresseid",
    cast(null as numeric) as "Temperature",
    cast(null as integer) as "Anciennete",
    cast(null as numeric) as "Frais Reel",
    cast(null as numeric) as "MontantSecu",
    cast(null as numeric) as "MontantMut"
where false

{% endif %}
