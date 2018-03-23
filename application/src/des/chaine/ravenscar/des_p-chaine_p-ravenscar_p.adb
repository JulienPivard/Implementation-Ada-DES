with Ada.Directories;

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
      --  Ouverture du fichier à lire.
      Lecteur_Fichier_Protegee.Ouvrir_Fichier (Nom_Fichier);
      --  Ouverture du fichier à écrire.
      Ecriveur_Fichier_Protegee.Ouvrir_Fichier (Nom_Alternatif);

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
      Lecteur_Fichier_Protegee.Fermer_Fichier;
      --  Fermeture du fichier à écrire.
      Ecriveur_Fichier_Protegee.Fermer_Fichier;
      --  Vérification de la fermeture des fichiers.
      Lecteur_Fichier_Protegee.Attendre_Fermeture_Entree;
      Ecriveur_Fichier_Protegee.Attendre_Fermeture_Entree;
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
         Nb_Tache_Lancee := Natural'Succ (Nb_Tache_Lancee);
         --  Si toutes les taches ont été lancées on réarme
         --  démarreur pour une éventuel prochaine fois.
         if Nb_Tache_Lancee = 20 then
            Signal := False;
            Nb_Tache_Lancee := 0;
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
         Nb_Tache_Lancee := Natural'Succ (Nb_Tache_Lancee);
         --  Si toutes les taches ont été lancées on réarme
         --  démarreur pour une éventuel prochaine fois.
         if Nb_Tache_Lancee = 20 then
            Signal := False;
            Nb_Tache_Lancee := 0;
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
   protected body Ecriveur_Fichier_Protegee is
      ---------------------------------------------------------
      procedure Ouvrir_Fichier (Nom : String) is
      begin
         --  Ouvre le fichier pour écrire si il existe et écrase le contenu
         --  sinon il est créé.
         if Ada.Directories.Exists (Nom) then
            Lecteur_64_IO.Open
               (Resultat, Lecteur_64_IO.Out_File, Nom);
         else
            Lecteur_64_IO.Create
               (Resultat, Lecteur_64_IO.Out_File, Nom);
         end if;
         Est_Ferme := not Lecteur_64_IO.Is_Open (Resultat);
      end Ouvrir_Fichier;

      ---------------------------------------------------------
      procedure Ecrire
         (Brut : C_Bloc_64_P.Bloc_64_Brut_T)
      is
      begin
         Lecteur_64_IO.Write (Resultat, Brut);
      end Ecrire;

      ---------------------------------------------------------
      procedure Fermer_Fichier is
      begin
         Lecteur_64_IO.Close (Resultat);
         Est_Ferme := not Lecteur_64_IO.Is_Open (Resultat);
      end Fermer_Fichier;

      ---------------------------------------------------------
      entry Attendre_Fermeture_Entree when Est_Ferme is
      begin
         null;
      end Attendre_Fermeture_Entree;
      ---------------------------------------------------------
   end Ecriveur_Fichier_Protegee;

   ---------------------------------------------------------------------------
   protected body Lecteur_Fichier_Protegee is
      ---------------------------------------------------------
      procedure Ouvrir_Fichier (Nom : String) is
      begin
         Lecteur_64_IO.Open (Fichier, Lecteur_64_IO.In_File, Nom);
         Est_Ferme := not Lecteur_64_IO.Is_Open (Fichier);
      end Ouvrir_Fichier;

      ---------------------------------------------------------
      function Lire
         return C_Bloc_64_P.Bloc_64_Brut_T
      is
         Brut : C_Bloc_64_P.Bloc_64_Brut_T;
      begin
         Lecteur_64_IO.Read (Fichier, Brut);
         return Brut;
      end Lire;

      ---------------------------------------------------------
      function Est_Fini
         return Boolean
      is
      begin
         return Lecteur_64_IO.End_Of_File (Fichier);
      end Est_Fini;

      ---------------------------------------------------------
      procedure Fermer_Fichier is
      begin
         Lecteur_64_IO.Close (Fichier);
         Est_Ferme := not Lecteur_64_IO.Is_Open (Fichier);
      end Fermer_Fichier;

      ---------------------------------------------------------
      entry Attendre_Fermeture_Entree when Est_Ferme is
      begin
         null;
      end Attendre_Fermeture_Entree;
      ---------------------------------------------------------
   end Lecteur_Fichier_Protegee;

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
      entry Ecrire_Donnee_Entree (Table : Table_Bloc_T) when Signal is
      begin
         Donnee := Table_Holder_P.To_Holder (Table);
         Signal := False;
      end Ecrire_Donnee_Entree;

      ---------------------------------------------------------
      function Lire return Table_Bloc_T is
      begin
         return Donnee.Element;
      end Lire;

      ---------------------------------------------------------
      procedure Lu is
      begin
         Signal := True;
      end Lu;

      ---------------------------------------------------------
      function Est_Terminee return Boolean is
      begin
         return Fin;
      end Est_Terminee;

      ---------------------------------------------------------
      procedure Terminer is
      begin
         Fin := True;
      end Terminer;
      ---------------------------------------------------------
   end Donnee_Protegee;

   ---------------------------------------------------------------------------
   task body Etage_Lecteur_Tache is
      Table : Table_Bloc_T (Indice_T);
      C_64 : C_Bloc_64_P.Constructeur_Bloc_64_T;
      J : Indice_T;
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
               exit Remplissage when Lecteur_Fichier_Protegee.Est_Fini;
               --  Transformation du brut lu en un bloc.
               C_64.Preparer_Nouveau_Bloc;
               declare
                  Brut : constant C_Bloc_64_P.Bloc_64_Brut_T :=
                     Lecteur_Fichier_Protegee.Lire;
               begin
                  C_64.Construire_Bloc (Brut);
               end;
               Table (I) := C_64.Recuperer_Bloc;
               J := I;
            end loop Remplissage;

            --  Lancement du filtrage de la grappe de blocs.
            --  Si le tableau de blocs n'est pas plein on n'utilise pas
            --  entièrement le tableau mais seulement la sous partie utile.
            Donnee_Debut.Ecrire_Donnee_Entree (Table (Indice_T'First .. J));
            --  Si on a atteint la fin du fichier on envoie le
            --  signal de terminaison
            if Lecteur_Fichier_Protegee.Est_Fini then
               Donnee_Debut.Terminer;
            end if;
            --  Signal que la donnée à été bien écrite et peut être lue.
            Autorisateur_Debut.Autoriser;

            --  La fin du fichier à été atteinte.
            exit Lecture_Fichier when Lecteur_Fichier_Protegee.Est_Fini;
         end loop Lecture_Fichier;

         Autorisation_Rearmement_Protegee.Attendre_Entree;

      end loop Repetition_Ou_Non;
   end Etage_Lecteur_Tache;

   ---------------------------------------------------------------------------
   task body Etage_Entree_Tache is
   begin
      Repetition_Ou_Non :
      loop

         --  On attend le signal de démarrage
         Demarreur_Protegee.Attendre_Entree;
         exit Repetition_Ou_Non when Avorter_Protegee.Avorter;

         Filtre_Entree_Protegee.Attendre_Entree;
         declare
            Filtre : constant
            Des_P.Filtre_P.Entree_P.Entree_Abstrait_T'Class :=
               Filtre_Entree_Protegee.Lire_Filtre;
         begin
            Filtrage :
            loop
               --  En attente de l'autorisation de lire.
               Autorisateur_Debut.Attendre_Entree;

               declare
                  --  Lecture des données.
                  Table : Table_Bloc_T := Donnee_Debut.Lire;
               begin
                  --  Signal que les données ont été lue.
                  Donnee_Debut.Lu;
                  --  Filtrage des données
                  for E of Table loop
                     Filtre.Filtrer (E);
                  end loop;
                  --  Envoie des données a la tache suivante.
                  Donnee_01.Ecrire_Donnee_Entree (Table);
                  --  Si toutes les données ont été filtrée on signal
                  --  que le chiffrement est fini à la tache suivante.
                  if Donnee_Debut.Est_Terminee then
                     Donnee_01.Terminer;
                  end if;
                  --  Autorise la tache suivante à lire.
                  Autorisateur_01.Autoriser;
               end;

               exit Filtrage when Donnee_Debut.Est_Terminee;
            end loop Filtrage;
         end;

         Autorisation_Rearmement_Protegee.Attendre_Entree;

      end loop Repetition_Ou_Non;
   end Etage_Entree_Tache;

   ---------------------------------------------------------------------------
   task body Etage_Corps_Tache is
   begin
      Repetition_Ou_Non :
      loop

         --  On attend le signal de démarrage
         Demarreur_Protegee.Attendre_Entree;
         exit Repetition_Ou_Non when Avorter_Protegee.Avorter;

         Filtreur.all.Attendre_Entree;
         declare
            Filtre : constant
            Des_P.Filtre_P.Corps_P.Corps_Abstrait_T'Class :=
               Filtreur.all.Lire_Filtre;
         begin
            Filtrage :
            loop
               --  En attente de l'autorisation de lire.
               Autorisateur_Reception.all.Attendre_Entree;

               declare
                  --  Lecture des données.
                  Table : Table_Bloc_T := Donnee_Recue.all.Lire;
               begin
                  --  Signal que les données ont été lue.
                  Donnee_Recue.all.Lu;
                  --  Filtrage des données
                  for E of Table loop
                     Filtre.Filtrer (E);
                  end loop;
                  --  Envoie des données a la tache suivante.
                  Donnee_A_Envoyer.all.Ecrire_Donnee_Entree (Table);
                  --  Si toutes les données ont été filtrée on signal
                  --  que le chiffrement est fini à la tache suivante.
                  if Donnee_Recue.all.Est_Terminee then
                     Donnee_A_Envoyer.all.Terminer;
                  end if;
                  --  Autorise la tache suivante à lire.
                  Autorisateur_Envoyee.all.Autoriser;
               end;

               exit Filtrage when Donnee_Recue.all.Est_Terminee;
            end loop Filtrage;
         end;

         Autorisation_Rearmement_Protegee.Attendre_Entree;

      end loop Repetition_Ou_Non;
   end Etage_Corps_Tache;

   ---------------------------------------------------------------------------
   task body Etage_Sortie_Tache is
   begin
      Repetition_Ou_Non :
      loop

         --  On attend le signal de démarrage
         Demarreur_Protegee.Attendre_Entree;
         exit Repetition_Ou_Non when Avorter_Protegee.Avorter;

         Filtre_Sortie_Protegee.Attendre_Entree;
         declare
            Filtre : constant
            Des_P.Filtre_P.Sortie_P.Sortie_Abstrait_T'Class :=
               Filtre_Sortie_Protegee.Lire_Filtre;
         begin
            Filtrage :
            loop
               --  En attente de l'autorisation de lire.
               Autorisateur_17.Attendre_Entree;

               declare
                  --  Lecture des données.
                  Table : Table_Bloc_T := Donnee_17.Lire;
               begin
                  --  Signal que les données ont été lue.
                  Donnee_17.Lu;
                  --  Filtrage des données
                  for E of Table loop
                     Filtre.Filtrer (E);
                  end loop;
                  --  Envoie des données a la tache suivante.
                  Donnee_Fin.Ecrire_Donnee_Entree (Table);
                  --  Si toutes les données ont été filtrée on signal
                  --  que le chiffrement est fini à la tache suivante.
                  if Donnee_17.Est_Terminee then
                     Donnee_Fin.Terminer;
                  end if;
                  --  Autorise la tache suivante à lire.
                  Autorisateur_Fin.Autoriser;
               end;

               exit Filtrage when Donnee_17.Est_Terminee;
            end loop Filtrage;
         end;

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
               Table : constant Table_Bloc_T := Donnee_Fin.Lire;
            begin
               Donnee_Fin.Lu;
               for E of Table loop
                  declare
                     Brut : constant C_Bloc_64_P.Bloc_64_Brut_T
                        := C_64.Transformer_En_Brut (E);
                  begin
                     Ecriveur_Fichier_Protegee.Ecrire (Brut);
                  end;
               end loop;
            end;

            exit Ecriture_Fichier when Donnee_Fin.Est_Terminee;
         end loop Ecriture_Fichier;

         Autorisation_Rearmement_Protegee.Attendre_Entree;

      end loop Repetition_Ou_Non;
   end Etage_Ecriture_Tache;

end Des_P.Chaine_P.Ravenscar_P;
