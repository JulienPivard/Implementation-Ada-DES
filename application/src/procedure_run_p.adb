with Des_P.Chaine_P.Sequentiel_P;
with Des_P.Chaine_P.Sequentiel_P.Constructeur_Cryptage_P;
with Des_P.Chaine_P.Sequentiel_P.Constructeur_Decryptage_P;

with Des_P.Chaine_P.Taches_P;
with Des_P.Chaine_P.Taches_P.Constructeur_Cryptage_P;
with Des_P.Chaine_P.Taches_P.Constructeur_Decryptage_P;

with Ada.Real_Time;
with Ada.Text_IO;

package body Procedure_Run_P is

   ---------------------------------------------------------------------------
   procedure Executer_Crypt_Decrypt
      (
         Clef : Des_P.Clef_P.Clef_64_P.Clef_T;
         Nom_Fichier : String;
         Action : Action_T;
         C_Type : Chaine_Seq_Task_T
      )
   is
      Faiseur : Faiseur_P.Constructeur_Interface_T'Class :=
         Init_Faiseur_Chaine (Action, C_Type);
      Chaine : Des_P.Chaine_P.Chaine_Interface_T'Class :=
         Init_Chaine (Faiseur, Clef);
      Extension : constant String := Init_Extension (Action, C_Type);

      Debut, Fin : Ada.Real_Time.Time;
      package Duree_IO is new
      Ada.Text_IO.Fixed_IO (Duration);
      use type Ada.Real_Time.Time;
   begin
      Debut := Ada.Real_Time.Clock;
      Chaine.Filtrer
         (
            Nom_Fichier,
            Extension
         );
      Fin := Ada.Real_Time.Clock;

      --------------------------------------
      Ada.Text_IO.New_Line (1);
      Ada.Text_IO.Put
         (
            "Temps " &
            (
               case C_Type is
                  when Sequentiel => "séquentiel",
                  when Tache => "parallèle"
            ) &
            " : "
         );
      Ada.Text_IO.New_Line (1);
      Affichage_Temps :
      declare
         Duree : constant Duration :=
            Ada.Real_Time.To_Duration (Fin - Debut);
      begin
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
      end Affichage_Temps;
      Ada.Text_IO.New_Line (1);
      --------------------------------------
   end Executer_Crypt_Decrypt;

   ---------------------------------------------------------------------------
   function Init_Faiseur_Chaine
      (
         Action : Action_T;
         C_Type : Chaine_Seq_Task_T
      )
      return Faiseur_P.Constructeur_Interface_T'Class
   is
      package Faiseur_S_C_P renames
         Des_P.Chaine_P.Sequentiel_P.Constructeur_Cryptage_P;
      package Faiseur_S_D_P renames
         Des_P.Chaine_P.Sequentiel_P.Constructeur_Decryptage_P;
      package Faiseur_T_C_P renames
         Des_P.Chaine_P.Taches_P.Constructeur_Cryptage_P;
      package Faiseur_T_D_P renames
         Des_P.Chaine_P.Taches_P.Constructeur_Decryptage_P;
      Const_Crypt_S : Faiseur_S_C_P.Constructeur_Cryptage_T;
      Const_Decry_S : Faiseur_S_D_P.Constructeur_Decryptage_T;
      Const_Crypt_T : Faiseur_T_C_P.Constructeur_Cryptage_T;
      Const_Decry_T : Faiseur_T_D_P.Constructeur_Decryptage_T;
   begin
      return
         (
            case Action is
               when Crypter =>
                  (
                     case C_Type is
                        when Tache => Const_Crypt_T,
                        when Sequentiel => Const_Crypt_S
                  ),
               when Decrypter =>
                  (
                     case C_Type is
                        when Tache => Const_Decry_T,
                        when Sequentiel => Const_Decry_S
                  )
         );
   end Init_Faiseur_Chaine;

   ---------------------------------------------------------------------------
   function Init_Extension
      (
         Action : Action_T;
         C_Type : Chaine_Seq_Task_T
      )
      return String
   is
   begin
      return
         (
            case C_Type is
               when Sequentiel => "sequ",
               when Tache => "task"
         )
         & "." &
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
      Faiseur.Initialiser (F_56, F_48);
      Faiseur.Construire (Clef);
      return Faiseur.Recuperer_Chaine;
   end Init_Chaine;

end Procedure_Run_P;
