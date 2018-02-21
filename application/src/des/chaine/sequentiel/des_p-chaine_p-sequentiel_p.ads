private with Des_P.Clef_P.Clef_56_Abs_P.Holder_P;
private with Des_P.Etage_P.Filtrage_P;
private with Des_P.Bloc_P.Bloc_64_P.Constructeur_P;

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

   --  Execute le filtrage du fichier.
   --  @param Chaine
   --  La chaine de filtre.
   --  @param Brut
   --  Le bloc de bits brut.
   procedure Execution
      (
         Chaine : Chaine_T;
         Brut : in out Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T
      );

   type Chaine_T is new Chaine_Interface_T with
      record
         Clef : Des_P.Clef_P.Clef_56_Abs_P.Holder_P.Holder :=
            Des_P.Clef_P.Clef_56_Abs_P.Holder_P.Empty_Holder;
         Tete : Des_P.Etage_P.Filtrage_P.Etage_T;
      end record;

end Des_P.Chaine_P.Sequentiel_P;