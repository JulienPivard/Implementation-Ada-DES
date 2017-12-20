------------------------------------------------------------------------------
--                                                                          --
--                          Auteur : PIVARD Julien                          --
--           Dernière modification : Mercredi 20 décembre[12] 2017
--                                                                          --
------------------------------------------------------------------------------

with Ada.Text_IO;
with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with Ada.Command_Line;
with Ada.Directories;

with Ada.Sequential_IO;

with Des_P.Bloc_P.Bloc_64_P;
with Des_P.Bloc_P.Bloc_64_P.Bloc_IO;
with Des_P.Bloc_P.Bloc_64_P.Constructeur_P;

pragma Elaborate_All (Des_P.Bloc_P.Bloc_64_P);

procedure Client is

   Nb_Arguments : constant Natural := Ada.Command_Line.Argument_Count;

   ---------------------------------------------------------------------------
   procedure Afficher_Aide;

   procedure Afficher_Aide is
   begin
      Put_Line (Standard_Error, "Utilisation du programme :");
      Ada.Text_IO.Put ("   ");
      Ada.Text_IO.Put
         (
            Ada.Text_IO.Standard_Error,
            Ada.Directories.Base_Name (Ada.Command_Line.Command_Name)
         );
      Put (Standard_Error, " [arguments]");
      Put_Line (Standard_Error, "");
   end Afficher_Aide;
   ---------------------------------------------------------------------------

   package Lecteur_64_IO is new Ada.Sequential_IO
   (Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T);
   c : Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Constructeur_Bloc_64_T;
   f : Lecteur_64_IO.File_Type;
   brut : Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T;
   --  brut : constant Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T :=
   --  2#11110000_11110000_11110000_11110000_
   --  11110000_11110000_11110000_11110000#;
   bloc : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;

   bloc_64 : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
   pragma Unreferenced (bloc_64);

begin

   if Nb_Arguments = 1 then

      Afficher_Aide;
      Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Success);
      return;

   elsif Nb_Arguments > 1 then

      Afficher_Aide;
      Put (Standard_Error, "Trop d'arguments. ");
      Put_Line (Standard_Error, "Les arguments suivants sont invalide : ");
      for i in 1 .. Nb_Arguments loop
         Put (Standard_Error, "  - ");
         Ada.Text_IO.Put_Line
            (Ada.Text_IO.Standard_Error, Ada.Command_Line.Argument (i));
      end loop;
      Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
      return;

   end if;

   Lecteur_64_IO.Open (f, Lecteur_64_IO.In_File, "test.txt");


   Lecture_Fichier :
   loop
      exit Lecture_Fichier when Lecteur_64_IO.End_Of_File (f);
      Lecteur_64_IO.Read (f, brut);

      c.Preparer_Nouveau_Bloc_64 (brut);
      c.Construire_Bloc;
      bloc := c.Recuperer_Bloc_64;

      Des_P.Bloc_P.Bloc_64_P.Bloc_IO.Put_Line (bloc);
   end loop Lecture_Fichier;

   Lecteur_64_IO.Close (f);

   Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Success);
   return;

end Client;
