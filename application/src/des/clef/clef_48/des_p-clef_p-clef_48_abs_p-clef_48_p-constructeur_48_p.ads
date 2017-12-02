with Des_P.Clef_P.Constructeur_48_Abs_P;
with Des_P.Clef_P.Clef_56_Abs_P;

--  @summary
--  Le constructeur concret de clef de 48 bits.
--  @description
--  Construit une clef de 48 à partir d'une clef de 56.
--  Cette clef sera composé de 48 bits provenant de la
--  clef de 56. Le constructeur va sélectionner ces bits
--  selon le tableau PC-2 du standard DES.
--  @group Clef
package Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Constructeur_48_P is

   pragma Pure;

   --  Constructeur concret de clef 48 bits.
   type Constructeur_Clef_48_T is new
   Des_P.Clef_P.Constructeur_48_Abs_P.Constructeur_Clef_48_Abs_T with private;

   overriding
   --  Prépare une nouvelle sous clef vide.
   --  @param Constructeur
   --  Le constructeur de la sous clef.
   procedure Preparer_Nouvelle_Clef_48
      (Constructeur : in out Constructeur_Clef_48_T);

   overriding
   --  Construit la sous clefs de 48 bits avec la clef de 56.
   --  @param Constructeur
   --  Le constructeur de la sous clef.
   --  @param Clef
   --  La clef à partir de laquelle on va construire la sous clef.
   procedure Construire_Clef_48
   (
      Constructeur : in out Constructeur_Clef_48_T;
      Clef : Des_P.Clef_P.Clef_56_Abs_P.Clef_56_Abs_T'Class
   );

   overriding
   --  Permet de récupérer la sous clefs terminée.
   --  @param Constructeur
   --  Le constructeur de la sous clef.
   --  @return La sous clef.
   function Recuperer_Clef_48
      (Constructeur : Constructeur_Clef_48_T)
      return Clef_48_T;

private

   type Constructeur_Clef_48_T is new
      Des_P.Clef_P.Constructeur_48_Abs_P.Constructeur_Clef_48_Abs_T with
      record
         Clef_48 : Clef_48_T;
      end record;

end Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Constructeur_48_P;
