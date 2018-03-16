with AUnit.Assertions;

with Des_P.Clef_P.Clef_64_P.Constructeur_P;
with Des_P.Clef_P.Clef_56_P.Constructeur_P;
with Des_P.Clef_P.Clef_48_P.Constructeur_P;
with Des_P.Clef_P.Clef_48_P;

with Des_P.Chaine_P.Ravenscar_P.Constructeur_Cryptage_P;
with Des_P.Chaine_P.Ravenscar_P.Constructeur_Decryptage_P;

with Ada.Directories;
with Ada.Sequential_IO;

package body Des_P.Chaine_P.Ravenscar_P.Test_P is

   package Faiseur_Cryptage_P renames
      Des_P.Chaine_P.Ravenscar_P.Constructeur_Cryptage_P;
   package Faiseur_Decryptage_P renames
      Des_P.Chaine_P.Ravenscar_P.Constructeur_Decryptage_P;
   package Faiseur_56_P renames Des_P.Clef_P.Clef_56_P.Constructeur_P;
   package Faiseur_48_P renames Des_P.Clef_P.Clef_48_P.Constructeur_P;
   package Lecteur_64_IO is new Ada.Sequential_IO
      (Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T);

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
      if Ada.Directories.Exists (Nom_Fichier) then
         Ada.Directories.Delete_File (Nom_Fichier);
      end if;
      if Ada.Directories.Exists (Nom_Alternatif) then
         Ada.Directories.Delete_File (Nom_Alternatif);
      end if;
   end Tear_Down;

   ---------------------------------------------------------------------------
   --                              scénarios                                --
   ---------------------------------------------------------------------------
   ---------------------------------------------------------------------------
   procedure Test_Filtre_Crypt (T : in out Test_Fixt_T) is
      Const_Crypt : Faiseur_Cryptage_P.Constructeur_Cryptage_T;
      Const_56 : Faiseur_56_P.Constructeur_Clef_T;
      Const_48 : Faiseur_48_P.Constructeur_Clef_T;
   begin
      declare
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
         Fichier : Lecteur_64_IO.File_Type;
         use type Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T;
         Brut_Utilise :
            Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T := Brut;
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
   end Test_Filtre_Crypt;

   ---------------------------------------------------------------------------
   procedure Test_Filtre_Decrypt (T : in out Test_Fixt_T) is
      Const_Decrypt : Faiseur_Decryptage_P.Constructeur_Decryptage_T;
      Const_56 : Faiseur_56_P.Constructeur_Clef_T;
      Const_48 : Faiseur_48_P.Constructeur_Clef_T;
   begin
      declare
         Fichier : Lecteur_64_IO.File_Type;
      begin
         Lecteur_64_IO.Create (Fichier, Lecteur_64_IO.Out_File, Nom_Fichier);
         Lecteur_64_IO.Write (Fichier, Brut_Attendu);
         Lecteur_64_IO.Close (Fichier);
         pragma Unreferenced (Fichier);
      end;
      Const_Decrypt.Initialiser (Const_56, Const_48);
      Const_Decrypt.Construire (T.Clef);
      T.Chaine := Chaine_T (Const_Decrypt.Recuperer_Chaine);

      T.Chaine.Filtrer (Nom_Fichier, Extension);

      declare
         Fichier : Lecteur_64_IO.File_Type;
         use type Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T;
         Brut_Utilise :
            Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T :=
               Brut_Attendu;
      begin
         Lecteur_64_IO.Open (Fichier, Lecteur_64_IO.In_File, Nom_Alternatif);
         Lecteur_64_IO.Read (Fichier, Brut_Utilise);
         Lecteur_64_IO.Close (Fichier);
         pragma Unreferenced (Fichier);
         AUnit.Assertions.Assert
            (Brut_Utilise = Brut,
            "Brut : " & Brut_Utilise'Img &
            " au lieu de " & Brut'Img
            );
      end;
   end Test_Filtre_Decrypt;

end Des_P.Chaine_P.Ravenscar_P.Test_P;
