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

package body Des_P.Chaine_P.Sequentiel_P.Test_P is

   package Faiseur_Chiffrement_P renames
      Des_P.Chaine_P.Sequentiel_P.Faiseur_Chiffre_P;
   package Faiseur_Dechiffrement_P renames
      Des_P.Chaine_P.Sequentiel_P.Faiseur_Dechiffre_P;
   package Faiseur_56_P renames Des_P.Clef_P.Clef_56_P.Faiseur_P;
   package Faiseur_48_P renames Des_P.Clef_P.Clef_48_P.Faiseur_P;

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
      null;
   end Tear_Down;

   ---------------------------------------------------------------------------
   --                              scénarios                                --
   ---------------------------------------------------------------------------
   ---------------------------------------------------------------------------
   procedure Test_Filtre_Chiffre_1 (T : in out Test_Fixt_T) is
      Const_Chiffre : Faiseur_Chiffrement_P.Faiseur_Chiffrement_T;
      Const_56 : Faiseur_56_P.Faiseur_Clef_T;
      Const_48 : Faiseur_48_P.Faiseur_Clef_T;
   begin
      Lecteur  := Lecteur_1_Generateur'Access;
      Ecriveur := Ecriveur_1_Generateur'Access;
      Lecteur_1_Generateur.Changer_Brut_Genere (Brut_Initial);

      Const_Chiffre.Initialiser (Const_56, Const_48);
      Const_Chiffre.Construire (T.Clef);
      T.Chaine := Chaine_T (Const_Chiffre.Recuperer_Chaine);

      T.Chaine.Filtrer (Nom_Fichier, Extension);

      declare
         R : constant Generateur_Ecriveur_1_P.Reception_Blocs_T :=
            Ecriveur_1_Generateur.Lire_Resultat;
         Nb_Blocs : constant Natural :=
            Ecriveur_1_Generateur.Lire_Nb_Bloc_Ecrit;
         Nb_Blocs_Max : constant Natural := 1;
         use type Des_P.Bloc_P.Bloc_64_P.Faiseur_P.Bloc_64_Brut_T;
         I : Natural := Natural'First;
      begin
         AUnit.Assertions.Assert
            (Nb_Blocs = Nb_Blocs_Max,
            "Le nombre de blocs ecrit est : " & Nb_Blocs'Img &
            " alors qu'il devrait etre de " & Nb_Blocs_Max'Img
            );
         for E of R loop
            AUnit.Assertions.Assert
               (E = Brut_Attendu,
               "Brut : " & E'Img &
               " au lieu de " & Brut_Attendu'Img &
               " en position : " & I'Img
               );
            I := Natural'Succ (I);
         end loop;
      end;
   end Test_Filtre_Chiffre_1;

   ---------------------------------------------------------------------------
   procedure Test_Filtre_Dechiffre_1 (T : in out Test_Fixt_T) is
      Const_Dechiffre : Faiseur_Dechiffrement_P.Faiseur_Dechiffrement_T;
      Const_56 : Faiseur_56_P.Faiseur_Clef_T;
      Const_48 : Faiseur_48_P.Faiseur_Clef_T;
   begin
      Lecteur  := Lecteur_1_Generateur'Access;
      Ecriveur := Ecriveur_1_Generateur'Access;
      Lecteur_1_Generateur.Changer_Brut_Genere (Brut_Attendu);

      Const_Dechiffre.Initialiser (Const_56, Const_48);
      Const_Dechiffre.Construire (T.Clef);
      T.Chaine := Chaine_T (Const_Dechiffre.Recuperer_Chaine);

      T.Chaine.Filtrer (Nom_Fichier, Extension);

      declare
         R : constant Generateur_Ecriveur_1_P.Reception_Blocs_T :=
            Ecriveur_1_Generateur.Lire_Resultat;
         Nb_Blocs : constant Natural :=
            Ecriveur_1_Generateur.Lire_Nb_Bloc_Ecrit;
         Nb_Blocs_Max : constant Natural := 1;
         use type Des_P.Bloc_P.Bloc_64_P.Faiseur_P.Bloc_64_Brut_T;
         I : Natural := Natural'First;
      begin
         AUnit.Assertions.Assert
            (Nb_Blocs = Nb_Blocs_Max,
            "Le nombre de blocs ecrit est : " & Nb_Blocs'Img &
            " alors qu'il devrait etre de " & Nb_Blocs_Max'Img
            );
         for E of R loop
            AUnit.Assertions.Assert
               (E = Brut_Initial,
               "Brut : " & E'Img &
               " au lieu de " & Brut_Initial'Img &
               " en position : " & I'Img
               );
            I := Natural'Succ (I);
         end loop;
      end;
   end Test_Filtre_Dechiffre_1;

   ---------------------------------------------------------------------------
   procedure Test_Filtre_Chiffre_2048 (T : in out Test_Fixt_T) is
      Const_Chiffre : Faiseur_Chiffrement_P.Faiseur_Chiffrement_T;
      Const_56 : Faiseur_56_P.Faiseur_Clef_T;
      Const_48 : Faiseur_48_P.Faiseur_Clef_T;
   begin
      Lecteur  := Lecteur_2048_Generateur'Access;
      Ecriveur := Ecriveur_2048_Generateur'Access;
      Lecteur_2048_Generateur.Changer_Brut_Genere (Brut_Initial);

      Const_Chiffre.Initialiser (Const_56, Const_48);
      Const_Chiffre.Construire (T.Clef);
      T.Chaine := Chaine_T (Const_Chiffre.Recuperer_Chaine);

      T.Chaine.Filtrer (Nom_Fichier, Extension);

      declare
         R : constant Generateur_Ecriveur_2048_P.Reception_Blocs_T :=
            Ecriveur_2048_Generateur.Lire_Resultat;
         Nb_Blocs : constant Natural :=
            Ecriveur_2048_Generateur.Lire_Nb_Bloc_Ecrit;
         Nb_Blocs_Max : constant Natural := 2048;
         use type Des_P.Bloc_P.Bloc_64_P.Faiseur_P.Bloc_64_Brut_T;
         I : Natural := Natural'First;
      begin
         AUnit.Assertions.Assert
            (Nb_Blocs = Nb_Blocs_Max,
            "Le nombre de blocs ecrit est : " & Nb_Blocs'Img &
            " alors qu'il devrait etre de " & Nb_Blocs_Max'Img
            );
         for E of R loop
            AUnit.Assertions.Assert
               (E = Brut_Attendu,
               "Brut : " & E'Img &
               " au lieu de " & Brut_Attendu'Img &
               " en position : " & I'Img
               );
            I := Natural'Succ (I);
         end loop;
      end;
   end Test_Filtre_Chiffre_2048;

   ---------------------------------------------------------------------------
   procedure Test_Filtre_Dechiffre_2048 (T : in out Test_Fixt_T) is
      Const_Dechiffre : Faiseur_Dechiffrement_P.Faiseur_Dechiffrement_T;
      Const_56 : Faiseur_56_P.Faiseur_Clef_T;
      Const_48 : Faiseur_48_P.Faiseur_Clef_T;
   begin
      Lecteur  := Lecteur_2048_Generateur'Access;
      Ecriveur := Ecriveur_2048_Generateur'Access;
      Lecteur_2048_Generateur.Changer_Brut_Genere (Brut_Attendu);

      Const_Dechiffre.Initialiser (Const_56, Const_48);
      Const_Dechiffre.Construire (T.Clef);
      T.Chaine := Chaine_T (Const_Dechiffre.Recuperer_Chaine);

      T.Chaine.Filtrer (Nom_Fichier, Extension);

      declare
         R : constant Generateur_Ecriveur_2048_P.Reception_Blocs_T :=
            Ecriveur_2048_Generateur.Lire_Resultat;
         Nb_Blocs : constant Natural :=
            Ecriveur_2048_Generateur.Lire_Nb_Bloc_Ecrit;
         Nb_Blocs_Max : constant Natural := 2048;
         use type Des_P.Bloc_P.Bloc_64_P.Faiseur_P.Bloc_64_Brut_T;
         I : Natural := Natural'First;
      begin
         AUnit.Assertions.Assert
            (Nb_Blocs = Nb_Blocs_Max,
            "Le nombre de blocs ecrit est : " & Nb_Blocs'Img &
            " alors qu'il devrait etre de " & Nb_Blocs_Max'Img
            );
         for E of R loop
            AUnit.Assertions.Assert
               (E = Brut_Initial,
               "Brut : " & E'Img &
               " au lieu de " & Brut_Initial'Img &
               " en position : " & I'Img
               );
            I := Natural'Succ (I);
         end loop;
      end;
   end Test_Filtre_Dechiffre_2048;

   ---------------------------------------------------------------------------
   procedure Test_Filtre_Chiffre_8192 (T : in out Test_Fixt_T) is
      Const_Chiffre : Faiseur_Chiffrement_P.Faiseur_Chiffrement_T;
      Const_56 : Faiseur_56_P.Faiseur_Clef_T;
      Const_48 : Faiseur_48_P.Faiseur_Clef_T;
   begin
      Lecteur  := Lecteur_8192_Generateur'Access;
      Ecriveur := Ecriveur_8192_Generateur'Access;
      Lecteur_8192_Generateur.Changer_Brut_Genere (Brut_Initial);

      Const_Chiffre.Initialiser (Const_56, Const_48);
      Const_Chiffre.Construire (T.Clef);
      T.Chaine := Chaine_T (Const_Chiffre.Recuperer_Chaine);

      T.Chaine.Filtrer (Nom_Fichier, Extension);

      declare
         R : constant Generateur_Ecriveur_8192_P.Reception_Blocs_T :=
            Ecriveur_8192_Generateur.Lire_Resultat;
         Nb_Blocs : constant Natural :=
            Ecriveur_8192_Generateur.Lire_Nb_Bloc_Ecrit;
         Nb_Blocs_Max : constant Natural := 8192;
         use type Des_P.Bloc_P.Bloc_64_P.Faiseur_P.Bloc_64_Brut_T;
         I : Natural := Natural'First;
      begin
         AUnit.Assertions.Assert
            (Nb_Blocs = Nb_Blocs_Max,
            "Le nombre de blocs ecrit est : " & Nb_Blocs'Img &
            " alors qu'il devrait etre de " & Nb_Blocs_Max'Img
            );
         for E of R loop
            AUnit.Assertions.Assert
               (E = Brut_Attendu,
               "Brut : " & E'Img &
               " au lieu de " & Brut_Attendu'Img &
               " en position : " & I'Img
               );
            I := Natural'Succ (I);
         end loop;
      end;
   end Test_Filtre_Chiffre_8192;

   ---------------------------------------------------------------------------
   procedure Test_Filtre_Dechiffre_8192 (T : in out Test_Fixt_T) is
      Const_Dechiffre : Faiseur_Dechiffrement_P.Faiseur_Dechiffrement_T;
      Const_56 : Faiseur_56_P.Faiseur_Clef_T;
      Const_48 : Faiseur_48_P.Faiseur_Clef_T;
   begin
      Lecteur  := Lecteur_8192_Generateur'Access;
      Ecriveur := Ecriveur_8192_Generateur'Access;
      Lecteur_8192_Generateur.Changer_Brut_Genere (Brut_Attendu);

      Const_Dechiffre.Initialiser (Const_56, Const_48);
      Const_Dechiffre.Construire (T.Clef);
      T.Chaine := Chaine_T (Const_Dechiffre.Recuperer_Chaine);

      T.Chaine.Filtrer (Nom_Fichier, Extension);

      declare
         R : constant Generateur_Ecriveur_8192_P.Reception_Blocs_T :=
            Ecriveur_8192_Generateur.Lire_Resultat;
         Nb_Blocs : constant Natural :=
            Ecriveur_8192_Generateur.Lire_Nb_Bloc_Ecrit;
         Nb_Blocs_Max : constant Natural := 8192;
         use type Des_P.Bloc_P.Bloc_64_P.Faiseur_P.Bloc_64_Brut_T;
         I : Natural := Natural'First;
      begin
         AUnit.Assertions.Assert
            (Nb_Blocs = Nb_Blocs_Max,
            "Le nombre de blocs ecrit est : " & Nb_Blocs'Img &
            " alors qu'il devrait etre de " & Nb_Blocs_Max'Img
            );
         for E of R loop
            AUnit.Assertions.Assert
               (E = Brut_Initial,
               "Brut : " & E'Img &
               " au lieu de " & Brut_Initial'Img &
               " en position : " & I'Img
               );
            I := Natural'Succ (I);
         end loop;
      end;
   end Test_Filtre_Dechiffre_8192;

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
