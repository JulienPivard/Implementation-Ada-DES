with Ada.Wide_Wide_Text_IO;
--  Interdit l'utilisation d'un pragma Pure ou Preelaborate
with Ada.Command_Line;
--  Interdit l'utilisation d'un pragma Pure

with Des_P.Clef_P.Clef_64_P;

--  @summary
--  Gestion des options.
--  @description
--  Gère les arguments donné sur la ligne de commande et permet
--  de récupérer les valeurs associé.
--  @group Options
package Gerer_Options_P
   with Elaborate_Body
is

   Options_Incorrect_E : exception;
   --  Une erreur c'est produite durant la lecture des options.

   package W_W_IO_R renames Ada.Wide_Wide_Text_IO;

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   Nb_Args     : constant Natural := Ada.Command_Line.Argument_Count;
   --  Le nombre d'arguments actuellement sur la ligne de commande.
   Nb_Args_Max : constant Natural := 3;
   --  Le nombre d'arguments maximum autorisé.

   subtype Args_En_Trop_T is Integer range Nb_Args_Max + 1 .. Nb_Args;
   --  Une énumération de tous les arguments au delà du nombre maximum
   --  autorisé.

   type Action_T is (Chiffrer, Dechiffrer);
   --  @value Chiffrer Indique que l'utilisateur à demandé de chiffrer.
   --  @value Dechiffrer Indique que l'utilisateur à demandé à déchiffrer.

   procedure Afficher_Aide;
   --  Affiche l'aide d'utilisation du programme.

   procedure Verifier_Nombre_Arguments;
   --  Vérifie que le nombre d'arguments est correct.
   --  Si ce n'est pas le cas affiche une erreur.

   function Lire_Option_1_Optionnel return Action_T;
   --  Lit la valeur de la première option si elle est présente.

   function Lire_Option_Clef return Des_P.Clef_P.Clef_64_P.Clef_T;
   --  Lit et construit la clef donnée en entrée.

   function Lire_Option_Nom_Fichier return String;
   --  Lit et récupère le nom du fichier

end Gerer_Options_P;
