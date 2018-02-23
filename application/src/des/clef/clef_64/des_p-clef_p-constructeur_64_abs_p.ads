with Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P;
with Des_P.Clef_P.Constructeur_56_Abs_P;
with Des_P.Clef_P.Constructeur_48_Abs_P;

--  @summary
--  Le constructeur abstrait de clef de 64 bits.
--  @description
--  Construit une clef de 64 bits à partir d'un brut de 64 bits.
--  @group Clef Constructeur
package Des_P.Clef_P.Constructeur_64_Abs_P is

   --  Constructeur de clef abstraite de 64 bits.
   type Const_Clef_64_Abs_T is abstract tagged private;

   --  Le bloc de données brut que vas utiliser le constructeur
   --  pour construire la clef de 64 bits.
   type Clef_64_Brut_T is mod 2**64
      with Size => 64;

   --  Prépare une nouvelle clef vide.
   --  @param Constructeur
   --  Le constructeur de la clef de 64 bits.
   procedure Preparer_Nouvelle_Clef_64
      (Constructeur : in out Const_Clef_64_Abs_T)
   is abstract;

   --  Construit la clefs de 64 bits avec le brut de 64 bits.
   --  @param Constructeur
   --  Le constructeur de la clef.
   --  @param Brut
   --  Le brut à partir duquel on va construire la clef.
   procedure Construire_Clef_64
   (
      Constructeur : in out Const_Clef_64_Abs_T;
      Brut : Clef_64_Brut_T
   )
   is abstract;

   --  Ajoute un constructeur de clef 56 bits à la clef de 64.
   --  @param Constructeur
   --  Le constructeur de la clef.
   --  @param Constructeur_56
   --  Le constructeur de clef 56 bits.
   procedure Construire_Ajouter_Constructeur_56
   (
      Constructeur : in out Const_Clef_64_Abs_T;
      Constructeur_56 :
         Des_P.Clef_P.Constructeur_56_Abs_P.Const_Clef_56_Abs_T'Class
   )
   is abstract;

   --  Ajoute un constructeur de clef 48 bits à la clef de 64.
   --  @param Constructeur
   --  Le constructeur de la clef.
   --  @param Constructeur_48
   --  Le constructeur de clef 48 bits.
   procedure Construire_Ajouter_Constructeur_48
   (
      Constructeur : in out Const_Clef_64_Abs_T;
      Constructeur_48 :
         Des_P.Clef_P.Constructeur_48_Abs_P.Const_Clef_48_Abs_T'Class
   )
   is abstract;

   --  Permet de récupérer la clef de 64 terminée.
   --  @param Constructeur
   --  Le constructeur de la clef de 64.
   --  @return La clef de 64.
   function Recuperer_Clef_64
      (Constructeur : in out Const_Clef_64_Abs_T)
      return Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P.Clef_64_T
   is abstract;

private

   type Const_Clef_64_Abs_T is abstract tagged null record;

end Des_P.Clef_P.Constructeur_64_Abs_P;
