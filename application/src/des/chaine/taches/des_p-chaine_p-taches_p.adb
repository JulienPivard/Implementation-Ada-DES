with Ada.Directories;
with Ada.Sequential_IO;

with Ada.Containers.Indefinite_Holders;

with Des_P.Bloc_P.Bloc_64_P;
with Des_P.Bloc_P.Bloc_64_P.Constructeur_P;

package body Des_P.Chaine_P.Taches_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Filtrer
      (
         Chaine : Chaine_T;
         Nom_Fichier : String;
         Extension : String
      )
   is
      package C_Bloc_64_P renames Des_P.Bloc_P.Bloc_64_P.Constructeur_P;
      package Lecteur_64_IO is new Ada.Sequential_IO
         (C_Bloc_64_P.Bloc_64_Brut_T);

      --  Les fichiers à lire et à écrire.
      Fichier : Lecteur_64_IO.File_Type;
      Resultat : Lecteur_64_IO.File_Type;

      --  (=v.v=)(=^.^=)(=o.o=)(=O.o=)(=o.O=)(=O.O=)(=$.$=)(=*.*=)  --
      procedure Lanceur_Taches;

      procedure Lanceur_Taches is

         --  Tableaux de bloc de 64 pour regrouper les données
         --  et augmenter la charge de travail par taches et améliorer
         --  les temps d'exécution
         type Indice_T is range 1 .. 512;
         type Table_Bloc_T is array (Indice_T range <>)
            of Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
         package Table_Holder_P is new
            Ada.Containers.Indefinite_Holders (Table_Bloc_T);

         --  (=v.v=)(=^.^=)(=o.o=)(=O.o=)(=o.O=)(=O.O=)(=$.$=)(=*.*=)  --
         task Etage_Ecriture is
            entry Ecrire
               (
                  Table : Table_Bloc_T
               );
         end Etage_Ecriture;

         task body Etage_Ecriture is
            T_Tmp : Table_Holder_P.Holder;
            C_64 : C_Bloc_64_P.Constructeur_Bloc_64_T;
            Occupe : Boolean := False;
         begin
            loop
               select
                  when not Occupe =>
                  accept Ecrire
                     (
                        Table : Table_Bloc_T
                     )
                  do
                     Occupe := True;
                     T_Tmp := Table_Holder_P.To_Holder (Table);
                  end Ecrire;
               or
                  terminate;
               end select;

               --  Parcours du tableau de blocs
               for E of T_Tmp.Element loop
                  --  Écrit le brut dans le fichier.
                  declare
                     Brut : constant C_Bloc_64_P.Bloc_64_Brut_T
                        := C_64.Transformer_En_Brut (E);
                  begin
                     Lecteur_64_IO.Write (Resultat, Brut);
                  end;
               end loop;
               Occupe := False;
            end loop;
         end Etage_Ecriture;
         --  (=v.v=)(=^.^=)(=o.o=)(=O.o=)(=o.O=)(=O.O=)(=$.$=)(=*.*=)  --

         --  (=v.v=)(=^.^=)(=o.o=)(=O.o=)(=o.O=)(=O.O=)(=$.$=)(=*.*=)  --
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

               declare
                  --  Le tableau doit pouvoir être modifié
                  --  donc copie dans une version modifiable.
                  T : Table_Bloc_T := T_Tmp.Element;
               begin
                  --  Parcours des blocs du tableau.
                  for E of T loop
                     --  Filtre le bloc avec le filtre de sortie.
                     F_Tmp.Element.Filtrer (E);
                  end loop;
                  --  Renvoie du bloc vers l'étage d'écriture.
                  Etage_Ecriture.Ecrire (T);
               end;
            end loop;
         end Etage_Sortie;
         --  (=v.v=)(=^.^=)(=o.o=)(=O.o=)(=o.O=)(=O.O=)(=$.$=)(=*.*=)  --

         --  (=v.v=)(=^.^=)(=o.o=)(=O.o=)(=o.O=)(=O.O=)(=$.$=)(=*.*=)  --
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
         Chaine_Corps : array (Numero_Filtre_T) of Etage_Corps;

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

               declare
                  --  Le tableau doit pouvoir être modifié
                  --  donc copie dans une version modifiable.
                  T : Table_Bloc_T := T_Tmp.Element;
               begin
                  --  Parcours des blocs du tableau.
                  for E of T loop
                     --  Filtrage du bloc
                     F_Tmp.Element.Filtrer (E);
                  end loop;
                  --  Si l'étage est le dernier on envoie vers la
                  --  tache de sortie et vers une tache de corps sinon.
                  if N_Tmp = Numero_Filtre_T'Last then
                     Etage_Sortie.Filtrer (T);
                  else
                     N_Tmp := Numero_Filtre_T'Succ (N_Tmp);
                     Chaine_Corps (N_Tmp).Filtrer (T, N_Tmp);
                  end if;
               end;
            end loop;
         end Etage_Corps;
         --  (=v.v=)(=^.^=)(=o.o=)(=O.o=)(=o.O=)(=O.O=)(=$.$=)(=*.*=)  --

         --  (=v.v=)(=^.^=)(=o.o=)(=O.o=)(=o.O=)(=O.O=)(=$.$=)(=*.*=)  --
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

               declare
                  --  Le tableau doit pouvoir être modifié
                  --  donc copie dans une version modifiable.
                  T : Table_Bloc_T := T_Tmp.Element;
               begin
                  --  Parcours des blocs du tableau.
                  for E of T loop
                     --  Filtre le bloc avec le filtre d'entrée.
                     F_Tmp.Element.Filtrer (E);
                  end loop;
                  --  Envoie le bloc vers la première tache de corps.
                  Chaine_Corps (Numero_Filtre_T'First).Filtrer
                     (T, Numero_Filtre_T'First);
               end;
            end loop;
         end Etage_Entree;
         --  (=v.v=)(=^.^=)(=o.o=)(=O.o=)(=o.O=)(=O.O=)(=$.$=)(=*.*=)  --

         C_64 : C_Bloc_64_P.Constructeur_Bloc_64_T;
         Brut : C_Bloc_64_P.Bloc_64_Brut_T;

         Table : Table_Bloc_T (Indice_T);
         J : Indice_T := Indice_T'First;

      begin
         --  Initialisation des taches avec le filtre
         Etage_Entree.Modifier_Filtre (Chaine.Filtre_Entree);
         for I in Numero_Filtre_T loop
            Chaine_Corps (I).Modifier_Filtre (Chaine.Filtres_Corps (I));
         end loop;
         Etage_Sortie.Modifier_Filtre (Chaine.Filtre_Sortie);

         --  Lancement de la lecture du fichier, filtrage et écriture dans
         --  le fichier alternatif.
         Lecture_Fichier :
         loop

            --  Remplissage du tableau de données avec contenu fichier
            Remplissage :
            for I in Indice_T loop
               exit Remplissage when Lecteur_64_IO.End_Of_File (Fichier);
               Lecteur_64_IO.Read (Fichier, Brut);
               --  Initialisation du bloc de 64
               C_64.Preparer_Nouveau_Bloc;
               C_64.Construire_Bloc (Brut);
               Table (I) := C_64.Recuperer_Bloc;
               J := I;
            end loop Remplissage;

            --  Lancement du filtrage.
            --  Si le tableau de blocs n'est pas plein on n'utilise pas
            --  entièrement le tableau mais seulement la sous partie utile.
            Etage_Entree.Filtrer (Table (Indice_T'First .. J));

            --  La fin du fichier à été atteinte.
            exit Lecture_Fichier when Lecteur_64_IO.End_Of_File (Fichier);

         end loop Lecture_Fichier;
      end Lanceur_Taches;
      --  (=v.v=)(=^.^=)(=o.o=)(=O.o=)(=o.O=)(=O.O=)(=$.$=)(=*.*=)  --

      Nom_Alternatif : constant String := Nom_Fichier & "." & Extension;
   begin
      --  Ouvre le fichier pour écrire si il existe et écrase le contenu
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

      Lanceur_Taches;

      Lecteur_64_IO.Close (Fichier);
      pragma Unreferenced (Fichier);
      Lecteur_64_IO.Close (Resultat);
      pragma Unreferenced (Resultat);
   end Filtrer;

end Des_P.Chaine_P.Taches_P;
