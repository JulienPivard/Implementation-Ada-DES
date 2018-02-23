with Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P;
limited with Des_P.Clef_P.Clef_56_Abs_P;

--  @summary
--  Le constructeur abstrait de clef de 48 bits.
--  @description
--  Construit une clef de 48 à partir d'une clef de 56.
--  Cette clef sera composé de 48 bits provenant de la
--  clef de 56. Le constructeur va sélectionner ces bits
--  selon le tableau PC-2 du standard DES.
--  @group Clef Constructeur
package Des_P.Clef_P.Constructeur_48_Abs_P is

   pragma Pure;

   --  Constructeur de la clef de 48 bits.
   type Const_Clef_48_Abs_T is abstract tagged private;

   --  Prépare une nouvelle sous clef vide.
   --  @param Constructeur
   --  Le constructeur de la clef de 48.
   procedure Preparer_Nouvelle_Clef_48
      (Constructeur : in out Const_Clef_48_Abs_T)
   is abstract;

   --  Construit la clefs de 48 bits avec la clef de 56.
   --  @param Constructeur
   --  Le constructeur de la clef.
   --  @param Clef
   --  La clef à partir de laquelle on va construire la sous clef.
   procedure Construire_Clef_48
   (
      Constructeur : in out Const_Clef_48_Abs_T;
      Clef : Des_P.Clef_P.Clef_56_Abs_P.Clef_56_Abs_T'Class
   )
   is abstract;

   --  Permet de récupérer la clef de 48 terminée.
   --  @param Constructeur
   --  Le constructeur de la clef de 48.
   --  @return La clef de 48.
   function Recuperer_Clef_48
      (Constructeur : Const_Clef_48_Abs_T)
      return Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Clef_48_T
   is abstract;

private

   type Const_Clef_48_Abs_T is abstract tagged null record;

end Des_P.Clef_P.Constructeur_48_Abs_P;
