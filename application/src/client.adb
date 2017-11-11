------------------------------------------------------------------------------
--                                                                          --
--                          Auteur : PIVARD Julien                          --
--           Dernière modification : Mardi 17 octobre[10] 2017
--                                                                          --
------------------------------------------------------------------------------

with Ada.Text_IO;
with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with Ada.Command_Line;
with Ada.Directories;

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

begin

   if Nb_Arguments = 0 then

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

   --  Mettez votre code ici

   Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Success);
   return;

end Client;
