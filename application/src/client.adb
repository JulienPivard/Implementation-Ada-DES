------------------------------------------------------------------------------
--                                                                          --
--                          Auteur : PIVARD Julien                          --
--           Dernière modification : Lundi 05 mars[03] 2018
--                                                                          --
------------------------------------------------------------------------------

with Ada.Text_IO;
with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with Ada.Command_Line;
with Ada.Directories;

with Ada.Calendar;

with Des_P.Chaine_P.Sequentiel_P;
with Des_P.Chaine_P.Constructeur_I_P;
with Des_P.Chaine_P.Sequentiel_P.Constructeur_Cryptage_P;
with Des_P.Chaine_P.Sequentiel_P.Constructeur_Decryptage_P;

with Des_P.Clef_P.Clef_64_I_P.Constructeur_I_P;
with Des_P.Clef_P.Clef_64_P.Constructeur_P;
with Des_P.Clef_P.Clef_56_P.Constructeur_P;
with Des_P.Clef_P.Clef_48_P.Constructeur_P;
with Des_P.Clef_P.Clef_64_P;

procedure Client is

   Nb_Arguments : constant Natural := Ada.Command_Line.Argument_Count;
   Nb_Arguments_Max : constant Natural := 3;

   package Faiseur_56_P renames Des_P.Clef_P.Clef_56_P.Constructeur_P;
   package Faiseur_48_P renames Des_P.Clef_P.Clef_48_P.Constructeur_P;

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

   package Faiseur_P renames Des_P.Chaine_P.Constructeur_I_P;
   ---------------------------------------------------------------------------
   function Init_Faiseur_Chaine
      (Action : Action_T)
      return Faiseur_P.Constructeur_Interface_T'Class;

   function Init_Faiseur_Chaine
      (Action : Action_T)
      return Faiseur_P.Constructeur_Interface_T'Class
   is
      package Faiseur_S_C_P renames
         Des_P.Chaine_P.Sequentiel_P.Constructeur_Cryptage_P;
      package Faiseur_S_D_P renames
         Des_P.Chaine_P.Sequentiel_P.Constructeur_Decryptage_P;
      Const_Crypt_S : Faiseur_S_C_P.Constructeur_Cryptage_T;
      Const_Decry_S : Faiseur_S_D_P.Constructeur_Decryptage_T;
   begin
      return
         (
            case Action is
               when Crypter => Const_Crypt_S,
               when Decrypter => Const_Decry_S
         );
   end Init_Faiseur_Chaine;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Executer_Crypt_Decrypt
      (
         Faiseur : in out Faiseur_P.Constructeur_Interface_T'Class;
         Clef : Des_P.Clef_P.Clef_64_P.Clef_T;
         Nom_Fichier : String;
         Action : Action_T
      );

   procedure Executer_Crypt_Decrypt
      (
         Faiseur : in out Faiseur_P.Constructeur_Interface_T'Class;
         Clef : Des_P.Clef_P.Clef_64_P.Clef_T;
         Nom_Fichier : String;
         Action : Action_T
      )
   is
      F_56 : Faiseur_56_P.Constructeur_Clef_T;
      F_48 : Faiseur_48_P.Constructeur_Clef_T;
   begin
      Faiseur.Initialiser (F_56, F_48);
      Faiseur.Construire (Clef);
      Mesure_Temps :
      declare
         Chaine : Des_P.Chaine_P.Chaine_Interface_T'Class :=
            Faiseur.Recuperer_Chaine;

         Extension : constant String :=
               (
                  case Action is
                     when Crypter => "crypt",
                     when Decrypter => "decrypt"
               );

         Debut, Fin : Ada.Calendar.Time;
         Duree : Duration;
         package Duree_IO is new
         Ada.Text_IO.Fixed_IO (Duration);
         use type Ada.Calendar.Time;
      begin
         Debut := Ada.Calendar.Clock;
         Chaine.Filtrer
            (
               Nom_Fichier,
               Extension
            );
         Fin := Ada.Calendar.Clock;
         Duree := Fin - Debut;

         --------------------------------------
         Ada.Text_IO.New_Line (1);
         Ada.Text_IO.Put ("Temps séquentielle : ");
         Ada.Text_IO.New_Line (1);
         Duree_IO.Put (Duree);
         Ada.Text_IO.Put_Line (" s");
         if Duree > 60.0 then
            Duree_IO.Put (Duree / 60.0);
            Ada.Text_IO.Put_Line (" min");
         end if;
         if Duree > 3600.0 then
            Duree_IO.Put (Duree / 3600.0);
            Ada.Text_IO.Put_Line (" h");
         end if;
         Ada.Text_IO.New_Line (1);
         --------------------------------------
      end Mesure_Temps;
   end Executer_Crypt_Decrypt;

   ---------------------------------------------------------------------------

   Clef : Des_P.Clef_P.Clef_64_P.Clef_T;

