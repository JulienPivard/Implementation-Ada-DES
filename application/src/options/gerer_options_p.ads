with Ada.Wide_Wide_Text_IO;
with Ada.Command_Line;

with Des_P.Clef_P.Clef_64_P;

package Gerer_Options_P is

   Options_Incorrect_E : exception;

   package W_W_IO_R renames Ada.Wide_Wide_Text_IO;

   Nb_Args     : constant Natural := Ada.Command_Line.Argument_Count;
   Nb_Args_Max : constant Natural := 3;

   subtype Args_En_Trop_T is Integer range Nb_Args_Max + 1 .. Nb_Args;

   type Action_T is (Chiffrer, Dechiffrer);
   --  @value Chiffrer Indique que l'utilisateur à demandé de chiffrer
   --  @value Dechiffrer Indique que l'utilisateur à demandé à déchiffrer

   procedure Afficher_Aide;

   procedure Verifier_Nombre_Arguments;

   function Lire_Option_1_Optionnel return Action_T;

   function Lire_Option_Clef return Des_P.Clef_P.Clef_64_P.Clef_T;

   function Lire_Option_Nom_Fichier return String;

end Gerer_Options_P;
