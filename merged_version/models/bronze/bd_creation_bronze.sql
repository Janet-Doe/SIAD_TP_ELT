create table bronze_prestations_sante (
num_sinistre text,
num_adhesion text,
acte text,
designation_acte text,
libelle_bareme text,
num_beneficiaire text,
num_beneficiaire_sinistre text,
jour_debut_soins text,
mois_debut_soins text,
annee_debut_soins text,
jour_paiement text,
mois_paiement text,
annee_paiement text,
frais_reel_assure text,
montant_secu text,
montant_rembourse text
);

create table bronze_adhesion_detail (
NUM_ADHESION_NORMALISE text,
NUM_BENEFICIAIRE_UNIQUE text,
DATE_NAISSANCE_ASSURE text,
CODE_POSTAL text,
EXERCICE_PAIEMENT text,
NUM_BENEFICIAIRE text,
TYPE_BENEFICIAIRE text,
DATE_NAISSANCE_BENEFICIAIRE text, 
CODE_PROFESSION text,
CODE_PRODUIT text,
CODE_FRACTIONNEMENT text,
CODE_GARANTIE text,
FORMULE text,
PRIMES_ACQUISES text,
CODE_AGENT text,
CODE_REGION text,
PRIME_GARANTIE text
);

create table bronze_classification (
Niveau text,
Code text,
Categorie text,
Famille_metier text,
Intitule text
);

create table bronze_meteo (
date text,
departement text,
tempmin text,
tempmax text,
ventmax text,
precip text
);

create table bronze_dept_region (
DEPARTMENTCODE text,
DEPARTMENTNAME text,
REGIONCODE text,
REGIONNAME text
);

create table bronze_beneficiaire (
NUM_BENEFICIAIRE text,
SEXE text,
REGIME_SOCIAL text
);
