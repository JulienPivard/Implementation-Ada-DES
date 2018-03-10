with AUnit.Assertions;

with Des_P.Clef_P.Clef_64_P.Constructeur_P;
with Des_P.Clef_P.Clef_56_P.Constructeur_P;
with Des_P.Clef_P.Clef_48_P.Constructeur_P;
with Des_P.Clef_P.Clef_48_P;

with Des_P.Chaine_P.Taches_P.Constructeur_Cryptage_P;

with Ada.Directories;
with Ada.Sequential_IO;

package body Des_P.Chaine_P.Taches_P.Test_P is

   package Faiseur_Cryptage_P renames
      Des_P.Chaine_P.Taches_P.Constructeur_Cryptage_P;
   package Faiseur_56_P renames Des_P.Clef_P.Clef_56_P.Constructeur_P;
   package Faiseur_48_P renames Des_P.Clef_P.Clef_48_P.Constructeur_P;

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      C_C_64 : Des_P.Clef_P.Clef_64_P.Constructeur_P.Constructeur_Clef_T;
   begin
      C_C_64.Preparer_Nouvelle_Clef;
      C_C_64.Construire_Clef (Brut_Clef);
      T.Clef := C_C_64.Recuperer_Clef;
   end Set_Up;

   ---------------------------------------------------------------------------
   overriding
   procedure Tear_Down (T : in out Test_Fixt_T) is
      pragma Unreferenced (T);
   begin
      null;
   end Tear_Down;

   ---------------------------------------------------------------------------
   --                              scénarios                                --
   ---------------------------------------------------------------------------
   ---------------------------------------------------------------------------
   procedure Test_Filtre (T : in out Test_Fixt_T) is
      Nom_Alternatif : constant String := Nom_Fichier & "." & Extension;
      Const_Crypt : Faiseur_Cryptage_P.Constructeur_Cryptage_T;
      Const_56 : Faiseur_56_P.Constructeur_Clef_T;
      Const_48 : Faiseur_48_P.Constructeur_Clef_T;
   begin
      declare
         package Lecteur_64_IO is new Ada.Sequential_IO
         (Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T);
         Fichier : Lecteur_64_IO.File_Type;
      begin
         Lecteur_64_IO.Create (Fichier, Lecteur_64_IO.Out_File, Nom_Fichier);
         Lecteur_64_IO.Write (Fichier, Brut);
         Lecteur_64_IO.Close (Fichier);
         pragma Unreferenced (Fichier);
      end;
      Const_Crypt.Initialiser (Const_56, Const_48);
      Const_Crypt.Construire (T.Clef);
      T.Chaine := Chaine_T (Const_Crypt.Recuperer_Chaine);

      T.Chaine.Filtrer (Nom_Fichier, Extension);

      declare
         package Lecteur_64_IO is new Ada.Sequential_IO
         (Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T);
         Fichier : Lecteur_64_IO.File_Type;
         use type Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T;
         Brut_Utilise :
            Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T :=
               Brut;
         Brut_Attendu : constant
            Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T :=
               15799177843826553255;
      begin
         Lecteur_64_IO.Open (Fichier, Lecteur_64_IO.In_File, Nom_Alternatif);
         Lecteur_64_IO.Read (Fichier, Brut_Utilise);
         Lecteur_64_IO.Close (Fichier);
         pragma Unreferenced (Fichier);
         AUnit.Assertions.Assert
            (Brut_Utilise = Brut_Attendu,
            "Brut : " & Brut_Utilise'Img &
            " au lieu de " & Brut_Attendu'Img
            );
      end;
      Ada.Directories.Delete_File (Nom_Fichier);
      Ada.Directories.Delete_File (Nom_Alternatif);
   end Test_Filtre;

end Des_P.Chaine_P.Taches_P.Test_P;
