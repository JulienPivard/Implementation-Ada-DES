with Des_P.Bloc_P.Bloc_64_P;

package body Des_P.Chaine_P.Taches_P is

   ---------------------------------------------------------------------------
   procedure Lanceur_Taches (Chaine : Chaine_T);

   procedure Lanceur_Taches (Chaine : Chaine_T) is

      ------------------------------------------------------------------

      task Etage_Ecriture is
         entry Ecrire
            (
               Table : Table_Bloc_T
            );
      end Etage_Ecriture;

      task body Etage_Ecriture is
         T_Tmp : Table_Holder_P.Holder;
         C_64 : C_Bloc_64_R.Faiseur_Bloc_T;
      begin
         Selection_Action_Estage :
         loop
            select
               accept Ecrire
                  (
                     Table : Table_Bloc_T
                  )
               do
                  T_Tmp := Table_Holder_P.To_Holder (Table);
               end Ecrire;
               --  Parcours du tableau de blocs
               Parcours_Tableau :
               for E of T_Tmp.Element loop
                  --  Écrit le brut dans le fichier.
                  Ecrire_Donnee_Sortie :
                  declare
                     Brut : constant C_Bloc_64_R.Bloc_64_Brut_T
                        := C_64.Transformer_En_Brut (E);
                  begin
                     Ecriveur.all.Ecrire (Brut);
                  end Ecrire_Donnee_Sortie;
               end loop Parcours_Tableau;
               Limiteur_R.Limiteur_Protegee.Consommer_Bloc;
            or
               terminate;
            end select;
         end loop Selection_Action_Estage;
      end Etage_Ecriture;

      ------------------------------------------------------------------

      task Etage_Sortie is
         entry Modifier_Filtre
            (
               Filtre : Des_P.Filtre_P.Sortie_P.Holder_P.Holder
            );
         entry Filtrer
            (
               Table : Table_Bloc_T
            );
      end Etage_Sortie;

      task body Etage_Sortie is
         T_Tmp : Table_Holder_P.Holder;
         F_Tmp : Des_P.Filtre_P.Sortie_P.Holder_P.Holder;
      begin
         accept Modifier_Filtre
            (
               Filtre : Des_P.Filtre_P.Sortie_P.Holder_P.Holder
            )
         do
            F_Tmp := Filtre;
         end Modifier_Filtre;
         Selection_Action_Estage :
         loop
            select
               accept Filtrer
                  (
                     Table : Table_Bloc_T
                  )
               do
                  T_Tmp := Table_Holder_P.To_Holder (Table);
               end Filtrer;
            or
               terminate;
            end select;

            Ecrire_Donnee_Sortie :
            declare
               --  Le tableau doit pouvoir être modifié
               --  donc copie dans une version modifiable.
               T : Table_Bloc_T := T_Tmp.Element;
            begin
               --  Parcours des blocs du tableau.
               Parcours_Blocs :
               for E of T loop
                  --  Filtre le bloc avec le filtre de sortie.
                  F_Tmp.Element.Filtrer (E);
               end loop Parcours_Blocs;
               --  Renvoie du bloc vers l'étage d'écriture.
               Etage_Ecriture.Ecrire (T);
            end Ecrire_Donnee_Sortie;
         end loop Selection_Action_Estage;
      end Etage_Sortie;

      ------------------------------------------------------------------

      task type Etage_Corps is
         entry Modifier_Filtre
            (
               Filtre : Des_P.Filtre_P.Corps_P.Holder_P.Holder
            );
         entry Filtrer
            (
               Table : Table_Bloc_T;
               Numero : Numero_Filtre_T
            );
      end Etage_Corps;

      --  La chaine de corps de filtre.
      type Chaine_Corps_T is array (Numero_Filtre_T) of Etage_Corps_T;
      Chaine_Corps : Chaine_Corps_T;

      task body Etage_Corps is
         T_Tmp : Table_Holder_P.Holder;
         N_Tmp : Numero_Filtre_T;
         F_Tmp : Des_P.Filtre_P.Corps_P.Holder_P.Holder;
      begin
         accept Modifier_Filtre
            (
               Filtre : Des_P.Filtre_P.Corps_P.Holder_P.Holder
            )
         do
            F_Tmp := Filtre;
         end Modifier_Filtre;
         Selection_Action_Estage :
         loop
            select
               accept Filtrer
                  (
                     Table : Table_Bloc_T;
                     Numero : Numero_Filtre_T
                  )
               do
                  T_Tmp := Table_Holder_P.To_Holder (Table);
                  N_Tmp := Numero;
               end Filtrer;
            or
               terminate;
            end select;

            Filtrage_Des_Donnees :
            declare
               --  Le tableau doit pouvoir être modifié
               --  donc copie dans une version modifiable.
               T : Table_Bloc_T := T_Tmp.Element;
            begin
               --  Parcours des blocs du tableau.
               Parcours_Blocs :
               for E of T loop
                  --  Filtrage du bloc
                  F_Tmp.Element.Filtrer (E);
               end loop Parcours_Blocs;
               --  Si l'étage est le dernier on envoie vers la
               --  tache de sortie et vers une tache de corps sinon.
               if N_Tmp = Numero_Filtre_T'Last then
                  Etage_Sortie.Filtrer (T);
               else
                  N_Tmp := Numero_Filtre_T'Succ (N_Tmp);
                  Chaine_Corps (N_Tmp).Filtrer (T, N_Tmp);
               end if;
            end Filtrage_Des_Donnees;
         end loop Selection_Action_Estage;
      end Etage_Corps;

      ------------------------------------------------------------------

      task Etage_Entree is
         entry Modifier_Filtre
            (
               Filtre : Des_P.Filtre_P.Entree_P.Holder_P.Holder
            );
         entry Filtrer
            (
               Table : Table_Bloc_T
            );
      end Etage_Entree;

      task body Etage_Entree is
         T_Tmp : Table_Holder_P.Holder;
         F_Tmp : Des_P.Filtre_P.Entree_P.Holder_P.Holder;
      begin
         accept Modifier_Filtre
            (
               Filtre : Des_P.Filtre_P.Entree_P.Holder_P.Holder
            )
         do
            F_Tmp := Filtre;
         end Modifier_Filtre;
         Selection_Action_Estage :
         loop
            select
               accept Filtrer
                  (
                     Table : Table_Bloc_T
                  )
               do
                  T_Tmp := Table_Holder_P.To_Holder (Table);
               end Filtrer;
            or
               terminate;
            end select;

            Lecture_Des_Donnees :
            declare
               --  Le tableau doit pouvoir être modifié
               --  donc copie dans une version modifiable.
               T : Table_Bloc_T := T_Tmp.Element;
            begin
               --  Parcours des blocs du tableau.
               Parcours_Blocs :
               for E of T loop
                  --  Filtre le bloc avec le filtre d'entrée.
                  F_Tmp.Element.Filtrer (E);
               end loop Parcours_Blocs;
               --  Envoie le bloc vers la première tache de corps.
               Chaine_Corps (Numero_Filtre_T'First).Filtrer
                  (T, Numero_Filtre_T'First);
            end Lecture_Des_Donnees;
         end loop Selection_Action_Estage;
      end Etage_Entree;

      ------------------------------------------------------------------

      task Etage_Lecture is
         entry Lire;
      end Etage_Lecture;

      task body Etage_Lecture is
         C_64 : C_Bloc_64_R.Faiseur_Bloc_T;
         J : Indice_T;
      begin
         accept Lire;
         --  Lancement de la lecture du fichier, filtrage et écriture dans
         --  le fichier alternatif.
         Lecture_Fichier :
         loop

            Limiteur_R.Limiteur_Protegee.Generer_Bloc_Entree;

            J := Indice_T'First;
            --  Remplissage du tableau de données avec contenu fichier
            Creation_Grappe :
            declare
               subtype Table_Tmp_T is Table_Bloc_T (Indice_T);
               Table : Table_Tmp_T;
            begin
               Remplissage :
               for I in Indice_T loop
                  exit Remplissage when Lecteur.all.Est_Fini;
                  Lecture_D_Une_Donnee :
                  declare
                     Brut : C_Bloc_64_R.Bloc_64_Brut_T;
                  begin
                     Lecteur.all.Lire (Brut);
                     --  Initialisation du bloc de 64
                     C_64.Preparer_Nouveau_Bloc;
                     C_64.Construire_Bloc (Brut);
                  end Lecture_D_Une_Donnee;
                  Table (I) := C_64.Recuperer_Bloc;
                  J := I;
               end loop Remplissage;

               --  Lancement du filtrage.
               --  Si le tableau de blocs n'est pas plein on
               --  n'utilise pas entièrement le tableau mais seulement
               --  la sous partie utile.
               Filtrage :
               declare
                  subtype Indice_Tmp_T is Indice_T range Indice_T'First .. J;
               begin
                  Etage_Entree.Filtrer (Table (Indice_Tmp_T));
               end Filtrage;
            end Creation_Grappe;

            --  La fin du fichier à été atteinte.
            exit Lecture_Fichier when Lecteur.all.Est_Fini;

         end loop Lecture_Fichier;
      end Etage_Lecture;

      ------------------------------------------------------------------

   begin

      --  Si le nombre maximum de grappe à été modifié.
      if Chaine.Modifier_Max_Grappes then
         Limiteur_R.Limiteur_Protegee.Modifier_Nb_Max_Blocs
            (Chaine.Max_Grappes);
      end if;
      --  Initialisation des taches avec le filtre
      Etage_Entree.Modifier_Filtre (Chaine.Filtre_Entree);
      for I in Numero_Filtre_T loop
         Chaine_Corps (I).Modifier_Filtre (Chaine.Filtres_Corps (I));
      end loop;
      Etage_Sortie.Modifier_Filtre (Chaine.Filtre_Sortie);

      Etage_Lecture.Lire;

   end Lanceur_Taches;

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
      --  Ouvre le fichier pour écrire si il existe et écrase le contenu
      --  sinon il est créé.
      Ecriveur.all.Ouvrir_Fichier (Nom_Alternatif);
      --  Ouverture du fichier à lire.
      Lecteur.all.Ouvrir_Fichier (Nom_Fichier);

      Lanceur_Taches (Chaine);

      Lecteur.all.Fermer_Fichier;
      Ecriveur.all.Fermer_Fichier;
   end Filtrer;

end Des_P.Chaine_P.Taches_P;
