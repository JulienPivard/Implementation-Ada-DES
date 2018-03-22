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
with Ada.Sequential_IO;

with Ada.IO_Exceptions;

package body Des_P.Chaine_P.Taches_P.Test_P is

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
      declare
         Clef_56 : Des_P.Clef_P.Clef_56_I_P.Clef_Interface_T'Class :=
            Des_P.Faiseur_P.Faire_Clef (Const_56, T.Clef);
         Fabrique : Des_P.Filtre_P.Fabrique_P.Cryptage_P.Fabrique_T;
      begin
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
         Fichier : Lecteur_64_IO.File_Type;
         use type Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T;
         Brut_Utilise : Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T;
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
   end Test_Filtre_Crypt;

   ---------------------------------------------------------------------------
   procedure Test_Filtre_Decrypt (T : in out Test_Fixt_T) is
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
      declare
         Clef_56 : Des_P.Clef_P.Clef_56_I_P.Clef_Interface_T'Class :=
            Des_P.Faiseur_P.Faire_Clef (Const_56, T.Clef);
         Fabrique : Des_P.Filtre_P.Fabrique_P.Decryptage_P.Fabrique_T;
         J : Numero_Filtre_T := Numero_Filtre_T'First;
         use type Des_P.Clef_P.Clef_56_I_P.Decalage_T;
      begin
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
            Clef_56.Decaler_Bits_A_Gauche (-1 * Table_Decalage (I));
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
         Fichier : Lecteur_64_IO.File_Type;
         use type Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T;
         Brut_Utilise : Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T;
      begin
         Lecteur_64_IO.Open (Fichier, Lecteur_64_IO.In_File, Nom_Alternatif);
         Lecteur_64_IO.Read (Fichier, Brut_Utilise);
         Lecteur_64_IO.Close (Fichier);
         AUnit.Assertions.Assert
            (Brut_Utilise = Brut,
            "Brut : " & Brut_Utilise'Img &
            " au lieu de " & Brut'Img
            );
      exception
         when Ada.IO_Exceptions.End_Error =>
            Lecteur_64_IO.Close (Fichier);
            AUnit.Assertions.Assert
               (False, "Erreur Fin fichier atteinte");
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
         Fichier : Lecteur_64_IO.File_Type;
      begin
         Lecteur_64_IO.Create (Fichier, Lecteur_64_IO.Out_File, Nom_Fichier);
         Lecteur_64_IO.Write (Fichier, Brut);
         Lecteur_64_IO.Close (Fichier);
         pragma Unreferenced (Fichier);
      end;
      declare
         Clef_56 : Des_P.Clef_P.Clef_56_I_P.Clef_Interface_T'Class :=
            Des_P.Faiseur_P.Faire_Clef (Const_56, T.Clef);
         Fabrique : Des_P.Filtre_P.Fabrique_P.Cryptage_P.Fabrique_T;
      begin
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
         Fichier : Lecteur_64_IO.File_Type;
         Brut_Utilise : Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T;
      begin
         Lecteur_64_IO.Open (Fichier, Lecteur_64_IO.In_File, Nom_Alternatif);
         Lecteur_64_IO.Read (Fichier, Brut_Utilise);
         Lecteur_64_IO.Close (Fichier);
         Brut_Task := Brut_Utilise;
      exception
         when Ada.IO_Exceptions.End_Error =>
            Lecteur_64_IO.Close (Fichier);
            AUnit.Assertions.Assert
               (False, "Erreur Fin fichier atteinte");
      end;

      declare
         Fichier : Lecteur_64_IO.File_Type;
      begin
         Lecteur_64_IO.Create (Fichier, Lecteur_64_IO.Out_File, Nom_Fichier);
         Lecteur_64_IO.Write (Fichier, Brut);
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
         Fichier : Lecteur_64_IO.File_Type;
      begin
         Lecteur_64_IO.Create (Fichier, Lecteur_64_IO.Out_File, Nom_Fichier);
         Lecteur_64_IO.Write (Fichier, Brut_Attendu);
         Lecteur_64_IO.Close (Fichier);
         pragma Unreferenced (Fichier);
      end;
      declare
         Clef_56 : Des_P.Clef_P.Clef_56_I_P.Clef_Interface_T'Class :=
            Des_P.Faiseur_P.Faire_Clef (Const_56, T.Clef);
         Fabrique : Des_P.Filtre_P.Fabrique_P.Decryptage_P.Fabrique_T;
         J : Numero_Filtre_T := Numero_Filtre_T'First;
         use type Des_P.Clef_P.Clef_56_I_P.Decalage_T;
      begin
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
            Clef_56.Decaler_Bits_A_Gauche (-1 * Table_Decalage (I));
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
         Fichier : Lecteur_64_IO.File_Type;
         Brut_Utilise : Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T;
      begin
         Lecteur_64_IO.Open (Fichier, Lecteur_64_IO.In_File, Nom_Alternatif);
         Lecteur_64_IO.Read (Fichier, Brut_Utilise);
         Lecteur_64_IO.Close (Fichier);
         Brut_Task := Brut_Utilise;
      exception
         when Ada.IO_Exceptions.End_Error =>
            Lecteur_64_IO.Close (Fichier);
            AUnit.Assertions.Assert
               (False, "Erreur Fin fichier atteinte");
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

end Des_P.Chaine_P.Taches_P.Test_P;
