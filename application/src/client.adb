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
   Nb_Arguments_Max : constant Natural := 1;

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
      Put (Standard_Error, " <nom_fichier>");
      Put_Line (Standard_Error, "");
   end Afficher_Aide;
   ---------------------------------------------------------------------------

   package Lecteur_64_IO is new Ada.Sequential_IO
   (Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T);

   C_64 : Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Constructeur_Bloc_64_T;
   Brut : Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T;
   --  Brut : constant Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T :=
   --  2#11110000_11110000_11110000_11110000_
   --  11110000_11110000_11110000_11110000#;
   Bloc : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;

   Fichier : Lecteur_64_IO.File_Type;

   --  TODO À retirer dans la version finale.
   package Numero_Ligne_IO is new Ada.Text_IO.Integer_IO (Integer);
   Compteur_Ligne : Integer := 1;

begin

   if Nb_Arguments = 0 then

      Afficher_Aide;
      Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Success);
      return;

   elsif Nb_Arguments > Nb_Arguments_Max then

      Afficher_Aide;
      Put (Standard_Error, "Trop d'arguments. ");
      Put_Line (Standard_Error, "Les arguments suivants sont invalide : ");
      for i in Nb_Arguments_Max + 1 .. Nb_Arguments loop
         Put (Standard_Error, "  - ");
         Ada.Text_IO.Put_Line
            (Ada.Text_IO.Standard_Error, Ada.Command_Line.Argument (i));
      end loop;
      Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
      return;

   end if;

   Ouverture_Fichier :
   declare
      Nom_Fichier : constant String := Ada.Command_Line.Argument (1);
      Depassement_Octets_Fichier : Ada.Directories.File_Size;
      use Ada.Directories;
   begin
      if not Ada.Directories.Exists (Nom_Fichier) then
         Ada.Wide_Wide_Text_IO.Put_Line (Standard_Error, "██████ Erreur !");
         Ada.Wide_Wide_Text_IO.Put (Standard_Error, "   Le fichier [");
         Ada.Text_IO.Put (Ada.Text_IO.Standard_Error, Nom_Fichier);
         Ada.Wide_Wide_Text_IO.Put_Line (Standard_Error, "] n'existe pas");

         Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
         return;
      end if;

      Depassement_Octets_Fichier := Ada.Directories.Size (Nom_Fichier) mod 8;

      --  La taille est en octet, 64 bits fait 8 octets,
      --  d'où l'utilisation de mod 8.
      if not (Depassement_Octets_Fichier = 0) then
         Ada.Wide_Wide_Text_IO.Put_Line (Standard_Error, "██████ Erreur !");
         Ada.Text_IO.Put_Line
            (
               Ada.Text_IO.Standard_Error,
               "   La taille du fichier n'est pas un multiple de 64 bits."
            );
         Ada.Text_IO.Put ("   ");
         Ada.Text_IO.Put (Depassement_Octets_Fichier'Img);
         Ada.Text_IO.Put (" Octets de trop.");
         Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
         return;
      end if;

      Lecteur_64_IO.Open (Fichier, Lecteur_64_IO.In_File, Nom_Fichier);
   end Ouverture_Fichier;

   Lecture_Fichier :
   loop
      exit Lecture_Fichier when Lecteur_64_IO.End_Of_File (Fichier);
      Lecteur_64_IO.Read (Fichier, Brut);

      C_64.Preparer_Nouveau_Bloc_64 (Brut);
      C_64.Construire_Bloc;
      Bloc := C_64.Recuperer_Bloc_64;

      Numero_Ligne_IO.Put (Item => Compteur_Ligne, Width => 3);
      Ada.Text_IO.Put ("   ");
      Des_P.Bloc_P.Bloc_64_P.Bloc_IO.Put_Line (Bloc);

      Compteur_Ligne := Compteur_Ligne + 1;
   end loop Lecture_Fichier;

   Lecteur_64_IO.Close (Fichier);

   Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Success);
   return;

end Client;
