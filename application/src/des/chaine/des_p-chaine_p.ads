with Des_P.Filtre_P.Fabrique_P;
with Des_P.Clef_P.Clef_64_Abs_P;

--  @summary
--  Interface de chaine de filtre.
--  @description
--  Permet de gérer la chaine de filtre par laquelle vont passer
--  tout les blocs de données du fichier pour être manipulé.
--  @group Chaine
package Des_P.Chaine_P is

   pragma Pure;

   --  L'interface de la chaine de filtre.
   type Chaine_Interface_T is interface;

   --  Initialise la chaine de filtre grâce à la fabrique fournie.
   --  @param Chaine
   --  La chaine de filtre.
   --  @param Fabrique
   --  La fabrique abstraite de filtre.
   --  @param Clef
   --  La clef de cryptage décryptage.
   procedure Initiliser
      (
         Chaine : in out Chaine_Interface_T;
         Fabrique : Des_P.Filtre_P.Fabrique_P.Fabrique_Interface_T'Class;
         Clef : Des_P.Clef_P.Clef_64_Abs_P.Clef_64_Abs_T'Class
      )
   is abstract;

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
         Chaine : Chaine_Interface_T;
         Nom_Fichier : String;
         Extension : String
      )
   is abstract;

end Des_P.Chaine_P;
