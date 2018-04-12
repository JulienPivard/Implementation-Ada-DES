private with Des_P.Chaine_P.Accee_Fichier_P;
private with Des_P.Bloc_P.Bloc_64_P.Faiseur_P;

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

   package C_Bloc_64_P renames Des_P.Bloc_P.Bloc_64_P.Faiseur_P;
   package Limiteur_P renames Des_P.Chaine_P.Limiteur_Jetons_P;

   type Table_Filtre_T is array (Numero_Filtre_T) of
      Des_P.Filtre_P.Corps_P.Holder_P.Holder;
   --  Contient tous les filtres principaux qui vont être utilisé
   --  par les tâches de chiffrement, dans l'ordre d'utilisation.

   package Accee_P renames Des_P.Chaine_P.Accee_Fichier_P;

   Ecriveur : access Accee_P.Ecriveur_Protegee_T'Class;
   --  L'écriveur de donnée effectif peut être changé
   --  par le biais de cette variable.

   Lecteur : access Accee_P.Lecteur_Protegee_T'Class;
   --  Le lecteur de donnée effectif peut être changé
   --  par le biais de cette variable.

   Ecriveur_Fichier : aliased Accee_P.Ecriveur_Fichier_Protegee;
   --  Un écriveur de fichier classique.

   Lecteur_Fichier : aliased Accee_P.Lecteur_Fichier_Protegee;
   --  Un lecteur de fichier classique.

   type Chaine_T is new Chaine_Interface_T with
      record
         Filtre_Entree : Des_P.Filtre_P.Entree_P.Holder_P.Holder;
         Filtres_Corps : Table_Filtre_T;
         Filtre_Sortie : Des_P.Filtre_P.Sortie_P.Holder_P.Holder;
         Max_Grappes : Limiteur_P.Max_Grappes_T :=
            Limiteur_P.Max_Grappes_T'First;
         Modifier_Max_Grappes : Boolean := False;
      end record;

end Des_P.Chaine_P.Taches_P;
