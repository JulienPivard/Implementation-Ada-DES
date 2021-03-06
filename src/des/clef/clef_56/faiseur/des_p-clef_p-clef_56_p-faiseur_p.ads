with Des_P.Clef_P.Clef_64_I_P;
with Des_P.Clef_P.Clef_56_I_P;
with Des_P.Clef_P.Clef_56_I_P.Faiseur_I_P;

--  @summary
--  Le constructeur concret de clef de 56 bits.
--  @description
--  Construit une clef de 56 à partir d'une clef de 64.
--  Cette clef sera composé de 56 bits provenant de la
--  clef de 64. Le constructeur va sélectionner ces bits
--  selon le tableau PC-1 du standard DES.
--  @group Clef Constructeur 56
package Des_P.Clef_P.Clef_56_P.Faiseur_P
   with Pure
is

   package Interface_R renames
      Des_P.Clef_P.Clef_56_I_P.Faiseur_I_P;

   type Faiseur_Clef_T is new
      Interface_R.Faiseur_Interface_T with private;
   --  Constructeur concret de clef de 56 bits.

   overriding
   procedure Preparer_Nouvelle_Clef
      (Constructeur : in out Faiseur_Clef_T);
   --  Prépare une nouvelle clef vide.
   --  @param Constructeur
   --  Le constructeur de la clef de 56.

   overriding
   procedure Construire_Clef
      (
         Constructeur : in out Faiseur_Clef_T;
         Clef         :        Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T'Class
      );
   --  Construit la clefs de 56 bits avec la clef de 64.
   --  @param Constructeur
   --  Le constructeur de la clef.
   --  @param Clef
   --  La clef à partir de laquelle on va construire la sous clef.

   overriding
   function Recuperer_Clef
      (Constructeur : Faiseur_Clef_T)
      return Des_P.Clef_P.Clef_56_I_P.Clef_Interface_T'Class;
   --  Permet de récupérer la clef de 56 terminée.
   --  @param Constructeur
   --  Le constructeur de la clef de 56.
   --  @return La clef de 56.

   function Recuperer_Clef
      (Constructeur : Faiseur_Clef_T)
      return Clef_T;
   --  Permet de récupérer la clef de 56 terminée.
   --  @param Constructeur
   --  Le constructeur de la clef de 56.
   --  @return La clef de 56.

private

   type Faiseur_Clef_T is new
      Interface_R.Faiseur_Interface_T with
      record
         Clef : Clef_T;
         --  La clef en cours de construction.
      end record;

end Des_P.Clef_P.Clef_56_P.Faiseur_P;
