limited with Des_P.Clef_P.Clef_64_Abs_P;
with Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P;
with Des_P.Clef_P.Constructeur_48_Abs_P;

--  @summary
--  Le constructeur abstrait de clef de 56 bits.
--  @description
--  Construit une clef de 56 bits à partir d'une clef de 64 bits.
--  Cette clef sera composée de 56 bits provenant de
--  la clef de 64. Le constructeur va sélectionner ces bits
--  selon le tableau PC-1 du standard DES.
--  @group Clef Constructeur
package Des_P.Clef_P.Constructeur_56_Abs_P is

   --  Constructeur abstrait de clef de 56 bits.
   type Const_Clef_56_Abs_T is abstract tagged private;

   --  Prépare une nouvelle clef vide.
   --  @param Constructeur
   --  Le constructeur de la clef de 56.
   procedure Preparer_Nouvelle_Clef_56
      (Constructeur : in out Const_Clef_56_Abs_T)
   is abstract;

   --  Construit la clefs de 56 bits avec la clef de 64.
   --  @param Constructeur
   --  Le constructeur de la clef.
   --  @param Clef
   --  La clef à partir de laquelle on va construire la sous clef.
   procedure Construire_Clef_56
   (
      Constructeur : in out Const_Clef_56_Abs_T;
      Clef : Des_P.Clef_P.Clef_64_Abs_P.Clef_64_Abs_T'Class
   )
   is abstract;

   --  Permet d'ajouter le constructeur de clef 48 à la clef de 56
   --  en cours de construction.
   --  @param Constructeur
   --  Le constructeur de clef 56
   --  @param Constructeur_48
   --  Le constructeur de clef 48 à ajouter.
   procedure Construire_Ajouter_Constructeur_48
   (
      Constructeur : in out Const_Clef_56_Abs_T;
      Constructeur_48 :
         Des_P.Clef_P.Constructeur_48_Abs_P.Const_Clef_48_Abs_T'Class
   )
   is abstract;

   --  Permet de récupérer la clef de 56 terminée.
   --  @param Constructeur
   --  Le constructeur de la clef de 56.
   --  @return La clef de 56.
   function Recuperer_Clef_56
      (Constructeur : Const_Clef_56_Abs_T)
      return Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Clef_56_T
   is abstract;

private

   type Const_Clef_56_Abs_T is abstract tagged null record;

end Des_P.Clef_P.Constructeur_56_Abs_P;
