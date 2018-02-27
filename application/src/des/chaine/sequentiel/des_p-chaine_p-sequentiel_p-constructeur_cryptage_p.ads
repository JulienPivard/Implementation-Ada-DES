with Des_P.Clef_P.Clef_64_I_P;

--  @summary
--  Constructeur de chaine de filtres.
--  @description
--  Constructeur de chaine de filtres de cryptage.
--  @group Chaine Constructeur
package Des_P.Chaine_P.Sequentiel_P.Constructeur_Cryptage_P is

   type Constructeur_Cryptage_T is tagged private;
   --  Le constructeur de filtre de cryptage.

   procedure Initialiser
      (Constructeur : in out Constructeur_Cryptage_T);
   --  Initialise une nouvelle chaine vide.
   --  @param Constructeur
   --  Le constructeur de chaine

   procedure Construire
      (
         Constructeur : in out Constructeur_Cryptage_T;
         Clef : Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T'Class
      );
   --  Construit la chaine de filtre avec la clef.
   --  @param Constructeur
   --  Le constructeur de chaine
   --  @param Clef
   --  La clef de 64 bits.

   function Recuperer_Chaine
      (Constructeur : Constructeur_Cryptage_T)
      return Chaine_T;
   --  Récupère la chaine construite.
   --  @param Constructeur
   --  Le constructeur de chaine
   --  @return La chaine après construction

private

   type Constructeur_Cryptage_T is tagged
      record
         Chaine : Chaine_T;
      end record;

end Des_P.Chaine_P.Sequentiel_P.Constructeur_Cryptage_P;
