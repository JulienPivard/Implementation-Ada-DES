package body Des_P.Chaine_P.Ravenscar_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Filtrer
      (
         Chaine : Chaine_T;
         Nom_Fichier : String;
         Extension : String
      )
   is
      Nom_Alternatif : constant String := Nom_Fichier & "." & Extension;
   begin
      --  Modifie le nombre de grappe max dans le pipeline
      --  si la modification est demandée.
      if Chaine.Modifier_Max_Grappes then
         Limiteur_P.Limiteur_Protegee.Modifier_Nb_Max_Blocs
            (Chaine.Max_Grappes);
      end if;
      --  Ouverture du fichier à lire.
      Lecteur.all.Ouvrir_Fichier (Nom_Fichier);
      --  Ouverture du fichier à écrire.
      Ecriveur.all.Ouvrir_Fichier (Nom_Alternatif);

      --  Initialisation des filtres dans les étages.
      Filtre_Entree_Protegee.Changer_Filtre (Chaine.Filtre_Entree.Element);
      Filtre_Sortie_Protegee.Changer_Filtre (Chaine.Filtre_Sortie.Element);
      for I in Numero_Filtre_T loop
         Table_Filtreur (I).all.Changer_Filtre
            (Chaine.Filtres_Corps (I).Element);
      end loop;

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
   protected body Avorter_Protegee is
      ---------------------------------------------------------
      procedure Avorter is
      begin
         Signal := True;
      end Avorter;

      ---------------------------------------------------------
      function Avorter return Boolean is
      begin
         return Signal;
      end Avorter;
      ---------------------------------------------------------
   end Avorter_Protegee;

   ---------------------------------------------------------------------------
   protected body Autorisation_Rearmement_Protegee is
      ---------------------------------------------------------
      entry Attendre_Entree when Signal is
      begin
         --  Compte combien de tache ont été lancée.
         Nb_Tache_Lancee := Compteur_Tache_T'Succ (Nb_Tache_Lancee);
         --  Si toutes les taches ont été lancées on réarme
         --  démarreur pour une éventuel prochaine fois.
         if Nb_Tache_Lancee = Compteur_Tache_T'Last then
            Signal := False;
            Nb_Tache_Lancee := Compteur_Tache_T'First;
            --  On signal que le traitement est fini
            Fin_Protegee.Fini;
         end if;
      end Attendre_Entree;

      ---------------------------------------------------------
      procedure Autoriser is
      begin
         Signal := True;
      end Autoriser;
      ---------------------------------------------------------
   end Autorisation_Rearmement_Protegee;

   ---------------------------------------------------------------------------
   protected body Demarreur_Protegee is
      ---------------------------------------------------------
      entry Attendre_Entree when Signal is
      begin
         --  Compte combien de tache ont été lancée.
         Nb_Tache_Lancee := Compteur_Tache_T'Succ (Nb_Tache_Lancee);
         --  Si toutes les taches ont été lancées on réarme
         --  démarreur pour une éventuel prochaine fois.
         if Nb_Tache_Lancee = Compteur_Tache_T'Last then
            Signal := False;
            Nb_Tache_Lancee := Compteur_Tache_T'First;
            Autorisation_Rearmement_Protegee.Autoriser;
         end if;
      end Attendre_Entree;

      ---------------------------------------------------------
      procedure Demarrer is
      begin
         Signal := True;
      end Demarrer;
      ---------------------------------------------------------
   end Demarreur_Protegee;

   ---------------------------------------------------------------------------
   protected body Fin_Protegee is
      ---------------------------------------------------------
      entry Attendre_Entree when Signal is
      begin
         Signal := False;
      end Attendre_Entree;

      ---------------------------------------------------------
      procedure Fini is
      begin
         Signal := True;
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
         Filtre_H := Des_P.Filtre_P.Entree_P.Holder_P.To_Holder (Filtre);
         Signal := not Filtre_H.Is_Empty;
      end Changer_Filtre;

      ---------------------------------------------------------
      entry Attendre_Entree when Signal is
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
   protected body Filtre_Corps_Protegee is
      ---------------------------------------------------------
      procedure Changer_Filtre
         (Filtre : Des_P.Filtre_P.Corps_P.Corps_Abstrait_T'Class)
      is
      begin
         Filtre_H := Des_P.Filtre_P.Corps_P.Holder_P.To_Holder (Filtre);
         Signal := not Filtre_H.Is_Empty;
      end Changer_Filtre;

      ---------------------------------------------------------
      entry Attendre_Entree when Signal is
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
   end Filtre_Corps_Protegee;

   ---------------------------------------------------------------------------
   protected body Filtre_Sortie_Protegee is
      ---------------------------------------------------------
      procedure Changer_Filtre
         (Filtre : Des_P.Filtre_P.Sortie_P.Sortie_Abstrait_T'Class)
      is
      begin
         Filtre_H := Des_P.Filtre_P.Sortie_P.Holder_P.To_Holder (Filtre);
         Signal := not Filtre_H.Is_Empty;
      end Changer_Filtre;

      ---------------------------------------------------------
      entry Attendre_Entree when Signal is
      begin
         null;
      end Attendre_Entree;

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
   protected body Autorisation_Protegee is
      ---------------------------------------------------------
      entry Attendre_Entree when Signal is
      begin
         Signal := False;
      end Attendre_Entree;

      ---------------------------------------------------------
      procedure Autoriser is
      begin
         Signal := True;
      end Autoriser;
      ---------------------------------------------------------
   end Autorisation_Protegee;

   ---------------------------------------------------------------------------
   protected body Donnee_Protegee is
      ---------------------------------------------------------
      entry Ecrire_Donnee_Entree (Table : Donnee_T) when Signal is
      begin
         Donnee := Table;
         Signal := False;
      end Ecrire_Donnee_Entree;

      ---------------------------------------------------------
      procedure Lire_Donnee (Table : out Donnee_T) is
      begin
         Table := Donnee;
         Signal := True;
      end Lire_Donnee;
      ---------------------------------------------------------
   end Donnee_Protegee;

   ---------------------------------------------------------------------------
   task body Etage_Lecteur_Tache is
      Table : Table_Bloc_T (Indice_T);
      C_64 : C_Bloc_64_P.Constructeur_Bloc_64_T;
      J : Indice_T;
      ---------------------------------------------------------
      function Lire return C_Bloc_64_P.Bloc_64_Brut_T;
      function Lire return C_Bloc_64_P.Bloc_64_Brut_T is
         Brut : C_Bloc_64_P.Bloc_64_Brut_T;
      begin
         Lecteur.all.Lire (Brut);
         return Brut;
      end Lire;
      ---------------------------------------------------------
   begin
      Repetition_Ou_Non :
      loop

         --  On attend le signal de démarrage
         Demarreur_Protegee.Attendre_Entree;
         exit Repetition_Ou_Non when Avorter_Protegee.Avorter;

         Lecture_Fichier :
         loop
            J := Indice_T'First;

            Remplissage :
            for I in Indice_T loop
               --  On sort si le fichier est vide
               exit Remplissage when Lecteur.all.Est_Fini;
               --  Transformation du brut lu en un bloc.
               C_64.Preparer_Nouveau_Bloc;
               declare
                  Brut : constant C_Bloc_64_P.Bloc_64_Brut_T := Lire;
               begin
                  C_64.Construire_Bloc (Brut);
               end;
               Table (I) := C_64.Recuperer_Bloc;
               J := I;
            end loop Remplissage;

            declare
               --  Si on a atteint la fin du fichier on envoie le
               --  signal de terminaison
               D : Donnee_T;
            begin
               --  Si le tableau de blocs n'est pas plein on n'utilise pas
               --  entièrement le tableau mais seulement la sous partie utile.
               D.Table := Table_Holder_P.To_Holder
                  (Table (Indice_T'First .. J));
               D.Est_Derniere_Grappe := Lecteur.all.Est_Fini;
               --  Lancement du filtrage de la grappe de blocs.
               Donnee_Debut.Ecrire_Donnee_Entree (D);
            end;

            --  On signal la création d'un nouveau bloc,
            --  si il y en a trop en circulation la
            --  tâche est mise en pause.
            Limiteur_P.Limiteur_Protegee.Generer_Bloc_Entree;

            --  Signal que la donnée à été bien écrite et peut être lue.
            Autorisateur_Debut.Autoriser;

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
      procedure Filtrer_Grappe (T : in out Table_Bloc_T);
      procedure Filtrer_Grappe (T : in out Table_Bloc_T) is
         Filtre : constant
         Des_P.Filtre_P.Entree_P.Entree_Abstrait_T'Class :=
            Filtre_Entree_Protegee.Lire_Filtre;
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

         Filtre_Entree_Protegee.Attendre_Entree;
         Filtrage :
         loop
            --  En attente de l'autorisation de lire.
            Autorisateur_Debut.Attendre_Entree;

            declare
               --  Lecture des données.
               D : Donnee_T;
            begin
               --  Signal que les données ont été lue.
               Donnee_Debut.Lire_Donnee (D);
               --  Filtrage des données
               Filtrer_Grappe (D.Table.Reference);
               --  Envoie des données a la tache suivante.
               Donnee_01.Ecrire_Donnee_Entree (D);
               --  Autorise la tache suivante à lire.
               Autorisateur_01.Autoriser;

               exit Filtrage when D.Est_Derniere_Grappe;
            end;

         end loop Filtrage;

         --  Quand tout le travail est fini la tâche attend ici qu'elles
         --  aient toutes fini avant de considérer qu'elle est prête à
         --  chiffrer un autre fichier.
         Autorisation_Rearmement_Protegee.Attendre_Entree;

      end loop Repetition_Ou_Non;
   end Etage_Entree_Tache;

   ---------------------------------------------------------------------------
   task body Etage_Corps_Tache is
      ---------------------------------------------------------
      procedure Filtrer_Grappe (T : in out Table_Bloc_T);
      procedure Filtrer_Grappe (T : in out Table_Bloc_T) is
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

            declare
               --  Lecture des données.
               D : Donnee_T;
            begin
               --  Signal que les données ont été lue.
               Donnee_Recue.all.Lire_Donnee (D);
               --  Filtrage des données
               Filtrer_Grappe (D.Table.Reference);
               --  Envoie des données a la tache suivante.
               Donnee_A_Envoyer.all.Ecrire_Donnee_Entree (D);

               --  Autorise la tache suivante à lire.
               Autorisateur_Envoyee.all.Autoriser;

               exit Filtrage when D.Est_Derniere_Grappe;

            end;

         end loop Filtrage;

         --  Quand tout le travail est fini la tâche attend ici qu'elles
         --  aient toutes fini avant de considérer qu'elle est prête à
         --  chiffrer un autre fichier.
         Autorisation_Rearmement_Protegee.Attendre_Entree;

      end loop Repetition_Ou_Non;
   end Etage_Corps_Tache;

   ---------------------------------------------------------------------------
   task body Etage_Sortie_Tache is
      ---------------------------------------------------------
      procedure Filtrer_Grappe (T : in out Table_Bloc_T);
      procedure Filtrer_Grappe (T : in out Table_Bloc_T) is
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

            declare
               D : Donnee_T;
            begin
               --  Signal que les données ont été lue.
               Donnee_17.Lire_Donnee (D);
               --  Filtrage des données
               Filtrer_Grappe (D.Table.Reference);
               --  Envoie des données a la tache suivante.
               Donnee_Fin.Ecrire_Donnee_Entree (D);
               --  Autorise la tache suivante à lire.
               Autorisateur_Fin.Autoriser;

               exit Filtrage when D.Est_Derniere_Grappe;
            end;

         end loop Filtrage;

         --  Quand tout le travail est fini la tâche attend ici qu'elles
         --  aient toutes fini avant de considérer qu'elle est prête à
         --  chiffrer un autre fichier.
         Autorisation_Rearmement_Protegee.Attendre_Entree;

      end loop Repetition_Ou_Non;
   end Etage_Sortie_Tache;

   ---------------------------------------------------------------------------
   task body Etage_Ecriture_Tache is
      C_64 : C_Bloc_64_P.Constructeur_Bloc_64_T;
   begin
      Repetition_Ou_Non :
      loop

         --  On attend le signal de démarrage
         Demarreur_Protegee.Attendre_Entree;
         exit Repetition_Ou_Non when Avorter_Protegee.Avorter;

         Ecriture_Fichier :
         loop
            Autorisateur_Fin.Attendre_Entree;

            declare
               D : Donnee_T;
            begin
               Donnee_Fin.Lire_Donnee (D);
               for E of D.Table.Element loop
                  declare
                     --  Transformation du bloc en un brut
                     Brut : constant C_Bloc_64_P.Bloc_64_Brut_T
                        := C_64.Transformer_En_Brut (E);
                  begin
                     Ecriveur.all.Ecrire (Brut);
                  end;
               end loop;
               Limiteur_P.Limiteur_Protegee.Consommer_Bloc;

               exit Ecriture_Fichier when D.Est_Derniere_Grappe;
            end;

         end loop Ecriture_Fichier;

         --  Quand tout le travail est fini la tâche attend ici qu'elles
         --  aient toutes fini avant de considérer qu'elle est prête à
         --  chiffrer un autre fichier.
         Autorisation_Rearmement_Protegee.Attendre_Entree;

      end loop Repetition_Ou_Non;
   end Etage_Ecriture_Tache;

end Des_P.Chaine_P.Ravenscar_P;
