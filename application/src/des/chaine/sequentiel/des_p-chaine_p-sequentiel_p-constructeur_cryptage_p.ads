with Des_P.Clef_P.Clef_64_Abs_P;

package Des_P.Chaine_P.Sequentiel_P.Constructeur_Cryptage_P is

   type Constructeur_Cryptage_T is tagged private;

   procedure Initialiser
      (Constructeur : in out Constructeur_Cryptage_T);

   procedure Construire
      (
         Constructeur : in out Constructeur_Cryptage_T;
         Clef : Des_P.Clef_P.Clef_64_Abs_P.Clef_64_Abs_T'Class
      );

   function Recuperer_Chaine
      (Constructeur : Constructeur_Cryptage_T)
      return Chaine_T;

private

   type Constructeur_Cryptage_T is tagged
      record
         Chaine : Chaine_T;
      end record;

end Des_P.Chaine_P.Sequentiel_P.Constructeur_Cryptage_P;
