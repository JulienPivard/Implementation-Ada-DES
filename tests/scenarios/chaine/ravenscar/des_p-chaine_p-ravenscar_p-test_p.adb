with AUnit.Assertions;

with Des_P.Clef_P.Clef_64_P.Constructeur_P;
with Des_P.Clef_P.Clef_56_P.Constructeur_P;
with Des_P.Clef_P.Clef_48_P.Constructeur_P;
with Des_P.Clef_P.Clef_48_P;

with Des_P.Filtre_P.Fabrique_P.Cryptage_P;
with Des_P.Filtre_P.Fabrique_P.Decryptage_P;
with Des_P.Faiseur_P;

package body Des_P.Chaine_P.Ravenscar_P.Test_P is

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
      Lecteur_Generateur.Remettre_A_Zero;
      Ecriveur_Generateur.Remettre_A_Zero;
      Lecteur := Lecteur_Generateur'Access;
      Ecriveur := Ecriveur_Generateur'Access;
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
      Const_56 : Faiseur_56_P.Constructeur_Clef_T;
      Const_48 : Faiseur_48_P.Constructeur_Clef_T;
   begin
      declare
         Clef_56 : Des_P.Clef_P.Clef_56_I_P.Clef_Interface_T'Class :=
            Des_P.Faiseur_P.Faire_Clef (Const_56, T.Clef);
         Fabrique : Des_P.Filtre_P.Fabrique_P.Cryptage_P.Fabrique_T;
      begin
         Lecteur_Generateur.Changer_Brut_Genere (Brut_Original);
         Lecteur_Generateur.Changer_Max_Genere (1);

         T.Chaine.Filtre_Entree := Des_P.Filtre_P.Entree_P.Holder_P.To_Holder
               (Fabrique.Fabriquer_Entree);

         --  Ajoute le filtre de corps à la chaine.
         for I in Numero_Filtre_T'Range loop
            --  Décalage à gauche pour le chiffrement.
            Clef_56.Decaler_Bits_A_Gauche (Table_Decalage (I));
            --  Initialise le filtre avec la clef de 48.
            T.Chaine.Filtres_Corps (I) :=
               Des_P.Filtre_P.Corps_P.Holder_P.To_Holder
               (
                  Fabrique.Fabriquer_Corps
                  (Des_P.Faiseur_P.Faire_Clef (Const_48, Clef_56))
               );
         end loop;

         --  Ajoute le filtre de sortie.
         T.Chaine.Filtre_Sortie := Des_P.Filtre_P.Sortie_P.Holder_P.To_Holder
               (Fabrique.Fabriquer_Sortie);
      end;

      T.Chaine.Filtrer (Nom_Fichier, Extension);

      declare
         R : constant Accee_G_P.Reception_Blocs_T :=
            Ecriveur_Generateur.Lire_Resultat;
         use type Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T;
      begin
         AUnit.Assertions.Assert
            (R (Natural'First) = Brut_Attendu,
            "Brut : " & R (Natural'First)'Img &
            " au lieu de " & Brut_Attendu'Img &
            " en position : 0"
            );
         for I in Natural'First + 1 .. Accee_G_P.Fin_Constante_Bloc loop
            AUnit.Assertions.Assert
               (R (I) = 0,
               "Brut : " & R (I)'Img &
               " au lieu de 0" &
               " en position : " & I'Img
               );
         end loop;
      end;
   end Test_Filtre_Chiffre_1;

   ---------------------------------------------------------------------------
   procedure Test_Filtre_Dechiff_1 (T : in out Test_Fixt_T) is
      Const_56 : Faiseur_56_P.Constructeur_Clef_T;
      Const_48 : Faiseur_48_P.Constructeur_Clef_T;
   begin
      declare
         Clef_56 : Des_P.Clef_P.Clef_56_I_P.Clef_Interface_T'Class :=
            Des_P.Faiseur_P.Faire_Clef (Const_56, T.Clef);
         Fabrique : Des_P.Filtre_P.Fabrique_P.Decryptage_P.Fabrique_T;
         J : Numero_Filtre_T := Numero_Filtre_T'First;
      begin
         Lecteur_Generateur.Changer_Brut_Genere (Brut_Attendu);
         Lecteur_Generateur.Changer_Max_Genere (1);

         T.Chaine.Filtre_Entree :=
            Des_P.Filtre_P.Entree_P.Holder_P.To_Holder
               (Fabrique.Fabriquer_Entree);

         for I in reverse Numero_Filtre_T'Range loop
            T.Chaine.Filtres_Corps (J) :=
               Des_P.Filtre_P.Corps_P.Holder_P.To_Holder
               (
                  Fabrique.Fabriquer_Corps
                  (Des_P.Faiseur_P.Faire_Clef (Const_48, Clef_56))
               );
            Clef_56.Decaler_Bits_A_Droite (Table_Decalage (I));
            if J /= Numero_Filtre_T'Last then
               J := Numero_Filtre_T'Succ (J);
            end if;
         end loop;

         --  Ajoute le filtre de sortie.
         T.Chaine.Filtre_Sortie :=
            Des_P.Filtre_P.Sortie_P.Holder_P.To_Holder
               (Fabrique.Fabriquer_Sortie);
      end;

      T.Chaine.Filtrer (Nom_Fichier, Extension);

      declare
         R : constant Accee_G_P.Reception_Blocs_T :=
            Ecriveur_Generateur.Lire_Resultat;
         use type Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T;
      begin
         AUnit.Assertions.Assert
            (R (Natural'First) = Brut_Original,
            "Brut : " & R (Natural'First)'Img &
            " au lieu de " & Brut_Original'Img &
            " en position : 0"
            );
         for I in Natural'First + 1 .. Accee_G_P.Fin_Constante_Bloc loop
            AUnit.Assertions.Assert
               (R (I) = 0,
               "Brut : " & R (I)'Img &
               " au lieu de 0" &
               " en position : " & I'Img
               );
         end loop;
      end;
   end Test_Filtre_Dechiff_1;

   ---------------------------------------------------------------------------
   procedure Test_Filtre_Chiffre_2048 (T : in out Test_Fixt_T) is
      Const_56 : Faiseur_56_P.Constructeur_Clef_T;
      Const_48 : Faiseur_48_P.Constructeur_Clef_T;
   begin
      declare
         Clef_56 : Des_P.Clef_P.Clef_56_I_P.Clef_Interface_T'Class :=
            Des_P.Faiseur_P.Faire_Clef (Const_56, T.Clef);
         Fabrique : Des_P.Filtre_P.Fabrique_P.Cryptage_P.Fabrique_T;
      begin
         Lecteur_Generateur.Changer_Brut_Genere (Brut_Original);
         Lecteur_Generateur.Changer_Max_Genere (2048);

         T.Chaine.Filtre_Entree := Des_P.Filtre_P.Entree_P.Holder_P.To_Holder
               (Fabrique.Fabriquer_Entree);

         --  Ajoute le filtre de corps à la chaine.
         for I in Numero_Filtre_T'Range loop
            --  Décalage à gauche pour le chiffrement.
            Clef_56.Decaler_Bits_A_Gauche (Table_Decalage (I));
            --  Initialise le filtre avec la clef de 48.
            T.Chaine.Filtres_Corps (I) :=
               Des_P.Filtre_P.Corps_P.Holder_P.To_Holder
               (
                  Fabrique.Fabriquer_Corps
                  (Des_P.Faiseur_P.Faire_Clef (Const_48, Clef_56))
               );
         end loop;

         --  Ajoute le filtre de sortie.
         T.Chaine.Filtre_Sortie := Des_P.Filtre_P.Sortie_P.Holder_P.To_Holder
               (Fabrique.Fabriquer_Sortie);
      end;

      T.Chaine.Filtrer (Nom_Fichier, Extension);

      declare
         R : constant Accee_G_P.Reception_Blocs_T :=
            Ecriveur_Generateur.Lire_Resultat;
         use type Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T;
         I : Natural := Natural'First;
      begin
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
   procedure Test_Filtre_Dechiff_2048 (T : in out Test_Fixt_T) is
      Const_56 : Faiseur_56_P.Constructeur_Clef_T;
      Const_48 : Faiseur_48_P.Constructeur_Clef_T;
   begin
      declare
         Clef_56 : Des_P.Clef_P.Clef_56_I_P.Clef_Interface_T'Class :=
            Des_P.Faiseur_P.Faire_Clef (Const_56, T.Clef);
         Fabrique : Des_P.Filtre_P.Fabrique_P.Decryptage_P.Fabrique_T;
         J : Numero_Filtre_T := Numero_Filtre_T'First;
      begin
         Lecteur_Generateur.Changer_Brut_Genere (Brut_Attendu);
         Lecteur_Generateur.Changer_Max_Genere (2048);

         T.Chaine.Filtre_Entree :=
            Des_P.Filtre_P.Entree_P.Holder_P.To_Holder
               (Fabrique.Fabriquer_Entree);

         for I in reverse Numero_Filtre_T'Range loop
            T.Chaine.Filtres_Corps (J) :=
               Des_P.Filtre_P.Corps_P.Holder_P.To_Holder
               (
                  Fabrique.Fabriquer_Corps
                  (Des_P.Faiseur_P.Faire_Clef (Const_48, Clef_56))
               );
            Clef_56.Decaler_Bits_A_Droite (Table_Decalage (I));
            if J /= Numero_Filtre_T'Last then
               J := Numero_Filtre_T'Succ (J);
            end if;
         end loop;

         --  Ajoute le filtre de sortie.
         T.Chaine.Filtre_Sortie :=
            Des_P.Filtre_P.Sortie_P.Holder_P.To_Holder
               (Fabrique.Fabriquer_Sortie);
      end;

      T.Chaine.Filtrer (Nom_Fichier, Extension);

      declare
         R : constant Accee_G_P.Reception_Blocs_T :=
            Ecriveur_Generateur.Lire_Resultat;
         use type Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T;
         I : Natural := Natural'First;
      begin
         for E of R loop
            AUnit.Assertions.Assert
               (E = Brut_Original,
               "Brut : " & E'Img &
               " au lieu de " & Brut_Original'Img &
               " en position : " & I'Img
               );
            I := Natural'Succ (I);
         end loop;
      end;
   end Test_Filtre_Dechiff_2048;

   ---------------------------------------------------------------------------
   procedure Test_Fin is
   begin
      Faire_Avorter;
   end Test_Fin;

end Des_P.Chaine_P.Ravenscar_P.Test_P;
