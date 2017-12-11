------------------------------------------------------------------------------
--                                                                          --
--                          Auteur : PIVARD Julien                          --
--           Dernière modification : lundi 11 décembre[12] 2017
--                                                                          --
------------------------------------------------------------------------------

with Ada.Text_IO;
with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with Ada.Command_Line;
with Ada.Directories;

--  with Ada.Sequential_IO;

with Des_P.Bloc_P.Bloc_32_P;
with Des_P.Bloc_P.Bloc_32_P.Bloc_IO;
with Des_P.Bloc_P.Bloc_32_P.Constructeur_P;

procedure Client is

   Nb_Arguments : constant Natural := Ada.Command_Line.Argument_Count;

   ---------------------------------------------------------------------------
   procedure Afficher_Aide;

   procedure Afficher_Aide is
   begin
      Put_Line (Standard_Error, "Utilisation du programme :");
      Ada.Text_IO.Put
         (
            Ada.Text_IO.Standard_Error,
            Ada.Directories.Base_Name (Ada.Command_Line.Command_Name)
         );
      Put (Standard_Error, " [arguments]");
      Put_Line (Standard_Error, "");
   end Afficher_Aide;
   ---------------------------------------------------------------------------

   --  package Lecteur_32_IO is new Ada.Sequential_IO
   --  (Des_P.Bloc_32_P.Constructeur_P.Bloc_32_Brut_T);
   c : Des_P.Bloc_P.Bloc_32_P.Constructeur_P.Constructeur_Bloc_32_T;
   --  f : Lecteur_32_IO.File_Type;
   brut : constant Des_P.Bloc_P.Bloc_32_P.Constructeur_P.Bloc_32_Brut_T :=
      2#1111_0000_1111_0000_1111_0000_1111_0000#;
   bloc : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;

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

   --  Lecteur_32_IO.Open (f, Lecteur_32_IO.In_File, "test.txt");

   --  Lecteur_32_IO.Read (f, brut);

   c.Preparer_Nouveau_Bloc_32 (brut);
   c.Construire_Bloc;
   bloc := c.Recuperer_Bloc_32;

   Des_P.Bloc_P.Bloc_32_P.Bloc_IO.Put_Line (bloc);

   --  Lecteur_32_IO.Close (f);

   Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Success);
   return;

end Client;
