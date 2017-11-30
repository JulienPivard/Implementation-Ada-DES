with Des_P.Clef_P;

--  @summary
--  Le constructeur de sous clef.
--  @description
--  Construit une sous clef à partir d'une clef. Cette sous clef sera
--  composé de 48 bits de la clef. Le constructeur va sélectionner
--  ces bits selon le tableau PC-2 du standard DES.
--  @group
package Des_P.Sous_Clef_P.Constructeur_P is

   pragma Pure;

   --  Constructeur de la sous clef de 48 bits.
   type Constructeur_Sous_Clef_T is tagged private;

   --  Prépare une nouvelle sous clef vide.
   --  @param Constructeur
   --  Le constructeur de la sous clef.
   procedure Preparer_Nouvelle_Sous_Clef
      (Constructeur : in out Constructeur_Sous_Clef_T);

   --  Construit la sous clefs de 48 bits avec la clef de 56.
   --  @param Constructeur
   --  Le constructeur de la sous clef.
   --  @param Clef
   --  La clef à partir de laquelle on va construire la sous clef.
   procedure Construire_Sous_Clef
      (
         Constructeur : in out Constructeur_Sous_Clef_T;
         Clef : Des_P.Clef_P.Clef_T
      );

   --  Permet de récupérer la sous clefs terminée.
   --  @param Constructeur
   --  Le constructeur de la sous clef.
   --  @return La sous clef.
   function Recuperer_Sous_Clef
      (Constructeur : Constructeur_Sous_Clef_T) return Sous_Clef_T;

private

   type Constructeur_Sous_Clef_T is tagged
      record
         Sous_Clef : Sous_Clef_T;
      end record;

end Des_P.Sous_Clef_P.Constructeur_P;
