with Ada.Command_Line;
with Ada.Wide_Wide_Text_IO;

generic

   Nombre_D_Arguments_Min : Natural := 1;
   --  Si le nombre d'arguments minimum vaut 0 alors l'aide ne
   --  s'affichera pas si le programme est appelé sans arguments.
   Nombre_D_Arguments_Max : Natural := 1;
   --  Le nombre maximum d'arguments autorisé sur la ligne de commandes.

--  @summary
--  L'exécuteur de programme.
--  @description
--  L'exécuteur se charge de vérifier les arguments donné sur la ligne de
--  commande, puis d'extraire les valeurs. Dans une unité séparé il
--  contient également la méthode de lancement du programme.
--  @group Exécuteur
package Executeur_G is

   pragma Elaborate_Body;

   pragma Compile_Time_Error
      (
         Nombre_D_Arguments_Min > Nombre_D_Arguments_Max,
         "Le nombre d'arguments max doit etre superieur " &
         "au nombre d'arguments minimum."
      );

   Trop_D_Arguments_E         : exception;
   --  Trop d'arguments ont été donné.
   Pas_Assez_D_Arguments_E    : exception;
   --  Pas assez d'arguments ont été donné.
   Option_Incorrect_E         : exception;
   --  Si une option ne correspond pas exactement à ce qui est attendu.
   Valeur_Option_Incorrect_E  : exception;
   --  La valeur donnée avec l'option n'est pas valide.

   package W_W_IO_R renames Ada.Wide_Wide_Text_IO;

   Nb_Args     : constant Natural := Ada.Command_Line.Argument_Count;
   --  Le nombre d'arguments sur la ligne de commande.
   Nb_Args_Max : constant Natural := Nombre_D_Arguments_Max;
   --  Le nombre maximum d'arguments autorisé sur la ligne de commande.

   subtype Arguments_En_Trop_T is Natural range Nb_Args_Max + 1 .. Nb_Args;
   --  L'intervalle des arguments en trop.

   procedure Afficher_Aide;
   --  Affiche l'aide du programme.

   procedure Verifier_Nombre_D_Arguments;
   --  Vérifie combien d'arguments ont été donné sur la ligne de
   --  commande.

   procedure Executer;
   --  Exécute le programme.

end Executeur_G;
