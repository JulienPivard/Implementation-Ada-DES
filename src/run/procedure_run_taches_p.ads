with Procedure_Run_G;
with Des_P.Chaine_P.Tasches_P.Faiseur_Chiffre_P;
--  Interdit l'utilisation d'un pragma Pure ou Preelaborate
with Des_P.Chaine_P.Tasches_P.Faiseur_Dechiffre_P;
--  Interdit l'utilisation d'un pragma Pure ou Preelaborate

pragma Elaborate_All (Procedure_Run_G);

package Procedure_Run_Taches_P is new
   Procedure_Run_G
   (
      Extension                  => "task",
      Nom_Version                => "taches",
      Faiseur_Chiffrement_G_T    =>
      Des_P.Chaine_P.Tasches_P.Faiseur_Chiffre_P.Faiseur_Chiffrement_T,
      Faiseur_Dechiffrement_G_T  =>
      Des_P.Chaine_P.Tasches_P.Faiseur_Dechiffre_P.Faiseur_Dechiffrement_T
   );
