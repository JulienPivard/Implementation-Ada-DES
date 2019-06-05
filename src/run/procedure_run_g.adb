with Des_P.Clef_P.Clef_64_I_P.Holder_P;

with Ada.Real_Time;
with Ada.Text_IO;

package body Procedure_Run_G is

   ---------------------------------------------------------------------------
   procedure Executer_Chiffrement
      (
         Clef        : Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T'Class;
         Nom_Fichier : String;
         Action      : Action_T
      )
   is
      use type Ada.Real_Time.Time;

      Faiseur  : Faiseur_I_R.Faiseur_Interface_T'Class            :=
         Init_Faiseur_Chaine (Action => Action);
      Chaine   : constant Des_P.Chaine_P.Chaine_Interface_T'Class :=
         Init_Chaine (Faiseur => Faiseur, Clef => Clef);

      Extension_F : constant String := Init_Extension (Action => Action);
      Debut, Fin  : Ada.Real_Time.Time;
   begin
      --  Note le début du temps.
      Debut := Ada.Real_Time.Clock;
      --  Filtre le fichier.
      Chaine.Filtrer
         (
            Nom_Fichier => Nom_Fichier,
            Extension   => Extension_F
         );
      --  Note la fin du temps.
      Fin := Ada.Real_Time.Clock;

      --------------------------------------
      Ada.Text_IO.New_Line (Spacing => 1);
      --  Affiche le temps de filtrage du fichier.
      Ada.Text_IO.Put (Item => "Temps " & Nom_Version & " : ");
      Ada.Text_IO.New_Line (Spacing => 1);
      --  Conversion du temps pour faciliter l'affichage.

      Affichage_Temps :
      declare
         type Temps_T is new Natural;

         Duree_Exact : constant Duration  :=
            Ada.Real_Time.To_Duration (TS => Fin - Debut);
         Duree       : constant Temps_T   := Temps_T (Duree_Exact);
         Minuttes    : constant Temps_T   := 60;
         Indentation : constant String    := "         ";

         package Duree_IO is new Ada.Text_IO.Fixed_IO    (Duration);
         package Temps_IO is new Ada.Text_IO.Integer_IO  (Temps_T);
      begin
         Ada.Text_IO.Put (Item => Indentation);
         Duree_IO.Put    (Item => Duree_Exact, Fore => 0, Aft => 4);
         Ada.Text_IO.Put_Line (Item => " s");

         --  Affichage en minutes.
         if Duree_Exact > 60.0 then
            Ada.Text_IO.Put (Item => Indentation);
            Temps_IO.Put    (Item => Duree / Minuttes, Width => 0);
            Ada.Text_IO.Put (Item => " min et ");
            Temps_IO.Put    (Item => Duree mod Minuttes, Width => 0);
            Ada.Text_IO.Put_Line (Item => " s");
         end if;

         --  Affichage en heures.
         if Duree_Exact > 3600.0 then
            Decoupage_En_Heures :
            declare
               Heures : constant Temps_T := 3600;
            begin
               Ada.Text_IO.Put (Item => Indentation);
               Temps_IO.Put    (Item => Duree / Heures, Width => 0);
               Ada.Text_IO.Put (Item => " h et ");
               Temps_IO.Put
                  (Item => (Duree mod Heures) / Minuttes, Width => 0);
               Ada.Text_IO.Put_Line (Item => " m");
            end Decoupage_En_Heures;
         end if;
      end Affichage_Temps;
      Ada.Text_IO.New_Line (Spacing => 1);
      --------------------------------------
   end Executer_Chiffrement;

   ---------------------------------------------------------------------------
   function Init_Faiseur_Chaine
      (Action : Action_T)
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
               when Chiffrer     => Const_Chiffre,
               when Dechiffrer   => Const_Dechiff
         );
   end Init_Faiseur_Chaine;

   ---------------------------------------------------------------------------
   function Init_Extension
      (Action : Action_T)
      return String
   is
   begin
      --  Initialise l'extension du fichier alternatif.
      return Extension & "." &
         (
            case Action is
               when Chiffrer     => "chiffre",
               when Dechiffrer   => "dechiffre"
         );
   end Init_Extension;

   ---------------------------------------------------------------------------
   function Init_Chaine
      (
         Faiseur  : in out Faiseur_I_R.Faiseur_Interface_T'Class;
         Clef     :        Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T'Class
      )
      return Des_P.Chaine_P.Chaine_Interface_T'Class
   is
      C_64 : constant Des_P.Clef_P.Clef_64_I_P.Holder_P.Holder :=
         Des_P.Clef_P.Clef_64_I_P.Holder_P.To_Holder (New_Item => Clef);
      F_56 : Faiseur_56_R.Faiseur_Clef_T;
      F_48 : Faiseur_48_R.Faiseur_Clef_T;
   begin
      --  Les 3 instructions pour construire une nouvelle chaine
      Faiseur.Initialiser (Faiseur_56 => F_56, Faiseur_48 => F_48);
      Faiseur.Construire  (Clef => C_64.Element);

      return Faiseur.Recuperer_Chaine;
   end Init_Chaine;

end Procedure_Run_G;
