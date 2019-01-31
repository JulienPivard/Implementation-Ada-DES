with Des_P.Clef_P.Clef_56_I_P;
with Des_P.Clef_P.Clef_48_I_P;
with Des_P.Clef_P.Clef_48_I_P.Faiseur_I_P;

--  @summary
--  Le constructeur concret de clef de 48 bits.
--  @description
--  Construit une clef de 48 à partir d'une clef de 56.
--  Cette clef sera composé de 48 bits provenant de la
--  clef de 56. Le constructeur va sélectionner ces bits
--  selon le tableau PC-2 du standard DES.
--  @group Clef Constructeur
package Des_P.Clef_P.Clef_48_P.Faiseur_P
   with Pure
is

   package Interface_R renames
      Des_P.Clef_P.Clef_48_I_P.Faiseur_I_P;

   type Faiseur_Clef_T is new
      Interface_R.Faiseur_Interface_T with private;
   --  Constructeur concret de clef 48 bits.

   overriding
   procedure Preparer_Nouvelle_Clef
      (Constructeur : in out Faiseur_Clef_T)
      with Inline;
   --  Prépare une nouvelle sous clef vide.
   --  @param Constructeur
   --  Le constructeur de la sous clef.

   overriding
   procedure Construire_Clef
      (
         Constructeur   : in out Faiseur_Clef_T;
         Clef           : Des_P.Clef_P.Clef_56_I_P.Clef_Interface_T'Class
      );
   --  Construit la sous clefs de 48 bits avec la clef de 56.
   --  @param Constructeur
   --  Le constructeur de la sous clef.
   --  @param Clef
   --  La clef à partir de laquelle on va construire la sous clef.

   overriding
   function Recuperer_Clef
      (Constructeur : Faiseur_Clef_T)
      return Des_P.Clef_P.Clef_48_I_P.Clef_Interface_T'Class
      with Inline;
   --  Permet de récupérer la sous clefs terminée.
   --  @param Constructeur
   --  Le constructeur de la sous clef.
   --  @return La sous clef.

   function Recuperer_Clef
      (Constructeur : Faiseur_Clef_T)
      return Clef_T
      with Inline;
   --  Permet de récupérer la sous clefs terminée.
   --  @param Constructeur
   --  Le constructeur de la sous clef.
   --  @return La sous clef.

private

   type Faiseur_Clef_T is new
      Interface_R.Faiseur_Interface_T with
      record
         Clef : Clef_T;
      end record;

end Des_P.Clef_P.Clef_48_P.Faiseur_P;
