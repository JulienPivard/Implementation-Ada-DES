--  Pour indiquer qu'une autre tache peut prendre le pas
--  sur celle en cours. Équivalent à un delay 0.0 dans
--  d'ancien code sources.
with Ada.Dispatching;

package body Des_P.Chaine_P.Ravenscar_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Filtrer
      (
         Chaine      : Chaine_T;
         Nom_Fichier : String;
         Extension   : String
      )
   is
      Nom_Alternatif : constant String :=
         Nom_Fichier & "." & Extension;
   begin
      --  Modifie le nombre de grappe max dans le pipeline
      --  si la modification est demandée.
      if Chaine.Modifier_Max_Grappes then
         Limiteur_R.Limiteur_Protegee.Modifier_Nb_Max_Blocs
            (Chaine.Max_Grappes);
      end if;
      --  Ouverture du fichier à lire.
      Lecteur.all.Ouvrir_Fichier  (Nom_Fichier);
      --  Ouverture du fichier à écrire.
      Ecriveur.all.Ouvrir_Fichier (Nom_Alternatif);

      --  Initialisation des filtres dans les étages.
      Filtre_Entree_Protegee.Changer_Filtre
         (Chaine.Filtre_Entree.Element);
      for I in Numero_Filtre_T loop
         Table_Filtreur (I).all.Changer_Filtre
            (Chaine.Filtres_Corps (I).Element);
      end loop;
      Filtre_Sortie_Protegee.Changer_Filtre
         (Chaine.Filtre_Sortie.Element);

      --  Lancement du chiffrement.
      Demarreur_Protegee.Demarrer;
      --  Attend la fin du chiffrement.
      Fin_Protegee.Attendre_Entree;

      --  Fermeture du fichier à lire.
      Lecteur.all.Fermer_Fichier;
      --  Fermeture du fichier à écrire.
      Ecriveur.all.Fermer_Fichier;
   end Filtrer;

   ---------------------------------------------------------------------------
   procedure Faire_Avorter is
   begin
      Avorter_Protegee.Avorter;
      Demarreur_Protegee.Demarrer;
   end Faire_Avorter;

   ---------------------------------------------------------------------------
   --                               Partie privée                           --
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Filtrer
      (
         Grappe_De_Donnees : in out Donnee_T;
         Procedure_Filtre  : not null access procedure
            (Table_De_Donnees : in out Table_Bloc_R.Table_Bloc_T)
      )
   is
   begin
      Procedure_Filtre
         (Grappe_De_Donnees.Table.Reference);
   end Filtrer;

   ---------------------------------------------------------------------------
   procedure Appliquer
      (
         Grappe_De_Donnees      : Donnee_T;
         Procedure_A_Appliquer  : not null access procedure
            (Table_De_Donnees : Table_Bloc_R.Table_Bloc_T)
      )
   is
   begin
      Procedure_A_Appliquer
         (Grappe_De_Donnees.Table.Element);
   end Appliquer;

   ---------------------------------------------------------------------------
   procedure Ecrire_Table
      (
         Grappe_De_Donnees : in out Donnee_T;
         Table_De_Donnees  : Table_Bloc_R.Table_Bloc_T
      )
   is
   begin
      Grappe_De_Donnees.Table :=
         Table_Holder_P.To_Holder (Table_De_Donnees);
   end Ecrire_Table;

   ---------------------------------------------------------------------------
   procedure Ecrire_Est_Derniere
      (
         Grappe_De_Donnees : in out Donnee_T;
         Fini              : Boolean
      )
   is
   begin
      Grappe_De_Donnees.Est_Derniere_Grappe := Fini;
   end Ecrire_Est_Derniere;

   ---------------------------------------------------------------------------
   protected body Avorter_Protegee is
      ---------------------------------------------------------
      procedure Avorter is
      begin
         Arreter_Application := True;
      end Avorter;

      ---------------------------------------------------------
      function Avorter
         return Boolean
      is
      begin
         return Arreter_Application;
      end Avorter;
      ---------------------------------------------------------
   end Avorter_Protegee;

   ---------------------------------------------------------------------------
   protected body Autorisation_Rearmement_Protegee is
      ---------------------------------------------------------
      entry Attendre_Entree
         when Autoriser_Relance
      is
      begin
         --  Compte combien de tache ont été lancée.
         Nb_Tache_Lancee := Compteur_Tache_T'Succ (Nb_Tache_Lancee);
         --  Si toutes les taches ont été lancées on réarme
         --  démarreur pour une éventuel prochaine fois.
         if Nb_Tache_Lancee = Compteur_Tache_T'Last then
            Autoriser_Relance := False;
            Nb_Tache_Lancee   := Compteur_Tache_T'First;
            --  On signal que le traitement est fini
            Fin_Protegee.Fini;
         end if;
      end Attendre_Entree;

      ---------------------------------------------------------
      procedure Autoriser is
      begin
         Autoriser_Relance := True;
      end Autoriser;
      ---------------------------------------------------------
   end Autorisation_Rearmement_Protegee;

   ---------------------------------------------------------------------------
   protected body Demarreur_Protegee is
      ---------------------------------------------------------
      entry Attendre_Entree
         when Demarrage_Autorise
      is
      begin
         --  Compte combien de tache ont été lancée.
         Nb_Tache_Lancee := Compteur_Tache_T'Succ (Nb_Tache_Lancee);
         --  Si toutes les taches ont été lancées on réarme
         --  démarreur pour une éventuel prochaine fois.
         if Nb_Tache_Lancee = Compteur_Tache_T'Last then
            Demarrage_Autorise   := False;
            Nb_Tache_Lancee      := Compteur_Tache_T'First;
            Autorisation_Rearmement_Protegee.Autoriser;
         end if;
      end Attendre_Entree;

      ---------------------------------------------------------
      procedure Demarrer is
      begin
         Demarrage_Autorise := True;
      end Demarrer;
      ---------------------------------------------------------
   end Demarreur_Protegee;

   ---------------------------------------------------------------------------
   protected body Fin_Protegee is
      ---------------------------------------------------------
      entry Attendre_Entree
         when Est_Fini
      is
      begin
         Est_Fini := False;
      end Attendre_Entree;

      ---------------------------------------------------------
      procedure Fini is
      begin
         Est_Fini := True;
      end Fini;
      ---------------------------------------------------------
   end Fin_Protegee;

   ---------------------------------------------------------------------------
   protected body Filtre_Entree_Protegee is
      ---------------------------------------------------------
      procedure Changer_Filtre
         (Filtre : Des_P.Filtre_P.Entree_P.Entree_Abstrait_T'Class)
      is
      begin
         Filtre_H          :=
            Des_P.Filtre_P.Entree_P.Holder_P.To_Holder (Filtre);
         Filtre_Initialise := not Filtre_H.Is_Empty;
      end Changer_Filtre;

      ---------------------------------------------------------
      entry Attendre_Entree
         when Filtre_Initialise
      is
      begin
         null;
      end Attendre_Entree;

      ---------------------------------------------------------
      function Lire_Filtre
         return Des_P.Filtre_P.Entree_P.Entree_Abstrait_T'Class
      is
      begin
         return Filtre_H.Element;
      end Lire_Filtre;
      ---------------------------------------------------------
   end Filtre_Entree_Protegee;

   ---------------------------------------------------------------------------
   protected body Filtre_Corps_Protegee_T is
      ---------------------------------------------------------
      procedure Changer_Filtre
         (Filtre : Des_P.Filtre_P.Corps_P.Corps_Abstrait_T'Class)
      is
      begin
         Filtre_H          :=
            Des_P.Filtre_P.Corps_P.Holder_P.To_Holder (Filtre);
         Filtre_Initialise := not Filtre_H.Is_Empty;
      end Changer_Filtre;

      ---------------------------------------------------------
      entry Attendre_Entree
         when Filtre_Initialise
      is
      begin
         null;
      end Attendre_Entree;

      ---------------------------------------------------------
      function Lire_Filtre
         return Des_P.Filtre_P.Corps_P.Corps_Abstrait_T'Class
      is
      begin
         return Filtre_H.Element;
      end Lire_Filtre;
      ---------------------------------------------------------
   end Filtre_Corps_Protegee_T;

   ---------------------------------------------------------------------------
   protected body Filtre_Sortie_Protegee is
      ---------------------------------------------------------
      entry Attendre_Entree
         when Filtre_Initialise
      is
      begin
         null;
      end Attendre_Entree;

      ---------------------------------------------------------
      procedure Changer_Filtre
         (Filtre : Des_P.Filtre_P.Sortie_P.Sortie_Abstrait_T'Class)
      is
      begin
         Filtre_H          :=
            Des_P.Filtre_P.Sortie_P.Holder_P.To_Holder (Filtre);
         Filtre_Initialise := not Filtre_H.Is_Empty;
      end Changer_Filtre;

      ---------------------------------------------------------
      function Lire_Filtre
         return Des_P.Filtre_P.Sortie_P.Sortie_Abstrait_T'Class
      is
      begin
         return Filtre_H.Element;
      end Lire_Filtre;
      ---------------------------------------------------------
   end Filtre_Sortie_Protegee;

   ---------------------------------------------------------------------------
   protected body Autorisation_Protegee_T is
      ---------------------------------------------------------
      entry Attendre_Entree
         when Bloc_Disponnible
      is
      begin
         Bloc_Disponnible := False;
      end Attendre_Entree;

      ---------------------------------------------------------
      procedure Autoriser is
      begin
         Bloc_Disponnible := True;
      end Autoriser;
      ---------------------------------------------------------
   end Autorisation_Protegee_T;

   ---------------------------------------------------------------------------
   protected body Donnee_Protegee_T is
      ---------------------------------------------------------
      entry Ecrire_Donnee_Entree
         (Grappe_De_Donnees : Donnee_T)
         when Bloc_Disponnible
      is
      begin
         Donnee            := Grappe_De_Donnees;
         Bloc_Disponnible  := False;
      end Ecrire_Donnee_Entree;

      ---------------------------------------------------------
      procedure Lire_Donnee
         (Grappe_De_Donnees : out Donnee_T)
      is
      begin
         Grappe_De_Donnees := Donnee;
         Bloc_Disponnible  := True;
      end Lire_Donnee;
      ---------------------------------------------------------
   end Donnee_Protegee_T;

   ---------------------------------------------------------------------------
   task body Etage_Lecteur_Tache is
      subtype Table_Tmp_T is Table_Bloc_T (Indice_T);

      Table : Table_Tmp_T;
      C_64  : C_Bloc_64_R.Faiseur_Bloc_T;
      J     : Table_Bloc_R.Indice_T;
   begin
      Repetition_Ou_Non :
      loop

         --  On attend le signal de démarrage
         Demarreur_Protegee.Attendre_Entree;
         exit Repetition_Ou_Non when Avorter_Protegee.Avorter;

         Lecture_Fichier :
         loop
            J := Table_Bloc_R.Indice_T'First;

            Remplissage :
            loop
               --  On sort si le fichier est vide
               exit Remplissage when Lecteur.all.Est_Fini;
               --  Transformation du brut lu en un bloc.
               C_64.Preparer_Nouveau_Bloc;
               Construction_Bloc :
               declare
                  ---------------------------------------------------------
                  function Lire_Grappe
                     return C_Bloc_64_R.Bloc_64_Brut_T;
                  function Lire_Grappe
                     return C_Bloc_64_R.Bloc_64_Brut_T
                  is
                     Brut : C_Bloc_64_R.Bloc_64_Brut_T;
                  begin
                     Lecteur.all.Lire (Brut);
                     return Brut;
                  end Lire_Grappe;
                  ---------------------------------------------------------
                  Brut : constant C_Bloc_64_R.Bloc_64_Brut_T := Lire_Grappe;
               begin
                  C_64.Construire_Bloc (Brut);
               end Construction_Bloc;
               Table (J) := C_64.Recuperer_Bloc;
               exit Remplissage when J = Table_Bloc_R.Indice_T'Last;
               exit Remplissage when Lecteur.all.Est_Fini;
               J := Table_Bloc_R.Indice_T'Succ (J);
            end loop Remplissage;

            Transmission_Donnee_Bloc_Suivant :
            declare
               subtype Indice_Tmp_T is Indice_T range Indice_T'First .. J;
               --  Si on a atteint la fin du fichier on envoie le
               --  signal de terminaison
               D : Donnee_T;
            begin
               --  Si le tableau de blocs n'est pas plein on n'utilise pas
               --  entièrement le tableau mais seulement la sous partie utile.
               Ecrire_Table (D, Table (Indice_Tmp_T));
               Ecrire_Est_Derniere (D, Lecteur.all.Est_Fini);
               --  Lancement du filtrage de la grappe de blocs.
               Donnee_Debut.Ecrire_Donnee_Entree (D);
            end Transmission_Donnee_Bloc_Suivant;

            --  On signal la création d'un nouveau bloc,
            --  si il y en a trop en circulation la
            --  tâche est mise en pause.
            Limiteur_R.Limiteur_Protegee.Generer_Bloc_Entree;

            --  Signal que la donnée à été bien écrite et peut être lue.
            Autorisateur_Debut.Autoriser;

            Ada.Dispatching.Yield;

            --  La fin du fichier à été atteinte.
            exit Lecture_Fichier when Lecteur.all.Est_Fini;
         end loop Lecture_Fichier;

         --  Quand tout le travail est fini la tâche attend ici qu'elles
         --  aient toutes fini avant de considérer qu'elle est prête à
         --  chiffrer un autre fichier.
         Autorisation_Rearmement_Protegee.Attendre_Entree;

      end loop Repetition_Ou_Non;
   end Etage_Lecteur_Tache;

   ---------------------------------------------------------------------------
   task body Etage_Entree_Tache is
      ---------------------------------------------------------
      procedure Filtrer_Grappe
         (Table_De_Donnees : in out Table_Bloc_R.Table_Bloc_T);
      procedure Filtrer_Grappe
         (Table_De_Donnees : in out Table_Bloc_R.Table_Bloc_T)
      is
         Filtre : constant
         Des_P.Filtre_P.Entree_P.Entree_Abstrait_T'Class :=
            Filtre_Entree_Protegee.Lire_Filtre;
      begin
         for E of Table_De_Donnees loop
            Filtre.Filtrer (E);
         end loop;
      end Filtrer_Grappe;
      ---------------------------------------------------------
   begin
      Repetition_Ou_Non :
      loop

         --  On attend le signal de démarrage
         Demarreur_Protegee.Attendre_Entree;
         exit Repetition_Ou_Non when Avorter_Protegee.Avorter;

         Filtre_Entree_Protegee.Attendre_Entree;
         Filtrage :
         loop
            --  En attente de l'autorisation de lire.
            Autorisateur_Debut.Attendre_Entree;

            Transmission_Donnee_Bloc_Suivant :
            declare
               --  Lecture des données.
               D : Donnee_T;
            begin
               --  Signal que les données ont été lue.
               Donnee_Debut.Lire_Donnee (D);
               --  Filtrage des données
               Filtrer (D, Filtrer_Grappe'Access);
               --  Envoie des données a la tache suivante.
               Donnee_01.Ecrire_Donnee_Entree (D);
               --  Autorise la tache suivante à lire.
               Autorisateur_01.Autoriser;

               exit Filtrage when Est_Derniere (D);
            end Transmission_Donnee_Bloc_Suivant;

            Ada.Dispatching.Yield;

         end loop Filtrage;

         --  Quand tout le travail est fini la tâche attend ici qu'elles
         --  aient toutes fini avant de considérer qu'elle est prête à
         --  chiffrer un autre fichier.
         Autorisation_Rearmement_Protegee.Attendre_Entree;

      end loop Repetition_Ou_Non;
   end Etage_Entree_Tache;

   ---------------------------------------------------------------------------
   task body Etage_Corps_Tache_T is
      ---------------------------------------------------------
      procedure Filtrer_Grappe
         (T : in out Table_Bloc_R.Table_Bloc_T);
      procedure Filtrer_Grappe
         (T : in out Table_Bloc_R.Table_Bloc_T)
      is
         Filtre : constant
         Des_P.Filtre_P.Corps_P.Corps_Abstrait_T'Class :=
            Filtreur.all.Lire_Filtre;
      begin
         for E of T loop
            Filtre.Filtrer (E);
         end loop;
      end Filtrer_Grappe;
      ---------------------------------------------------------
   begin
      Repetition_Ou_Non :
      loop

         --  On attend le signal de démarrage
         Demarreur_Protegee.Attendre_Entree;
         exit Repetition_Ou_Non when Avorter_Protegee.Avorter;

         Filtreur.all.Attendre_Entree;
         Filtrage :
         loop
            --  En attente de l'autorisation de lire.
            Autorisateur_Reception.all.Attendre_Entree;

            Transmission_Donnee_Bloc_Suivant :
            declare
               --  Lecture des données.
               D : Donnee_T;
            begin
               --  Signal que les données ont été lue.
               Donnee_Recue.all.Lire_Donnee (D);
               --  Filtrage des données
               Filtrer (D, Filtrer_Grappe'Access);
               --  Envoie des données a la tache suivante.
               Donnee_A_Envoyer.all.Ecrire_Donnee_Entree (D);

               --  Autorise la tache suivante à lire.
               Autorisateur_Envoyee.all.Autoriser;

               exit Filtrage when Est_Derniere (D);
            end Transmission_Donnee_Bloc_Suivant;

            Ada.Dispatching.Yield;

         end loop Filtrage;

         --  Quand tout le travail est fini la tâche attend ici qu'elles
         --  aient toutes fini avant de considérer qu'elle est prête à
         --  chiffrer un autre fichier.
         Autorisation_Rearmement_Protegee.Attendre_Entree;

      end loop Repetition_Ou_Non;
   end Etage_Corps_Tache_T;

   ---------------------------------------------------------------------------
   task body Etage_Sortie_Tache is
      ---------------------------------------------------------
      procedure Filtrer_Grappe
         (T : in out Table_Bloc_R.Table_Bloc_T);
      procedure Filtrer_Grappe
         (T : in out Table_Bloc_R.Table_Bloc_T)
      is
         Filtre : constant
         Des_P.Filtre_P.Sortie_P.Sortie_Abstrait_T'Class :=
            Filtre_Sortie_Protegee.Lire_Filtre;
      begin
         for E of T loop
            Filtre.Filtrer (E);
         end loop;
      end Filtrer_Grappe;
      ---------------------------------------------------------
   begin
      Repetition_Ou_Non :
      loop

         --  On attend le signal de démarrage
         Demarreur_Protegee.Attendre_Entree;
         exit Repetition_Ou_Non when Avorter_Protegee.Avorter;

         Filtre_Sortie_Protegee.Attendre_Entree;
         Filtrage :
         loop
            --  En attente de l'autorisation de lire.
            Autorisateur_17.Attendre_Entree;

            Transmission_Donnee_Bloc_Suivant :
            declare
               D : Donnee_T;
            begin
               --  Signal que les données ont été lue.
               Donnee_17.Lire_Donnee (D);
               --  Filtrage des données
               Filtrer (D, Filtrer_Grappe'Access);
               --  Envoie des données a la tache suivante.
               Donnee_Fin.Ecrire_Donnee_Entree (D);
               --  Autorise la tache suivante à lire.
               Autorisateur_Fin.Autoriser;

               exit Filtrage when Est_Derniere (D);
            end Transmission_Donnee_Bloc_Suivant;

            Ada.Dispatching.Yield;

         end loop Filtrage;

         --  Quand tout le travail est fini la tâche attend ici qu'elles
         --  aient toutes fini avant de considérer qu'elle est prête à
         --  chiffrer un autre fichier.
         Autorisation_Rearmement_Protegee.Attendre_Entree;

      end loop Repetition_Ou_Non;
   end Etage_Sortie_Tache;

   ---------------------------------------------------------------------------
   task body Etage_Ecriture_Tache is
      C_64 : C_Bloc_64_R.Faiseur_Bloc_T;
      ---------------------------------------------------------
      procedure Ecrire_Grappe
         (T : Table_Bloc_R.Table_Bloc_T);
      procedure Ecrire_Grappe
         (T : Table_Bloc_R.Table_Bloc_T)
      is
      begin
         for E of T loop
            Ecrit_Donnees_Dans_Fichier :
            declare
               --  Transformation du bloc en un brut
               Brut : constant C_Bloc_64_R.Bloc_64_Brut_T
                  := C_64.Transformer_En_Brut (E);
            begin
               Ecriveur.all.Ecrire (Brut);
            end Ecrit_Donnees_Dans_Fichier;
         end loop;
      end Ecrire_Grappe;
      ---------------------------------------------------------
   begin
      Repetition_Ou_Non :
      loop

         --  On attend le signal de démarrage
         Demarreur_Protegee.Attendre_Entree;
         exit Repetition_Ou_Non when Avorter_Protegee.Avorter;

         Ecriture_Fichier :
         loop
            Autorisateur_Fin.Attendre_Entree;

            Transmission_Donnee_Bloc_Suivant :
            declare
               D : Donnee_T;
            begin
               Donnee_Fin.Lire_Donnee (D);
               --  On écrit les données dans le fichier
               Appliquer (D, Ecrire_Grappe'Access);
               --  On signal que le bloc n'est plus dans le pipeline
               Limiteur_R.Limiteur_Protegee.Consommer_Bloc;

               exit Ecriture_Fichier when Est_Derniere (D);
            end Transmission_Donnee_Bloc_Suivant;

            Ada.Dispatching.Yield;

         end loop Ecriture_Fichier;

         --  Quand tout le travail est fini la tâche attend ici qu'elles
         --  aient toutes fini avant de considérer qu'elle est prête à
         --  chiffrer un autre fichier.
         Autorisation_Rearmement_Protegee.Attendre_Entree;

      end loop Repetition_Ou_Non;
   end Etage_Ecriture_Tache;

end Des_P.Chaine_P.Ravenscar_P;
