with Des_P.Chaine_P.Ravenscar_P;
with Des_P.Chaine_P.Ravenscar_P.Constructeur_Cryptage_P;
with Des_P.Chaine_P.Ravenscar_P.Constructeur_Decryptage_P;

with Ada.Real_Time;
with Ada.Text_IO;

package body Procedure_Run_Ravenscar_P is

   ---------------------------------------------------------------------------
   procedure Executer_Crypt_Decrypt
      (
         Clef : Des_P.Clef_P.Clef_64_P.Clef_T;
         Nom_Fichier : String;
         Action : Action_T
      )
   is
      Faiseur : Faiseur_P.Constructeur_Interface_T'Class :=
         Init_Faiseur_Chaine (Action);
      Chaine : Des_P.Chaine_P.Chaine_Interface_T'Class :=
         Init_Chaine (Faiseur, Clef);
      Extension : constant String := Init_Extension (Action);

      Debut, Fin : Ada.Real_Time.Time;
      package Duree_IO is new
      Ada.Text_IO.Fixed_IO (Duration);
      use type Ada.Real_Time.Time;
   begin
      --  Note le début du temps.
      Debut := Ada.Real_Time.Clock;
      --  Filtre le fichier.
      Chaine.Filtrer
         (
            Nom_Fichier,
            Extension
         );
      --  Note la fin du temps.
      Fin := Ada.Real_Time.Clock;

      --------------------------------------
      Ada.Text_IO.New_Line (1);
      --  Affiche le temps de filtrage du fichier.
      Ada.Text_IO.Put ("Temps ravenscar : ");
      Ada.Text_IO.New_Line (1);
      --  Conversion du temps pour faciliter l'affichage.
      Affichage_Temps :
      declare
         Duree : constant Duration :=
            Ada.Real_Time.To_Duration (Fin - Debut);
      begin
         Duree_IO.Put (Duree);
         Ada.Text_IO.Put_Line (" s");
         --  Affichage en minuttes.
         if Duree > 60.0 then
            Duree_IO.Put (Duree / 60.0);
            Ada.Text_IO.Put_Line (" min");
         end if;
         --  Affichage en heures.
         if Duree > 3600.0 then
            Duree_IO.Put (Duree / 3600.0);
            Ada.Text_IO.Put_Line (" h");
         end if;
      end Affichage_Temps;
      Ada.Text_IO.New_Line (1);
      --------------------------------------
   end Executer_Crypt_Decrypt;

   ---------------------------------------------------------------------------
   function Init_Faiseur_Chaine
      (
         Action : Action_T
      )
      return Faiseur_P.Constructeur_Interface_T'Class
   is
      package Faiseur_R_C_P renames
         Des_P.Chaine_P.Ravenscar_P.Constructeur_Cryptage_P;
      package Faiseur_R_D_P renames
         Des_P.Chaine_P.Ravenscar_P.Constructeur_Decryptage_P;
      --  Instancie tous les faiseur de chaine possible
      Const_Crypt_R : Faiseur_R_C_P.Constructeur_Cryptage_T;
      Const_Decry_R : Faiseur_R_D_P.Constructeur_Decryptage_T;
   begin
      --  Le faiseur sélectionné par le type action et le type
      --  séquentiel ou tache.
      return
         (
            case Action is
               when Crypter => Const_Crypt_R,
               when Decrypter => Const_Decry_R
         );
   end Init_Faiseur_Chaine;

   ---------------------------------------------------------------------------
   function Init_Extension
      (
         Action : Action_T
      )
      return String
   is
   begin
      --  Initialise l'extension du fichier alternatif.
      return "rave." &
         (
            case Action is
               when Crypter => "crypt",
               when Decrypter => "decrypt"
         );
   end Init_Extension;

   ---------------------------------------------------------------------------
   function Init_Chaine
      (
         Faiseur : in out Faiseur_P.Constructeur_Interface_T'Class;
         Clef : Des_P.Clef_P.Clef_64_P.Clef_T
      )
      return Des_P.Chaine_P.Chaine_Interface_T'Class
   is
      F_56 : Faiseur_56_P.Constructeur_Clef_T;
      F_48 : Faiseur_48_P.Constructeur_Clef_T;
   begin
      --  Les 3 instructions pour construire une nouvelle chaine
      Faiseur.Initialiser (F_56, F_48);
      Faiseur.Construire (Clef);
      return Faiseur.Recuperer_Chaine;
   end Init_Chaine;

end Procedure_Run_Ravenscar_P;