private with Des_P.Filtre_P.Corps_P.Holder_P;
private with Des_P.Filtre_P.Entree_P.Holder_P;
private with Des_P.Filtre_P.Sortie_P.Holder_P;

--  @summary
--  Chaine de filtres parallèle.
--  @description
--  Permet de gérer la chaine de filtre par laquelle vont passer
--  tout les blocs de données du fichier pour être manipulé.
--  @group Chaine
package Des_P.Chaine_P.Ravenscar_P is

   type Chaine_T is new Chaine_Interface_T with private;
   --  La chaine de filtres parallèle.

   overriding
   procedure Filtrer
      (
         Chaine : Chaine_T;
         Nom_Fichier : String;
         Extension : String
      );
   --  Lance le filtrage du fichier avec la clef. La version crypté ou
   --  décrypté est écrite dans un autre fichier avec l'extension crypt ou
   --  decrypt selon le filtrage effectué.
   --  @param Chaine
   --  La chaine de filtre.
   --  @param Nom_Fichier
   --  Le nom du fichier à crypter décrypter.
   --  @param Extension
   --  Extension du fichiers de sortie.

private

   type Table_Filtre_T is array (Numero_Filtre_T) of
      Des_P.Filtre_P.Corps_P.Holder_P.Holder;

   type Chaine_T is new Chaine_Interface_T with
      record
         Filtre_Entree : Des_P.Filtre_P.Entree_P.Holder_P.Holder;
         Filtres_Corps : Table_Filtre_T;
         Filtre_Sortie : Des_P.Filtre_P.Sortie_P.Holder_P.Holder;
      end record;

end Des_P.Chaine_P.Ravenscar_P;
