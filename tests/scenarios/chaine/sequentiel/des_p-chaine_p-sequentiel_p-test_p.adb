with AUnit.Assertions;

with Des_P.Filtre_P.Fabrique_P.Chiffre_P;
with Des_P.Filtre_P.Fabrique_P.Dechiffre_P;

with Des_P.Clef_P.Clef_64_P.Faiseur_P;
with Des_P.Clef_P.Clef_56_P.Faiseur_P;
with Des_P.Clef_P.Clef_48_P.Faiseur_P;
with Des_P.Clef_P.Clef_48_P;

with Des_P.Filtre_P.Corps_P;
with Des_P.Chaine_P.Sequentiel_P.Faiseur_Chiffre_P;
with Des_P.Chaine_P.Sequentiel_P.Faiseur_Dechiffre_P;

with Ada.Directories;
with Ada.Sequential_IO;

with Ada.IO_Exceptions;

package body Des_P.Chaine_P.Sequentiel_P.Test_P is

   package Faiseur_Chiffrement_P renames
      Des_P.Chaine_P.Sequentiel_P.Faiseur_Chiffre_P;
   package Faiseur_Dechiffrement_P renames
      Des_P.Chaine_P.Sequentiel_P.Faiseur_Dechiffre_P;
   package Faiseur_56_P renames Des_P.Clef_P.Clef_56_P.Faiseur_P;
   package Faiseur_48_P renames Des_P.Clef_P.Clef_48_P.Faiseur_P;
   package Lecteur_64_IO is new Ada.Sequential_IO
      (Des_P.Bloc_P.Bloc_64_P.Faiseur_P.Bloc_64_Brut_T);

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      C_C_64 : Des_P.Clef_P.Clef_64_P.Faiseur_P.Faiseur_Clef_T;
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
   procedure Test_Filtre_Chiffre (T : in out Test_Fixt_T) is
      Const_Chiffre : Faiseur_Chiffrement_P.Faiseur_Chiffrement_T;
      Const_56 : Faiseur_56_P.Faiseur_Clef_T;
      Const_48 : Faiseur_48_P.Faiseur_Clef_T;
   begin
      declare
         Fichier : Lecteur_64_IO.File_Type;
      begin
         Lecteur_64_IO.Create (Fichier, Lecteur_64_IO.Out_File, Nom_Fichier);
         Lecteur_64_IO.Write (Fichier, Brut_Initial);
         Lecteur_64_IO.Close (Fichier);
         pragma Unreferenced (Fichier);
      end;
      Const_Chiffre.Initialiser (Const_56, Const_48);
      Const_Chiffre.Construire (T.Clef);
      T.Chaine := Chaine_T (Const_Chiffre.Recuperer_Chaine);

      T.Chaine.Filtrer (Nom_Fichier, Extension);

      declare
         Fichier : Lecteur_64_IO.File_Type;
         use type Des_P.Bloc_P.Bloc_64_P.Faiseur_P.Bloc_64_Brut_T;
         Brut_Utilise : Des_P.Bloc_P.Bloc_64_P.Faiseur_P.Bloc_64_Brut_T;
      begin
         Lecteur_64_IO.Open (Fichier, Lecteur_64_IO.In_File, Nom_Alternatif);
         Lecteur_64_IO.Read (Fichier, Brut_Utilise);
         Lecteur_64_IO.Close (Fichier);
         AUnit.Assertions.Assert
            (Brut_Utilise = Brut_Attendu,
            "Brut : " & Brut_Utilise'Img &
            " au lieu de " & Brut_Attendu'Img
            );
      exception
         when Ada.IO_Exceptions.End_Error =>
            Lecteur_64_IO.Close (Fichier);
            AUnit.Assertions.Assert
               (False, "Erreur Fin fichier atteinte");
      end;
   end Test_Filtre_Chiffre;

   ---------------------------------------------------------------------------
   procedure Test_Filtre_Dechiffre (T : in out Test_Fixt_T) is
      Const_Dechiffre : Faiseur_Dechiffrement_P.Faiseur_Dechiffrement_T;
      Const_56 : Faiseur_56_P.Faiseur_Clef_T;
      Const_48 : Faiseur_48_P.Faiseur_Clef_T;
   begin
      declare
         Fichier : Lecteur_64_IO.File_Type;
      begin
         Lecteur_64_IO.Create (Fichier, Lecteur_64_IO.Out_File, Nom_Fichier);
         Lecteur_64_IO.Write (Fichier, Brut_Attendu);
         Lecteur_64_IO.Close (Fichier);
         pragma Unreferenced (Fichier);
      end;
      Const_Dechiffre.Initialiser (Const_56, Const_48);
      Const_Dechiffre.Construire (T.Clef);
      T.Chaine := Chaine_T (Const_Dechiffre.Recuperer_Chaine);

      T.Chaine.Filtrer (Nom_Fichier, Extension);

      declare
         Fichier : Lecteur_64_IO.File_Type;
         use type Des_P.Bloc_P.Bloc_64_P.Faiseur_P.Bloc_64_Brut_T;
         Brut_Utilise : Des_P.Bloc_P.Bloc_64_P.Faiseur_P.Bloc_64_Brut_T;
      begin
         Lecteur_64_IO.Open (Fichier, Lecteur_64_IO.In_File, Nom_Alternatif);
         Lecteur_64_IO.Read (Fichier, Brut_Utilise);
         Lecteur_64_IO.Close (Fichier);
         AUnit.Assertions.Assert
            (Brut_Utilise = Brut_Initial,
            "Brut : " & Brut_Utilise'Img &
            " au lieu de " & Brut_Initial'Img
            );
      exception
         when Ada.IO_Exceptions.End_Error =>
            Lecteur_64_IO.Close (Fichier);
            AUnit.Assertions.Assert
               (False, "Erreur Fin fichier atteinte");
      end;
   end Test_Filtre_Dechiffre;

   ---------------------------------------------------------------------------
   procedure Test_Execution_2_Filtres
      (T : in out Test_Fixt_T)
   is
      use type Des_P.Bloc_P.Bloc_64_P.Faiseur_P.Bloc_64_Brut_T;
      Brut_Utilise :
         Des_P.Bloc_P.Bloc_64_P.Faiseur_P.Bloc_64_Brut_T :=
            Brut_Initial;
   begin
      declare
         Tete : Des_P.Etage_P.Filtrage_P.Etage_T;
         F_C : Des_P.Filtre_P.Fabrique_P.Chiffre_P.Fabrique_T;
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
            (Brut_Utilise = Brut_Initial,
            "Brut : " & Brut_Utilise'Img &
            " au lieu de " & Brut_Initial'Img
            );
      end;

      declare
         Tete : Des_P.Etage_P.Filtrage_P.Etage_T;
         F_D : Des_P.Filtre_P.Fabrique_P.Dechiffre_P.Fabrique_T;
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
      use type Des_P.Bloc_P.Bloc_64_P.Faiseur_P.Bloc_64_Brut_T;
      Brut_Utilise :
         Des_P.Bloc_P.Bloc_64_P.Faiseur_P.Bloc_64_Brut_T := Brut_Initial;
      Const_56 : Des_P.Clef_P.Clef_56_P.Faiseur_P.Faiseur_Clef_T;
   begin
      Const_56.Preparer_Nouvelle_Clef;
      Const_56.Construire_Clef (T.Clef);
      declare
         Tete : Des_P.Etage_P.Filtrage_P.Etage_T;
         F_C : Des_P.Filtre_P.Fabrique_P.Chiffre_P.Fabrique_T;
         Clef_56 : Des_P.Clef_P.Clef_56_P.Clef_T := Const_56.Recuperer_Clef;
         Const_48 : Des_P.Clef_P.Clef_48_P.Faiseur_P.Faiseur_Clef_T;
      begin
         Tete.Modifier_Filtre (F_C.Fabriquer_Entree);
         for I in Numero_Filtre_T'Range loop
            Clef_56.Decaler_Bits_A_Gauche (Table_Decalage (I));
            Const_48.Preparer_Nouvelle_Clef;
            Const_48.Construire_Clef (Clef_56);
            declare
               C_48 : constant Des_P.Clef_P.Clef_48_P.Clef_T :=
                  Const_48.Recuperer_Clef;
               E : Des_P.Etage_P.Filtrage_P.Etage_T;
               F : constant Des_P.Filtre_P.Corps_P.Corps_Abstrait_T'Class :=
                  F_C.Fabriquer_Corps (C_48);
            begin
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

      Const_56.Preparer_Nouvelle_Clef;
      Const_56.Construire_Clef (T.Clef);
      declare
         Tete : Des_P.Etage_P.Filtrage_P.Etage_T;
         F_D : Des_P.Filtre_P.Fabrique_P.Dechiffre_P.Fabrique_T;
         Clef_56 : Des_P.Clef_P.Clef_56_P.Clef_T := Const_56.Recuperer_Clef;
         Const_48 : Des_P.Clef_P.Clef_48_P.Faiseur_P.Faiseur_Clef_T;
      begin
         Tete.Modifier_Filtre (F_D.Fabriquer_Entree);
         for I in reverse Numero_Filtre_T'Range loop
            Const_48.Preparer_Nouvelle_Clef;
            Const_48.Construire_Clef (Clef_56);
            declare
               C_48 : constant Des_P.Clef_P.Clef_48_P.Clef_T :=
                  Const_48.Recuperer_Clef;
               E : Des_P.Etage_P.Filtrage_P.Etage_T;
               F : constant Des_P.Filtre_P.Corps_P.Corps_Abstrait_T'Class :=
                  F_D.Fabriquer_Corps (C_48);
            begin
               E.Modifier_Filtre (F);
               Tete.Ajouter_Successeur (E);
            end;
            Clef_56.Decaler_Bits_A_Droite (Table_Decalage (I));
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