begin

   if Nb_Arguments = 0 then

      Afficher_Aide;
      Ada.Command_Line.Set_Exit_Status
         (Ada.Command_Line.Success);
      return;

   elsif Nb_Arguments > Nb_Arguments_Max then

      Afficher_Aide;
      Put (Standard_Error, "Trop d'arguments. ");
      Put_Line
         (Standard_Error, "Les arguments suivants sont invalide : ");
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
      Ada.Command_Line.Set_Exit_Status
         (Ada.Command_Line.Failure);
      return;

   end if;

   if Nb_Arguments = 3 then
      declare
         Crypt_Decrypt : constant String :=
            Ada.Command_Line.Argument (1);
      begin
         if
            Crypt_Decrypt = "-c"
            or else
            Crypt_Decrypt = "--crypter"
         then
            Action := Crypter;
         elsif
            Crypt_Decrypt = "-d"
            or else
            Crypt_Decrypt = "--decrypter"
         then
            Action := Decrypter;
         else
            Put (Standard_Error, "L'argument [");
            Ada.Text_IO.Put
               (Ada.Text_IO.Standard_Error, Crypt_Decrypt);
            Put_Line
               (
                  Standard_Error,
                  "] n'est pas valable"
               );
            Ada.Command_Line.Set_Exit_Status
               (Ada.Command_Line.Failure);
            return;
         end if;
      end;
   end if;

   Initialiser_Clef :
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
         Brut_Clef :
         Des_P.Clef_P.Clef_64_I_P.Constructeur_I_P.Clef_64_Brut_T
            with Address => Clef_Brut'Address;
         C_C_64 :
         Des_P.Clef_P.Clef_64_P.Constructeur_P.Constructeur_Clef_T;
      begin
         C_C_64.Preparer_Nouvelle_Clef;
         C_C_64.Construire_Clef (Brut_Clef);
         Clef := C_C_64.Recuperer_Clef;
      end;
   end Initialiser_Clef;

   Ouverture_Fichier :
   declare
      Position_Nom_Fic : constant Positive :=
         (if Nb_Arguments = 3 then 2 else 1);
      Nom_Fichier : constant String := Ada.Command_Line.Argument
         (Position_Nom_Fic);
      Octets_En_Trop : Ada.Directories.File_Size;
      use type Ada.Directories.File_Size;

      Faiseur : Faiseur_P.Constructeur_Interface_T'Class :=
         Init_Faiseur_Chaine (Action);
   begin
      if not Ada.Directories.Exists (Nom_Fichier) then
         Put_Line (Standard_Error, "██████ Erreur !");
         Put (Standard_Error, "   Le fichier [");
         Ada.Text_IO.Put
            (Ada.Text_IO.Standard_Error, Nom_Fichier);
         Put_Line (Standard_Error, "] n'existe pas");

         Ada.Command_Line.Set_Exit_Status
            (Ada.Command_Line.Failure);
         return;
      end if;

      Octets_En_Trop :=
         Ada.Directories.Size (Nom_Fichier) mod 8;

      --  La taille est en octet, 64 bits fait 8 octets,
      --  d'où l'utilisation de mod 8.
      if not (Octets_En_Trop = 0) then
         Put_Line (Standard_Error, "██████ Erreur !");
         Ada.Text_IO.Put_Line
            (
               Ada.Text_IO.Standard_Error,
               "   La taille du fichier n'est pas un multiple de 64 bits."
            );
         Ada.Text_IO.Put ("   ");
         Ada.Text_IO.Put (Octets_En_Trop'Img);
         Ada.Text_IO.Put_Line (" Octets de trop.");

         Ada.Command_Line.Set_Exit_Status
            (Ada.Command_Line.Failure);
         return;
      end if;

      Executer_Crypt_Decrypt (Faiseur, Clef, Nom_Fichier, Action);

   end Ouverture_Fichier;

   Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Success);
   return;

end Client;
