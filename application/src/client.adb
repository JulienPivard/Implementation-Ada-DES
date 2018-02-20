------------------------------------------------------------------------------
--                                                                          --
--                          Auteur : PIVARD Julien                          --
--           Dernière modification : Mardi 20 février[02] 2018
--                                                                          --
------------------------------------------------------------------------------

with Ada.Text_IO;
with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with Ada.Command_Line;
with Ada.Directories;

with Des_P.Chaine_P.Sequentiel_P;
with Des_P.Filtre_P.Fabrique_P.Fabrique_Cryptage_P;
with Des_P.Filtre_P.Fabrique_P.Fabrique_Decryptage_P;
with Des_P.Filtre_P.Fabrique_P.Holder_P;

with Des_P.Clef_P.Constructeur_64_Abs_P;
with Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P;
with Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P.Constructeur_64_P;
with Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Constructeur_56_P;
with Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Constructeur_48_P;

procedure Client is

   Nb_Arguments : constant Natural := Ada.Command_Line.Argument_Count;
   Nb_Arguments_Max : constant Natural := 3;

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
      Put (Standard_Error, " [option] <nom_fichier> <clef>");
      Put_Line (Standard_Error, "");
      Put_Line (Standard_Error, "-c --crypter");
      Put_Line (Standard_Error, "  Crypte le fichier avec la clef.");
      Put_Line (Standard_Error, "-d --decrypter");
      Put_Line (Standard_Error, "  Décrypte le ficher avec la clef.");
      Put_Line (Standard_Error, "");
   end Afficher_Aide;
   ---------------------------------------------------------------------------

   type Action_T is (Crypter, Decrypter);
   Action : Action_T := Crypter;

   Clef : Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P.Clef_64_T;

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

   elsif Nb_Arguments < 2 then

      Afficher_Aide;
      Put_Line
         (
            Standard_Error,
            "Vous devez donner au moins le <nom_fichier> et la <clef>."
         );
      Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
      return;

   end if;

   if Nb_Arguments = 3 then
      declare
         Crypt_Decrypt : constant String := Ada.Command_Line.Argument (1);
      begin
         if Crypt_Decrypt = "-c" or else Crypt_Decrypt = "--crypter" then
            Action := Crypter;
         elsif Crypt_Decrypt = "-d" or else Crypt_Decrypt = "--decrypter" then
            Action := Decrypter;
         else
            Put (Standard_Error, "L'argument [");
            Ada.Text_IO.Put (Ada.Text_IO.Standard_Error, Crypt_Decrypt);
            Put_Line
               (
                  Standard_Error,
                  "] n'est pas valable"
               );
            Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
            return;
         end if;
      end;
   end if;

   Lire_Clef :
   declare
      Position_Clef : constant Positive :=
         (if Nb_Arguments = 3 then 3 else 2);
      Clef_Brut : String := Ada.Command_Line.Argument (Position_Clef);
      Taille_Clef : Natural;
   begin
      Taille_Clef := Clef_Brut'Size / 8;
      if Taille_Clef /= 8 then
         Put_Line (Standard_Error, "██████ Erreur !");
         Put_Line (Standard_Error,
               "   La taille de la clef doit être de 8 octets exactement.");
         Ada.Text_IO.Put ("   ");
         Put ("Taille actuelle de la clef : ");
         Ada.Text_IO.Put (Taille_Clef'Img);
         Ada.Text_IO.Put_Line (" octets.");

         Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
         return;
      end if;

      declare
         use  Des_P.Clef_P.Constructeur_64_Abs_P;
         use  Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P.Constructeur_64_P;
         use  Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Constructeur_56_P;
         use  Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Constructeur_48_P;
         Brut_Clef : Clef_64_Brut_T with Address => Clef_Brut'Address;
         C_C_64 : Constructeur_Clef_64_T;
         C_C_56 : constant access Constructeur_Clef_56_T :=
            new Constructeur_Clef_56_T;
         C_C_48 : constant access Constructeur_Clef_48_T :=
            new Constructeur_Clef_48_T;
      begin
         C_C_64.Preparer_Nouvelle_Clef_64;
         C_C_64.Construire_Clef_64 (Brut_Clef);
         C_C_64.Construire_Ajouter_Constructeur_56 (C_C_56);
         C_C_64.Construire_Ajouter_Constructeur_48 (C_C_48);
         Clef := C_C_64.Recuperer_Clef_64;
      end;
   end Lire_Clef;

   Ouverture_Fichier :
   declare
      Position_Nom_Fic : constant Positive :=
         (if Nb_Arguments = 3 then 2 else 1);
      Nom_Fichier : constant String := Ada.Command_Line.Argument
         (Position_Nom_Fic);
      Depassement_Octets_Fichier : Ada.Directories.File_Size;
      use type Ada.Directories.File_Size;

      Chaine : Des_P.Chaine_P.Sequentiel_P.Chaine_T;
      Fabrique : Des_P.Filtre_P.Fabrique_P.Holder_P.Holder;
      Fab_Crypt :
      Des_P.Filtre_P.Fabrique_P.Fabrique_Cryptage_P.Fabrique_Cryptage_T;
      Fab_Decrypt :
      Des_P.Filtre_P.Fabrique_P.Fabrique_Decryptage_P.Fabrique_Decryptage_T;
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
         Ada.Text_IO.Put_Line (" Octets de trop.");

         Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
         return;
      end if;

      case Action is
         when Crypter =>
            Fabrique := Des_P.Filtre_P.Fabrique_P.Holder_P.To_Holder
               (Fab_Crypt);
         when Decrypter =>
            Fabrique := Des_P.Filtre_P.Fabrique_P.Holder_P.To_Holder
               (Fab_Decrypt);
      end case;

      Chaine.Initiliser (Fabrique.Element, Clef);
      Chaine.Filtrer (Nom_Fichier, Fabrique.Element.Lire_Extention);
   end Ouverture_Fichier;

   Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Success);
   return;

end Client;
