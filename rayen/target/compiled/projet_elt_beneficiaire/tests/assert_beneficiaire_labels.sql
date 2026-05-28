select *
from "Projet_Siad"."Silver"."beneficiaire"
where sexe not in ('Homme', 'Femme')
   or regime_social not in ('Agricole', 'General', 'Spécial')