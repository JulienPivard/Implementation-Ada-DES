with Des_P.Clef_P.Clef_64_Abs_P;

--  @summary
--  Constructeur de chaine de filtres.
--  @description
--  Constructeur de chaine de filtres de cryptage.
--  @group Chaine Constructeur
package Des_P.Chaine_P.Sequentiel_P.Constructeur_Cryptage_P is

   --  Le constructeur de filtre de cryptage.
   type Constructeur_Cryptage_T is tagged private;

   --  Initialise une nouvelle chaine vide.
   --  @param Constructeur
   --  Le constructeur de chaine
   procedure Initialiser
      (Constructeur : in out Constructeur_Cryptage_T);

   --  Construit la chaine de filtre avec la clef.
   --  @param Constructeur
   --  Le constructeur de chaine
   --  @param Clef
   --  La clef de 64 bits.
   procedure Construire
      (
         Constructeur : in out Constructeur_Cryptage_T;
         Clef : Des_P.Clef_P.Clef_64_Abs_P.Clef_64_Abs_T'Class
      );

   --  Récupère la chaine construite.
   --  @param Constructeur
   --  Le constructeur de chaine
   --  @return La chaine après construction
   function Recuperer_Chaine
      (Constructeur : Constructeur_Cryptage_T)
      return Chaine_T;

private

   type Constructeur_Cryptage_T is tagged
      record
         Chaine : Chaine_T;
      end record;

end Des_P.Chaine_P.Sequentiel_P.Constructeur_Cryptage_P;
