# Projet ELT dbt - Beneficiaire

Ce projet dbt construit la couche silver a partir de la table brute PostgreSQL
deja existante dans le schema `"Bronze"`:

- `source('pg_bronze', 'bronze_beneficiaire')`: table brute existante, lue par dbt.
- `beneficiaire`: couche silver fiable avec typage, controles et libelles metier.
- `beneficiaire_rejets`: lignes isolees car incompletes, invalides ou incoherentes.

## Table source attendue

La table brute doit deja exister dans PostgreSQL, par defaut dans le schema `"Bronze"`:

```sql
create table bronze_beneficiaire (
    NUM_BENEFICIAIRE text,
    SEXE text,
    REGIME_SOCIAL text
);
```

Dans PostgreSQL, ces noms non guillemetes sont stockes en minuscules:
`num_beneficiaire`, `sexe`, `regime_social`.

Le schema `"Bronze"` est sensible a la casse car il a ete cree avec une
majuscule. Le fichier `models/sources.yml` active donc `quoting.schema: true`
pour que dbt genere bien `"Bronze".bronze_beneficiaire`.

## Regles silver

```text
NUM_BENEFICIAIRE vide       -> rejet
NUM_BENEFICIAIRE non entier -> rejet
NUM_BENEFICIAIRE duplique   -> rejet
SEXE vide                   -> rejet
SEXE = 'M'                  -> Homme
autre SEXE non vide         -> Femme
REGIME_SOCIAL vide          -> rejet
REGIME_SOCIAL = 'A'         -> Agricole
REGIME_SOCIAL = 'G'         -> General
autre REGIME_SOCIAL non vide -> Spécial
```

Types en sortie de `silver.beneficiaire`:

```text
NUM_BENEFICIAIRE -> integer
SEXE             -> string
REGIME_SOCIAL    -> string
```

## Configuration locale

Le fichier `profiles.yml` lit les variables d'environnement suivantes:

```powershell
$env:DBT_POSTGRES_HOST = "localhost"
$env:DBT_POSTGRES_PORT = "5432"
$env:DBT_POSTGRES_USER = "postgres"
$env:DBT_POSTGRES_PASSWORD = "mot_de_passe"
$env:DBT_POSTGRES_DB = "Projet_Siad"
$env:DBT_RAW_SCHEMA = "Bronze"
$env:DBT_POSTGRES_SCHEMA = "Silver"
```

`DBT_POSTGRES_SCHEMA` sert de schema dbt par defaut. Les modeles dbt sont
crees dans le schema `"Silver"`. dbt ne cree pas de modele dans `"Bronze"`.

## Commandes de test

Depuis ce dossier:

```powershell
dbt debug --profiles-dir .
dbt run --profiles-dir .
dbt test --profiles-dir .
```

Si `dbt debug` affiche `fe_sendauth: no password supplied`, renseigne
`DBT_POSTGRES_PASSWORD` avant de relancer la commande.

Pour lancer seulement les modeles silver:

```powershell
dbt run --profiles-dir . --select silver
dbt test --profiles-dir . --select beneficiaire
```

## Resultat attendu

Apres `dbt run`, la couche silver contient une table:

```sql
select *
from "Silver".beneficiaire;
```

Les lignes non conformes sont consultables avec:

```sql
select *
from "Silver".beneficiaire_rejets;
```
