------------------------------------------------------------------------------
--                                                                          --
--                          Auteur : PIVARD Julien                          --
--           Dernière modification : Samedi 20 avril[04] 2019
--                                                                          --
------------------------------------------------------------------------------
pragma Profile (Ravenscar);

with Ada.Command_Line;

with Des_P.Clef_P.Clef_64_P;
with Procedure_Run_Ravenscar_P;
with Des_P.Chaine_P.Ravenscar_P;
with Gerer_Options_P;

pragma Elaborate_All (Procedure_Run_Ravenscar_P);

---------------------------------------------------------------------------
procedure Client_Ravenscar is
   ---------------------------------------------------------------------------
   procedure Avorter_Taches;

   procedure Avorter_Taches is
   begin
      Des_P.Chaine_P.Ravenscar_P.Faire_Avorter;
   end Avorter_Taches;
   ---------------------------------------------------------------------------

   use type Gerer_Options_P.Action_T;

   Action : Procedure_Run_Ravenscar_P.Action_T;
   Clef   : Des_P.Clef_P.Clef_64_P.Clef_T;
begin

   Gerer_Options_P.Verifier_Nombre_Arguments;

   Action :=
      (
         if
            Gerer_Options_P.Lire_Option_1_Optionnel = Gerer_Options_P.Chiffrer
         then
            Procedure_Run_Ravenscar_P.Chiffrer
         else
            Procedure_Run_Ravenscar_P.Dechiffrer
      );

   Clef := Gerer_Options_P.Lire_Option_Clef;

   Ouverture_Fichier :
   declare
      Nom_Fichier : constant String :=
         Gerer_Options_P.Lire_Option_Nom_Fichier;
   begin
      --  Lancement du chiffrement ou déchiffrement
      Procedure_Run_Ravenscar_P.Executer_Chiffrement
         (
            Clef        => Clef,
            Nom_Fichier => Nom_Fichier,
            Action      => Action
         );
   end Ouverture_Fichier;

   Avorter_Taches;
   Ada.Command_Line.Set_Exit_Status (Code => Ada.Command_Line.Success);

exception
   when Gerer_Options_P.Options_Incorrect_E =>
      Avorter_Taches;

end Client_Ravenscar;
