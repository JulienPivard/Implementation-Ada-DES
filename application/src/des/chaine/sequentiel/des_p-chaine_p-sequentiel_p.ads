private with Des_P.Clef_P.Clef_56_Abs_P.Holder_P;
private with Des_P.Etage_P.Filtrage_P;

--  @summary
--  Chaine de filtre séquentiel.
--  @description
--  Permet de gérer la chaine de filtre par laquelle vont passer
--  tout les blocs de données du fichier pour être manipulé.
--  @group Chaine
package Des_P.Chaine_P.Sequentiel_P is

   --  Une chaine de filtre séquentiel.
   type Chaine_T is new Chaine_Interface_T with private;

   overriding
   --  Initialise la chaine de filtre grâce à la fabrique fournie.
   --  @param Chaine
   --  La chaine de filtre.
   --  @param Fabrique
   --  La fabrique abstraite de filtre.
   --  @param Clef
   --  La clef de cryptage décryptage.
   procedure Initiliser
      (
         Chaine : in out Chaine_T;
         Fabrique : Des_P.Filtre_P.Fabrique_P.Fabrique_Interface_T'Class;
         Clef : Des_P.Clef_P.Clef_64_Abs_P.Clef_64_Abs_T'Class
      );

   overriding
   --  Lance le filtrage du fichier avec la clef. La version crypté ou
   --  décrypté est écrite dans un autre fichier avec l'extension crypt ou
   --  decrypt selon le filtrage effectué.
   --  @param Chaine
   --  La chaine de filtre.
   --  @param Nom_Fichier
   --  Le nom du fichier à crypter décrypter.
   --  @param Extension
   --  Extension du fichiers de sortie.
   procedure Filtrer
      (
         Chaine : Chaine_T;
         Nom_Fichier : String;
         Extension : String
      );

private

   type Chaine_T is new Chaine_Interface_T with
      record
         Clef : Des_P.Clef_P.Clef_56_Abs_P.Holder_P.Holder;
         Tete : Des_P.Etage_P.Filtrage_P.Etage_T;
      end record;

end Des_P.Chaine_P.Sequentiel_P;
