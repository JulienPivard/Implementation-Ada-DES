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

private with Des_P.Chaine_P.Instances_Table_Bloc_P;

--  @summary
--  Chaine de filtres parallèle.
--  @description
--  Permet de gérer la chaine de filtre par laquelle vont passer
--  tout les blocs de données du fichier pour être manipulé.
--  @group Chaine
package Des_P.Chaine_P.Tasches_P
   with Elaborate_Body
is

   type Chaine_T is new Chaine_Interface_T with private;
   --  La chaine de filtres parallèle.

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

   package C_Bloc_64_R  renames Des_P.Bloc_P.Bloc_64_P.Faiseur_P;
   package Limiteur_R   renames Des_P.Chaine_P.Limiteur_Jetons_P;
   package Table_Bloc_R renames Instances_Table_Bloc_P.Table_Bloc_Taches_P;

   use type Table_Bloc_R.Table_Bloc_T;
   use type Table_Bloc_R.Indice_T;

   subtype Indice_T     is Table_Bloc_R.Indice_T;
   subtype Table_Bloc_T is Table_Bloc_R.Table_Bloc_T;

   package Table_Holder_P is new
      Ada.Containers.Indefinite_Holders
         (Element_Type => Table_Bloc_R.Table_Bloc_T);
   --  @private
   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate

   type Table_Filtre_T is array (Numero_Filtre_T) of
      Des_P.Filtre_P.Corps_P.Holder_P.Holder;
   --  Contient tous les filtres principaux qui vont être utilisé
   --  par les tâches de chiffrement, dans l'ordre d'utilisation.

   package Lecteure_R renames Des_P.Chaine_P.Lecteur_P;
   package Ecriveur_R renames Des_P.Chaine_P.Ecriveur_P;

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   Ecriveur_Fichier : aliased Ecriveur_P.Fichier_P.Ecriveur_Fichier_T;
   --  Un écriveur de fichier classique.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   Lecteur_Fichier  : aliased Lecteure_R.Fichier_P.Lecteur_Fichier_T;
   --  Un lecteur de fichier classique.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   Ecriveur : Ecriveur_P.Ecriveur_A := Ecriveur_Fichier'Access;
   --  L'écriveur de donnée effectif peut être changé
   --  par le biais de cette variable.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   Lecteur  : Lecteure_R.Lecteur_A  := Lecteur_Fichier'Access;
   --  Le lecteur de donnée effectif peut être changé
   --  par le biais de cette variable.

   type Chaine_T is new Chaine_Interface_T with
      record
         Filtre_Entree : Des_P.Filtre_P.Entree_P.Holder_P.Holder;
         --  Le premier filtre dans lequel vont passer les blocs.
         Filtres_Corps : Table_Filtre_T;
         --  Un tableau des filtres suivant le schémas de feistel.
         Filtre_Sortie : Des_P.Filtre_P.Sortie_P.Holder_P.Holder;
         --  Le dernier filtre dans lequel vont passer les blocs
         --  avant d'être écrit dans le fichier de sortie.
         Max_Grappes   : Limiteur_R.Max_Grappes_T :=
            Limiteur_R.Max_Grappes_T'First;
         --  Le nombre maximum de grappes de blocs en même temps dans
         --  le pipeline.
         Modifier_Max_Grappes : Boolean := False;
         --  On souhaite que la modification du nombre de
         --  grappes soit prise en compte par la chaine.
      end record;

end Des_P.Chaine_P.Tasches_P;
