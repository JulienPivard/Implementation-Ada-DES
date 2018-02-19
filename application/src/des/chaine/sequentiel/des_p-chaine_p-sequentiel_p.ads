private with Des_P.Clef_P.Clef_56_Abs_P.Holder_P;
private with Des_P.Etage_P.Filtrage_P;

package Des_P.Chaine_P.Sequentiel_P is

   type Chaine_T is new Chaine_Interface_T with private;

   overriding
   procedure Initiliser
      (
         Chaine : in out Chaine_T;
         Fabrique : Des_P.Filtre_P.Fabrique_P.Fabrique_Interface_T'Class;
         Clef : Des_P.Clef_P.Clef_64_Abs_P.Clef_64_Abs_T'Class
      );

   overriding
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
