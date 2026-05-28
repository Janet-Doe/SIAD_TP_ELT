# Documentation elt_projet

## Configuration PostgreSQL (Important pour les collaborateurs)
Ce projet nécessite une base de données PostgreSQL. 

**Vous devez créer ou modifier le fichier `profiles.yml` sur votre machine :**
- Sous Windows : `C:\Users\VotreNom\.dbt\profiles.yml`
- Sous Mac/Linux : `~/.dbt/profiles.yml`

Ajoutez cette configuration en remplaçant par vos propres identifiants :
```yaml
projet_bi:
  target: dev
  outputs:
    dev:
      type: postgres
      host: localhost
      user: votre_utilisateur
      password: votre_mot_de_passe
      port: 5432
      dbname: nom_de_la_base
      schema: public
      threads: 1
```

## Fichiers du projet
- Fichier projet : dbt_project.yml
- Sources : models/source.yml

## Commandes dbt
- Installation : `dbt deps`
- Vérification de la connexion : `dbt debug`
- Execution : `dbt run --select silver`
- Tests : `dbt test --select silver`

## Structure
Ce dossier contient uniquement la couche Silver et les fichiers de configuration associés. Le code a été nettoyé et respecte la nomenclature en minuscules.
