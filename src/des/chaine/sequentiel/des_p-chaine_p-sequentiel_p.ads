private with Des_P.Etage_P.Filtrage_P;
private with Des_P.Bloc_P.Bloc_64_P.Faiseur_P;

private with Des_P.Chaine_P.Lecteur_P;
private with Des_P.Chaine_P.Lecteur_P.Fichier_P;
private with Des_P.Chaine_P.Ecriveur_P;
private with Des_P.Chaine_P.Ecriveur_P.Fichier_P;

--  @summary
--  Chaine de filtres séquentiel.
--  @description
--  Permet de gérer la chaine de filtre par laquelle vont passer
--  tout les blocs de données du fichier pour être manipulé.
--  @group Chaine
package Des_P.Chaine_P.Sequentiel_P
   with Elaborate_Body
is

   type Chaine_T is new Chaine_Interface_T with private;
   --  Une chaine de filtre séquentiel.

   overriding
   procedure Filtrer
      (
         Chaine      : Chaine_T;
         Nom_Fichier : String;
         Extension   : String
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

   procedure Execution
      (
         Chaine   :        Chaine_T;
         Brut     : in out Des_P.Bloc_P.Bloc_64_P.Faiseur_P.Bloc_64_Brut_T
      );
   --  Execute le filtrage du fichier.
   --  @param Chaine
   --  La chaine de filtre.
   --  @param Brut
   --  Le bloc de bits brut.

   type Chaine_T is new Chaine_Interface_T with
      record
         Tete : Des_P.Etage_P.Filtrage_P.Etage_T;
         --  Le premier étage de la chaine de filtres.
      end record;

   package Lecteure_R renames Des_P.Chaine_P.Lecteur_P;
   package Ecriveur_R renames Des_P.Chaine_P.Ecriveur_P;

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   Ecriveur_Fichier : aliased Ecriveur_R.Fichier_P.Ecriveur_Fichier_T;
   --  Un écriveur de fichier classique.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   Lecteur_Fichier  : aliased Lecteure_R.Fichier_P.Lecteur_Fichier_T;
   --  Un lecteur de fichier classique.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   Ecriveur : Ecriveur_R.Ecriveur_A := Ecriveur_Fichier'Access;
   --  L'écriveur de donnée effectif peut être changé
   --  par le biais de cette variable.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   Lecteur  : Lecteure_R.Lecteur_A  := Lecteur_Fichier'Access;
   --  Le lecteur de donnée effectif peut être changé
   --  par le biais de cette variable.

end Des_P.Chaine_P.Sequentiel_P;
