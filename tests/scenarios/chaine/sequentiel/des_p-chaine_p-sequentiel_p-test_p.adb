with AUnit.Assertions;

with Des_P.Filtre_P.Fabrique_P.Fabrique_Cryptage_P;
with Des_P.Filtre_P.Fabrique_P.Fabrique_Decryptage_P;

with Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P.Constructeur_64_P;
with Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Constructeur_56_P;
with Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Constructeur_48_P;

with Ada.Directories;
with Ada.Sequential_IO;
with Des_P.Filtre_P.Corps_P;
with Des_P.Chaine_P.Sequentiel_P.Constructeur_Cryptage_P;

package body Des_P.Chaine_P.Sequentiel_P.Test_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      use  Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P.Constructeur_64_P;
      use  Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Constructeur_56_P;
      use  Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Constructeur_48_P;
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
      T.Clef := C_C_64.Recuperer_Clef_64;
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
      Const_Crypt :
   Des_P.Chaine_P.Sequentiel_P.Constructeur_Cryptage_P.Constructeur_Cryptage_T;
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
      Const_Crypt.Initialiser;
      Const_Crypt.Construire (T.Clef);
      T.Chaine := Const_Crypt.Recuperer_Chaine;

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

   ---------------------------------------------------------------------------
   procedure Test_Execution_2_Filtres
      (T : in out Test_Fixt_T)
   is
      use type Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T;
      Brut_Utilise :
         Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T :=
            Brut;
      Brut_Attendu : constant
         Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T :=
            17361641481138401520;
   begin
      T.Chaine.Clef :=
         Des_P.Clef_P.Clef_56_Abs_P.Holder_P.To_Holder (T.Clef.Lire_Clef_56);
      declare
         Tete : Des_P.Etage_P.Filtrage_P.Etage_T;
         F_C : Des_P.Filtre_P.Fabrique_P.Fabrique_Cryptage_P.Fabrique_T;
      begin
         Tete.Modifier_Filtre (F_C.Fabriquer_Entree);
         declare
            Etage : Des_P.Etage_P.Filtrage_P.Etage_T;
         begin
            Etage.Modifier_Filtre (F_C.Fabriquer_Sortie);
            Tete.Ajouter_Successeur (Etage);
         end;
         T.Chaine.Tete := Tete;
         T.Chaine.Execution (Brut_Utilise);
         AUnit.Assertions.Assert
            (Brut_Utilise = Brut_Attendu,
            "Brut : " & Brut_Utilise'Img &
            " au lieu de " & Brut_Attendu'Img
            );
      end;

      T.Chaine.Clef :=
         Des_P.Clef_P.Clef_56_Abs_P.Holder_P.To_Holder (T.Clef.Lire_Clef_56);
      declare
         Tete : Des_P.Etage_P.Filtrage_P.Etage_T;
         F_D : Des_P.Filtre_P.Fabrique_P.Fabrique_Decryptage_P.Fabrique_T;
      begin
         Tete.Modifier_Filtre (F_D.Fabriquer_Entree);
         declare
            Etage : Des_P.Etage_P.Filtrage_P.Etage_T;
         begin
            Etage.Modifier_Filtre (F_D.Fabriquer_Sortie);
            Tete.Ajouter_Successeur (Etage);
         end;
         T.Chaine.Tete := Tete;
         T.Chaine.Execution (Brut_Utilise);
         AUnit.Assertions.Assert
            (Brut_Utilise = Brut_Initial,
            "Brut : " & Brut_Utilise'Img &
            " au lieu de " & Brut_Initial'Img
            );
      end;
   end Test_Execution_2_Filtres;

   ---------------------------------------------------------------------------
   procedure Test_Execution_18_Filtres
      (T : in out Test_Fixt_T)
   is
      use type Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T;
      Brut_Utilise :
         Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T :=
            Brut;
      Brut_Attendu : constant
         Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T :=
            15799177843826553255;
   begin
      T.Chaine.Clef :=
         Des_P.Clef_P.Clef_56_Abs_P.Holder_P.To_Holder (T.Clef.Lire_Clef_56);
      declare
         Tete : Des_P.Etage_P.Filtrage_P.Etage_T;
         F_C : Des_P.Filtre_P.Fabrique_P.Fabrique_Cryptage_P.Fabrique_T;
      begin
         Tete.Modifier_Filtre (F_C.Fabriquer_Entree);
         for I in Des_P.Filtre_P.Corps_P.Numero_Filtre_T'Range loop
            declare
               E : Des_P.Etage_P.Filtrage_P.Etage_T;
               F : Des_P.Filtre_P.Corps_P.Corps_Abstrait_T'Class :=
                  F_C.Fabriquer_Corps;
            begin
               F.Modifier_Numero (I);
               E.Modifier_Filtre (F);
               Tete.Ajouter_Successeur (E);
            end;
         end loop;
         declare
            Etage : Des_P.Etage_P.Filtrage_P.Etage_T;
         begin
            Etage.Modifier_Filtre (F_C.Fabriquer_Sortie);
            Tete.Ajouter_Successeur (Etage);
         end;
         T.Chaine.Tete := Tete;
         T.Chaine.Execution (Brut_Utilise);
         AUnit.Assertions.Assert
            (Brut_Utilise = Brut_Attendu,
            "Brut : " & Brut_Utilise'Img &
            " au lieu de " & Brut_Attendu'Img
            );
      end;

      T.Chaine.Clef :=
         Des_P.Clef_P.Clef_56_Abs_P.Holder_P.To_Holder (T.Clef.Lire_Clef_56);
      declare
         Tete : Des_P.Etage_P.Filtrage_P.Etage_T;
         F_D : Des_P.Filtre_P.Fabrique_P.Fabrique_Decryptage_P.Fabrique_T;
      begin
         Tete.Modifier_Filtre (F_D.Fabriquer_Entree);
         for I in reverse Des_P.Filtre_P.Corps_P.Numero_Filtre_T'Range loop
            declare
               E : Des_P.Etage_P.Filtrage_P.Etage_T;
               F : Des_P.Filtre_P.Corps_P.Corps_Abstrait_T'Class :=
                  F_D.Fabriquer_Corps;
            begin
               F.Modifier_Numero (I);
               E.Modifier_Filtre (F);
               Tete.Ajouter_Successeur (E);
            end;
         end loop;
         declare
            Etage : Des_P.Etage_P.Filtrage_P.Etage_T;
         begin
            Etage.Modifier_Filtre (F_D.Fabriquer_Sortie);
            Tete.Ajouter_Successeur (Etage);
         end;
         T.Chaine.Tete := Tete;
         T.Chaine.Execution (Brut_Utilise);
         AUnit.Assertions.Assert
            (Brut_Utilise = Brut_Initial,
            "Brut : " & Brut_Utilise'Img &
            " au lieu de " & Brut_Initial'Img
            );
      end;
   end Test_Execution_18_Filtres;

end Des_P.Chaine_P.Sequentiel_P.Test_P;
