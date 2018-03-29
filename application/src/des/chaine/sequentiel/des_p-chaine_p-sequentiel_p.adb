with Ada.Directories;

with Ada.Sequential_IO;

with Des_P.Bloc_P.Bloc_64_P;

package body Des_P.Chaine_P.Sequentiel_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Filtrer
      (
         Chaine : Chaine_T;
         Nom_Fichier : String;
         Extension : String
      )
   is
      package Lecteur_64_IO is new Ada.Sequential_IO
      (Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T);

      --  Les fichiers à lire et à écrire.
      Fichier : Lecteur_64_IO.File_Type;
      Resultat : Lecteur_64_IO.File_Type;

      --  Le brut bits.
      Brut : Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T;
      Nom_Alternatif : constant String := Nom_Fichier & "." & Extension;
   begin

      --  Si le fichier à écrire existe il est ouvert et écrasé
      --  sinon il est créé.
      if Ada.Directories.Exists (Nom_Alternatif) then
         Lecteur_64_IO.Open
            (Resultat, Lecteur_64_IO.Out_File, Nom_Alternatif);
      else
         Lecteur_64_IO.Create
            (Resultat, Lecteur_64_IO.Out_File, Nom_Alternatif);
      end if;
      --  Ouverture du fichier à lire.
      Lecteur_64_IO.Open (Fichier, Lecteur_64_IO.In_File, Nom_Fichier);

      Lecture_Fichier :
      loop
         exit Lecture_Fichier when Lecteur_64_IO.End_Of_File (Fichier);
         --  Récupération du brut.
         Lecteur_64_IO.Read (Fichier, Brut);

         Chaine.Execution (Brut);

         --  Écriture du brut dans le fichier.
         Lecteur_64_IO.Write (Resultat, Brut);
      end loop Lecture_Fichier;

      --  Fermeture des fichiers.
      Lecteur_64_IO.Close (Fichier);
      pragma Unreferenced (Fichier);
      Lecteur_64_IO.Close (Resultat);
      pragma Unreferenced (Resultat);

   end Filtrer;

   ---------------------------------------------------------------------------
   --                               Partie privée                           --
   ---------------------------------------------------------------------------
   ---------------------------------------------------------------------------
   procedure Execution
      (
         Chaine : Chaine_T;
         Brut : in out Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T
      )
   is
      C_64 : Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Constructeur_Bloc_64_T;
      Bloc : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
   begin
      --  Construction du bloc de 64 bits.
      C_64.Preparer_Nouveau_Bloc;
      C_64.Construire_Bloc (Brut);
      Bloc := C_64.Recuperer_Bloc;

      --  Lancement du chiffrement déchiffrement.
      Chaine.Tete.Iterer (Bloc);

      --  Récupération du brut après l'avoir modifié.
      Brut := C_64.Transformer_En_Brut (Bloc);
   end Execution;

end Des_P.Chaine_P.Sequentiel_P;
