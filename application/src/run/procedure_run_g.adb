with Des_P.Clef_P.Clef_64_I_P.Holder_P;

with Ada.Real_Time;
with Ada.Text_IO;

package body Procedure_Run_G is

   ---------------------------------------------------------------------------
   procedure Executer_Chiffrement
      (
         Clef : Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T'Class;
         Nom_Fichier : String;
         Action : Action_T
      )
   is
      Faiseur : Faiseur_I_R.Faiseur_Interface_T'Class :=
         Init_Faiseur_Chaine (Action);
      Chaine : constant Des_P.Chaine_P.Chaine_Interface_T'Class :=
         Init_Chaine (Faiseur, Clef);
      Extension : constant String := Init_Extension (Action);

      Debut, Fin : Ada.Real_Time.Time;
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
      Ada.Text_IO.Put ("Temps " & Nom_Version & " : ");
      Ada.Text_IO.New_Line (1);
      --  Conversion du temps pour faciliter l'affichage.

      Affichage_Temps :
      declare
         type Temps_T is new Natural;

         Duree_Exact : constant Duration :=
            Ada.Real_Time.To_Duration (Fin - Debut);
         Duree : constant Temps_T := Temps_T (Duree_Exact);
         Minuttes : constant Temps_T := 60;
         Indentation : constant String := "         ";

         package Duree_IO is new Ada.Text_IO.Fixed_IO (Duration);
         package Temps_IO is new Ada.Text_IO.Integer_IO (Temps_T);
      begin
         Ada.Text_IO.Put (Indentation);
         Duree_IO.Put (Duree_Exact, 0, 4);
         Ada.Text_IO.Put_Line (" s");

         --  Affichage en minuttes.
         if Duree_Exact > 60.0 then
            Ada.Text_IO.Put (Indentation);
            Temps_IO.Put (Duree / Minuttes, 0);
            Ada.Text_IO.Put (" min et ");
            Temps_IO.Put (Duree mod Minuttes, 0);
            Ada.Text_IO.Put_Line (" s");
         end if;

         --  Affichage en heures.
         if Duree_Exact > 3600.0 then
            declare
               Heures : constant Temps_T := 3600;
            begin
               Ada.Text_IO.Put (Indentation);
               Temps_IO.Put (Duree / Heures, 0);
               Ada.Text_IO.Put (" h et ");
               Temps_IO.Put ((Duree mod Heures) / Minuttes, 0);
               Ada.Text_IO.Put_Line (" m");
            end;
         end if;
      end Affichage_Temps;
      Ada.Text_IO.New_Line (1);
      --------------------------------------
   end Executer_Chiffrement;

   ---------------------------------------------------------------------------
   function Init_Faiseur_Chaine
      (
         Action : Action_T
      )
      return Faiseur_I_R.Faiseur_Interface_T'Class
   is
      Const_Chiffre : Faiseur_Chiffrement_G_T;
      Const_Dechiff : Faiseur_Dechiffrement_G_T;
   begin
      --  Le faiseur sélectionné par le type action et le type
      --  séquentiel ou tache.
      return
         (
            case Action is
               when Chiffrer => Const_Chiffre,
               when Dechiffrer => Const_Dechiff
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
      return Extension & "." &
         (
            case Action is
               when Chiffrer => "chiffre",
               when Dechiffrer => "dechiffre"
         );
   end Init_Extension;

   ---------------------------------------------------------------------------
   function Init_Chaine
      (
         Faiseur : in out Faiseur_I_R.Faiseur_Interface_T'Class;
         Clef : Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T'Class
      )
      return Des_P.Chaine_P.Chaine_Interface_T'Class
   is
      C_64 : constant Des_P.Clef_P.Clef_64_I_P.Holder_P.Holder :=
         Des_P.Clef_P.Clef_64_I_P.Holder_P.To_Holder (Clef);
      F_56 : Faiseur_56_R.Faiseur_Clef_T;
      F_48 : Faiseur_48_R.Faiseur_Clef_T;
   begin
      --  Les 3 instructions pour construire une nouvelle chaine
      Faiseur.Initialiser (F_56, F_48);
      Faiseur.Construire (C_64.Element);
      return Faiseur.Recuperer_Chaine;
   end Init_Chaine;

end Procedure_Run_G;
