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
   procedure Test_Filtre_Crypt_1 (T : in out Test_Fixt_T) is
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
            --  Décalage à gauche pour le cryptage.
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
         R : constant Reception_Blocs_T := Ecriveur_Generateur.Lire_Resultat;
         use type Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T;
      begin
         AUnit.Assertions.Assert
            (R (Natural'First) = Brut_Attendu,
            "Brut : " & R (Natural'First)'Img &
            " au lieu de " & Brut_Attendu'Img &
            " en position : 0"
            );
         for I in Natural'First + 1 .. Fin_Constante_Bloc loop
            AUnit.Assertions.Assert
               (R (I) = 0,
               "Brut : " & R (I)'Img &
               " au lieu de 0" &
               " en position : " & I'Img
               );
         end loop;
      end;
   end Test_Filtre_Crypt_1;

   ---------------------------------------------------------------------------
   procedure Test_Filtre_Decrypt_1 (T : in out Test_Fixt_T) is
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
         R : constant Reception_Blocs_T := Ecriveur_Generateur.Lire_Resultat;
         use type Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T;
      begin
         AUnit.Assertions.Assert
            (R (Natural'First) = Brut_Original,
            "Brut : " & R (Natural'First)'Img &
            " au lieu de " & Brut_Original'Img &
            " en position : 0"
            );
         for I in Natural'First + 1 .. Fin_Constante_Bloc loop
            AUnit.Assertions.Assert
               (R (I) = 0,
               "Brut : " & R (I)'Img &
               " au lieu de 0" &
               " en position : " & I'Img
               );
         end loop;
      end;
   end Test_Filtre_Decrypt_1;

   ---------------------------------------------------------------------------
   procedure Test_Filtre_Crypt_2048 (T : in out Test_Fixt_T) is
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
            --  Décalage à gauche pour le cryptage.
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
         R : constant Reception_Blocs_T := Ecriveur_Generateur.Lire_Resultat;
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
   end Test_Filtre_Crypt_2048;

   ---------------------------------------------------------------------------
   procedure Test_Filtre_Decrypt_2048 (T : in out Test_Fixt_T) is
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
         R : constant Reception_Blocs_T := Ecriveur_Generateur.Lire_Resultat;
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
   end Test_Filtre_Decrypt_2048;

   ---------------------------------------------------------------------------
   procedure Test_Fin is
   begin
      Faire_Avorter;
   end Test_Fin;

   ---------------------------------------------------------------------------
   protected body Ecriveur_Generateur_Protegee is
      ---------------------------------------------------------
      procedure Ouvrir_Fichier (Nom : String) is
      begin
         null;
      end Ouvrir_Fichier;

      ---------------------------------------------------------
      procedure Ecrire
         (Brut : C_Bloc_64_P.Bloc_64_Brut_T)
      is
      begin
         Resultats (Nb_Blocs_Ecrit) := Brut;
         Nb_Blocs_Ecrit := Natural'Succ (Nb_Blocs_Ecrit);
      end Ecrire;

      ---------------------------------------------------------
      procedure Fermer_Fichier is
      begin
         null;
      end Fermer_Fichier;

      ---------------------------------------------------------
      procedure Remettre_A_Zero is
      begin
         Nb_Blocs_Ecrit := Natural'First;
      end Remettre_A_Zero;

      ---------------------------------------------------------
      function Lire_Resultat return Reception_Blocs_T is
      begin
         return Resultats;
      end Lire_Resultat;

      ---------------------------------------------------------
      function Lire_Nb_Bloc_Ecrit return Natural is
      begin
         return Nb_Blocs_Ecrit;
      end Lire_Nb_Bloc_Ecrit;
      ---------------------------------------------------------
   end Ecriveur_Generateur_Protegee;

   ---------------------------------------------------------------------------
   protected body Lecteur_Generateur_Protegee is
      ---------------------------------------------------------
      procedure Ouvrir_Fichier (Nom : String) is
      begin
         null;
      end Ouvrir_Fichier;

      ---------------------------------------------------------
      procedure Lire (Brut : out C_Bloc_64_P.Bloc_64_Brut_T)
      is
      begin
         Nb_Blocs_Lu := Natural'Succ (Nb_Blocs_Lu);
         Brut := Brut_Genere;
      end Lire;

      ---------------------------------------------------------
      function Est_Fini return Boolean
      is
      begin
         return Nb_Blocs_Lu >= Max_Blocs;
      end Est_Fini;

      ---------------------------------------------------------
      procedure Fermer_Fichier is
      begin
         null;
      end Fermer_Fichier;

      ---------------------------------------------------------
      procedure Remettre_A_Zero is
      begin
         Nb_Blocs_Lu := Natural'First;
      end Remettre_A_Zero;

      ---------------------------------------------------------
      procedure Changer_Brut_Genere
         (Brut : C_Bloc_64_P.Bloc_64_Brut_T)
      is
      begin
         Brut_Genere := Brut;
      end Changer_Brut_Genere;

      ---------------------------------------------------------
      procedure Changer_Max_Genere (Max : Natural) is
      begin
         Max_Blocs := Max;
      end Changer_Max_Genere;

      ---------------------------------------------------------
      function Lire_Nb_Bloc_Lu return Natural is
      begin
         return Nb_Blocs_Lu;
      end Lire_Nb_Bloc_Lu;
      ---------------------------------------------------------
   end Lecteur_Generateur_Protegee;

end Des_P.Chaine_P.Ravenscar_P.Test_P;
