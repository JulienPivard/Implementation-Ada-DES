with AUnit.Assertions;

with Des_P.Clef_P.Clef_64_P.Constructeur_P;
with Des_P.Clef_P.Clef_56_P.Constructeur_P;
with Des_P.Clef_P.Clef_48_P.Constructeur_P;
with Des_P.Clef_P.Clef_48_P;

with Des_P.Chaine_P.Sequentiel_P;
with Des_P.Chaine_P.Sequentiel_P.Constructeur_Cryptage_P;
with Des_P.Chaine_P.Sequentiel_P.Constructeur_Decryptage_P;

with Des_P.Filtre_P.Fabrique_P.Cryptage_P;
with Des_P.Filtre_P.Fabrique_P.Decryptage_P;
with Des_P.Faiseur_P;

with Ada.Directories;

with Ada.IO_Exceptions;

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
      Const_56 : Faiseur_56_P.Constructeur_Clef_T;
      Const_48 : Faiseur_48_P.Constructeur_Clef_T;
   begin
      declare
         Clef_56 : Des_P.Clef_P.Clef_56_I_P.Clef_Interface_T'Class :=
            Des_P.Faiseur_P.Faire_Clef (Const_56, T.Clef);
         Fabrique : Des_P.Filtre_P.Fabrique_P.Cryptage_P.Fabrique_T;
      begin
         Lecteur_Generateur.Changer_Brut_Genere (Brut_Original);
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
   end Test_Filtre_Crypt;

   ---------------------------------------------------------------------------
   procedure Test_Filtre_Decrypt (T : in out Test_Fixt_T) is
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
   end Test_Filtre_Decrypt;

   ---------------------------------------------------------------------------
   procedure Test_Comparaison_Sequentiel_Crypt (T : in out Test_Fixt_T) is
      package Faiseur_Cryptage_Seq_P renames
         Des_P.Chaine_P.Sequentiel_P.Constructeur_Cryptage_P;
      Const_Crypt_S : Faiseur_Cryptage_Seq_P.Constructeur_Cryptage_T;
      Const_56 : Faiseur_56_P.Constructeur_Clef_T;
      Const_48 : Faiseur_48_P.Constructeur_Clef_T;
      Brut_Sequ : Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T;
      Brut_Task : Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T;
      use type Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T;
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
         Brut_Tmp : constant Reception_Blocs_T :=
            Ecriveur_Generateur.Lire_Resultat;
      begin
         Brut_Task := Brut_Tmp (Natural'First);
      end;

      declare
         Fichier : Lecteur_64_IO.File_Type;
      begin
         Lecteur_64_IO.Create (Fichier, Lecteur_64_IO.Out_File, Nom_Fichier);
         Lecteur_64_IO.Write (Fichier, Brut_Original);
         Lecteur_64_IO.Close (Fichier);
         pragma Unreferenced (Fichier);
      end;
      Const_Crypt_S.Initialiser (Const_56, Const_48);
      Const_Crypt_S.Construire (T.Clef);
      declare
         Chaine : Des_P.Chaine_P.Sequentiel_P.Chaine_T;
      begin
         Chaine := Des_P.Chaine_P.Sequentiel_P.Chaine_T
            (Const_Crypt_S.Recuperer_Chaine);

         Chaine.Filtrer (Nom_Fichier, Extension);
      end;

      declare
         Fichier : Lecteur_64_IO.File_Type;
         Brut_Utilise : Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T;
      begin
         Lecteur_64_IO.Open (Fichier, Lecteur_64_IO.In_File, Nom_Alternatif);
         Lecteur_64_IO.Read (Fichier, Brut_Utilise);
         Lecteur_64_IO.Close (Fichier);
         Brut_Sequ := Brut_Utilise;
      exception
         when Ada.IO_Exceptions.End_Error =>
            Lecteur_64_IO.Close (Fichier);
            AUnit.Assertions.Assert
               (False, "Erreur Fin fichier atteinte");
      end;

      AUnit.Assertions.Assert
         (Brut_Task = Brut_Sequ,
         "Brut taches : " & Brut_Task'Img &
         " au lieu de sequentiel " & Brut_Sequ'Img
         );
   end Test_Comparaison_Sequentiel_Crypt;

   ---------------------------------------------------------------------------
   procedure Test_Comparaison_Sequentiel_Decrypt (T : in out Test_Fixt_T) is
      package Faiseur_Decryptage_Seq_P renames
         Des_P.Chaine_P.Sequentiel_P.Constructeur_Decryptage_P;
      Const_Decrypt_S : Faiseur_Decryptage_Seq_P.Constructeur_Decryptage_T;
      Const_56 : Faiseur_56_P.Constructeur_Clef_T;
      Const_48 : Faiseur_48_P.Constructeur_Clef_T;
      Brut_Sequ : Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T;
      Brut_Task : Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T;
      use type Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T;
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
         Brut_Tmp : constant Reception_Blocs_T :=
            Ecriveur_Generateur.Lire_Resultat;
      begin
         Brut_Task := Brut_Tmp (Natural'First);
      end;

      declare
         Fichier : Lecteur_64_IO.File_Type;
      begin
         Lecteur_64_IO.Create (Fichier, Lecteur_64_IO.Out_File, Nom_Fichier);
         Lecteur_64_IO.Write (Fichier, Brut_Attendu);
         Lecteur_64_IO.Close (Fichier);
         pragma Unreferenced (Fichier);
      end;
      Const_Decrypt_S.Initialiser (Const_56, Const_48);
      Const_Decrypt_S.Construire (T.Clef);
      declare
         Chaine : Des_P.Chaine_P.Sequentiel_P.Chaine_T;
      begin
         Chaine := Des_P.Chaine_P.Sequentiel_P.Chaine_T
            (Const_Decrypt_S.Recuperer_Chaine);

         Chaine.Filtrer (Nom_Fichier, Extension);
      end;

      declare
         Fichier : Lecteur_64_IO.File_Type;
         Brut_Utilise : Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T;
      begin
         Lecteur_64_IO.Open (Fichier, Lecteur_64_IO.In_File, Nom_Alternatif);
         Lecteur_64_IO.Read (Fichier, Brut_Utilise);
         Lecteur_64_IO.Close (Fichier);
         Brut_Sequ := Brut_Utilise;
      exception
         when Ada.IO_Exceptions.End_Error =>
            Lecteur_64_IO.Close (Fichier);
            AUnit.Assertions.Assert
               (False, "Erreur Fin fichier atteinte");
      end;

      AUnit.Assertions.Assert
         (Brut_Task = Brut_Sequ,
         "Brut taches : " & Brut_Task'Img &
         " au lieu de sequentiel " & Brut_Sequ'Img
         );
   end Test_Comparaison_Sequentiel_Decrypt;

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
         return Nb_Blocs_Lu > Max_Blocs;
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
   end Lecteur_Generateur_Protegee;

end Des_P.Chaine_P.Ravenscar_P.Test_P;
