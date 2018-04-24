with Procedure_Run_G;
with Des_P.Chaine_P.Taches_P.Faiseur_Chiffre_P;
with Des_P.Chaine_P.Taches_P.Faiseur_Dechiffre_P;

package Procedure_Run_Taches_P is new
Procedure_Run_G
   (
      Extension => "task",
      Faiseur_Chiffrement_G_T =>
      Des_P.Chaine_P.Taches_P.Faiseur_Chiffre_P.Faiseur_Chiffrement_T,
      Faiseur_Dechiffrement_G_T =>
      Des_P.Chaine_P.Taches_P.Faiseur_Dechiffre_P.Faiseur_Dechiffrement_T
   );
