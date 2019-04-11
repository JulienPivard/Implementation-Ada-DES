------------------------------------------------------------------------------
--                                                                          --
--                          Auteur : PIVARD Julien                          --
--           Dernière modification : Jeudi 11 avril[04] 2019
--                                                                          --
------------------------------------------------------------------------------

with Ada.Command_Line;

with Des_P.Clef_P.Clef_64_P;
with Procedure_Run_Sequentiel_P;
with Gerer_Options_P;

---------------------------------------------------------------------------
procedure Client_Sequentiel is
   use type Gerer_Options_P.Action_T;

   Action : Procedure_Run_Sequentiel_P.Action_T;
   Clef   : Des_P.Clef_P.Clef_64_P.Clef_T;
begin

   Gerer_Options_P.Verifier_Nombre_Arguments;

   Action :=
      (
         if
            Gerer_Options_P.Lire_Option_1_Optionnel = Gerer_Options_P.Chiffrer
         then
            Procedure_Run_Sequentiel_P.Chiffrer
         else
            Procedure_Run_Sequentiel_P.Dechiffrer
      );

   Clef := Gerer_Options_P.Lire_Option_Clef;

   Ouverture_Fichier :
   declare
      Nom_Fichier : constant String :=
         Gerer_Options_P.Lire_Option_Nom_Fichier;
   begin
      --  Lancement du chiffrement
      Procedure_Run_Sequentiel_P.Executer_Chiffrement
         (
            Clef        => Clef,
            Nom_Fichier => Nom_Fichier,
            Action      => Action
         );
   end Ouverture_Fichier;

   Ada.Command_Line.Set_Exit_Status (Code => Ada.Command_Line.Success);

exception
   when Gerer_Options_P.Options_Incorrect_E =>
      null;

end Client_Sequentiel;
