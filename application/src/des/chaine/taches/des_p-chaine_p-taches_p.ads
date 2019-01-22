private with Ada.Containers.Indefinite_Holders;

private with Des_P.Bloc_P.Bloc_64_P.Faiseur_P;

private with Des_P.Chaine_P.Lecteur_P;
private with Des_P.Chaine_P.Lecteur_P.Fichier_P;
private with Des_P.Chaine_P.Ecriveur_P;
private with Des_P.Chaine_P.Ecriveur_P.Fichier_P;

private with Des_P.Filtre_P.Corps_P.Holder_P;
private with Des_P.Filtre_P.Entree_P.Holder_P;
private with Des_P.Filtre_P.Sortie_P.Holder_P;

private with Des_P.Chaine_P.Limiteur_Jetons_P;

--  @summary
--  Chaine de filtres parallèle.
--  @description
--  Permet de gérer la chaine de filtre par laquelle vont passer
--  tout les blocs de données du fichier pour être manipulé.
--  @group Chaine
package Des_P.Chaine_P.Taches_P is

   type Chaine_T is new Chaine_Interface_T with private;
   --  La chaine de filtres parallèle.

   overriding
   procedure Filtrer
      (
         Chaine : Chaine_T;
         Nom_Fichier : String;
         Extension : String
      );
   --  Lance le filtrage du fichier avec la clef. La version chiffré ou
   --  déchiffré est écrite dans un autre fichier avec l'extension chiffre ou
   --  dechiffre selon le filtrage effectué.
   --  @param Chaine
   --  La chaine de filtre.
   --  @param Nom_Fichier
   --  Le nom du fichier à chiffrer déchiffrer.
   --  @param Extension
   --  Extension du fichiers de sortie.

private

   package C_Bloc_64_R renames Des_P.Bloc_P.Bloc_64_P.Faiseur_P;
   package Limiteur_R renames Des_P.Chaine_P.Limiteur_Jetons_P;

   type Table_Filtre_T is array (Numero_Filtre_T) of
      Des_P.Filtre_P.Corps_P.Holder_P.Holder;
   --  Contient tous les filtres principaux qui vont être utilisé
   --  par les tâches de chiffrement, dans l'ordre d'utilisation.

   package Lecteure_R renames Des_P.Chaine_P.Lecteur_P;
   package Ecriveur_R renames Des_P.Chaine_P.Ecriveur_P;

   Ecriveur_Fichier : aliased Ecriveur_P.Fichier_P.Ecriveur_Fichier_T;
   --  Un écriveur de fichier classique.

   Lecteur_Fichier  : aliased Lecteure_R.Fichier_P.Lecteur_Fichier_T;
   --  Un lecteur de fichier classique.

   Ecriveur : Ecriveur_P.Ecriveur_A := Ecriveur_Fichier'Access;
   --  L'écriveur de donnée effectif peut être changé
   --  par le biais de cette variable.

   Lecteur  : Lecteure_R.Lecteur_A  := Lecteur_Fichier'Access;
   --  Le lecteur de donnée effectif peut être changé
   --  par le biais de cette variable.

   type Chaine_T is new Chaine_Interface_T with
      record
         Filtre_Entree : Des_P.Filtre_P.Entree_P.Holder_P.Holder;
         Filtres_Corps : Table_Filtre_T;
         Filtre_Sortie : Des_P.Filtre_P.Sortie_P.Holder_P.Holder;
         Max_Grappes : Limiteur_R.Max_Grappes_T :=
            Limiteur_R.Max_Grappes_T'First;
         Modifier_Max_Grappes : Boolean := False;
      end record;

      type Indice_T is range 1 .. 512;
      --  Les indices des table de blocs.
      type Table_Bloc_T is array (Indice_T range <>)
         of Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
      --  Tableaux de bloc de 64 pour regrouper les données
      --  et augmenter la charge de travail par taches et ainsi
      --  améliorer les temps d'exécution

      package Table_Holder_P is new
         Ada.Containers.Indefinite_Holders (Element_Type => Table_Bloc_T);

end Des_P.Chaine_P.Taches_P;
