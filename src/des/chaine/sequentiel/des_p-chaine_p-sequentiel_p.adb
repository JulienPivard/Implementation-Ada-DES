with Des_P.Bloc_P.Bloc_64_P;

package body Des_P.Chaine_P.Sequentiel_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Filtrer
      (
         Chaine      : Chaine_T;
         Nom_Fichier : String;
         Extension   : String
      )
   is
      --  Le brut bits.
      Brut           : Des_P.Bloc_P.Bloc_64_P.Faiseur_P.Bloc_64_Brut_T;
      Nom_Alternatif : constant String := Nom_Fichier & "." & Extension;
   begin

      --  Si le fichier à écrire existe il est ouvert et écrasé
      --  sinon il est créé.
      Ecriveur.all.Ouvrir_Fichier (Nom => Nom_Alternatif);
      --  Ouverture du fichier à lire.
      Lecteur.all.Ouvrir_Fichier (Nom => Nom_Fichier);

      Lecture_Fichier :
      loop
         exit Lecture_Fichier when Lecteur.all.Est_Fini;
         --  Récupération du brut.
         Lecteur.all.Lire (Brut => Brut);

         Chaine.Execution (Brut => Brut);

         --  Écriture du brut dans le fichier.
         Ecriveur.all.Ecrire (Brut => Brut);
      end loop Lecture_Fichier;

      --  Fermeture des fichiers.
      Lecteur.all.Fermer_Fichier;
      Ecriveur.all.Fermer_Fichier;

   end Filtrer;

   ---------------------------------------------------------------------------
   --                               Partie privée                           --
   ---------------------------------------------------------------------------
   ---------------------------------------------------------------------------
   procedure Execution
      (
         Chaine   : Chaine_T;
         Brut     : in out Des_P.Bloc_P.Bloc_64_P.Faiseur_P.Bloc_64_Brut_T
      )
   is
      C_64 : Des_P.Bloc_P.Bloc_64_P.Faiseur_P.Faiseur_Bloc_T;
      Bloc : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
   begin
      --  Construction du bloc de 64 bits.
      C_64.Preparer_Nouveau_Bloc;
      C_64.Construire_Bloc (Brut => Brut);
      Bloc := C_64.Recuperer_Bloc;

      --  Lancement du chiffrement déchiffrement.
      Chaine.Tete.Iterer (Bloc => Bloc);

      --  Récupération du brut après l'avoir modifié.
      Brut := C_64.Transformer_En_Brut (Bloc => Bloc);
   end Execution;

end Des_P.Chaine_P.Sequentiel_P;
