with Des_P.Clef_P.Clef_64_I_P;
with Des_P.Clef_P.Clef_56_I_P;
with Des_P.Clef_P.Clef_56_I_P.Constructeur_I_P;

--  @summary
--  Le constructeur concret de clef de 56 bits.
--  @description
--  Construit une clef de 56 à partir d'une clef de 64.
--  Cette clef sera composé de 56 bits provenant de la
--  clef de 64. Le constructeur va sélectionner ces bits
--  selon le tableau PC-1 du standard DES.
--  @group Clef Constructeur
package Des_P.Clef_P.Clef_56_P.Constructeur_P is

   pragma Pure;

   package Interface_P renames
      Des_P.Clef_P.Clef_56_I_P.Constructeur_I_P;

   type Constructeur_Clef_T is new
      Interface_P.Constructeur_Interface_T with private;
   --  Constructeur concret de clef de 56 bits.

   overriding
   procedure Preparer_Nouvelle_Clef
      (Constructeur : in out Constructeur_Clef_T);
   --  Prépare une nouvelle clef vide.
   --  @param Constructeur
   --  Le constructeur de la clef de 56.

   overriding
   procedure Construire_Clef
      (
         Constructeur : in out Constructeur_Clef_T;
         Clef : Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T'Class
      );
   --  Construit la clefs de 56 bits avec la clef de 64.
   --  @param Constructeur
   --  Le constructeur de la clef.
   --  @param Clef
   --  La clef à partir de laquelle on va construire la sous clef.

   overriding
   function Recuperer_Clef
      (Constructeur : Constructeur_Clef_T)
      return Des_P.Clef_P.Clef_56_I_P.Clef_Interface_T'Class;
   --  Permet de récupérer la clef de 56 terminée.
   --  @param Constructeur
   --  Le constructeur de la clef de 56.
   --  @return La clef de 56.

   function Recuperer_Clef
      (Constructeur : Constructeur_Clef_T)
      return Clef_T;
   --  Permet de récupérer la clef de 56 terminée.
   --  @param Constructeur
   --  Le constructeur de la clef de 56.
   --  @return La clef de 56.

private

   type Constructeur_Clef_T is new
      Interface_P.Constructeur_Interface_T with
      record
         Clef : Clef_T;
      end record;

end Des_P.Clef_P.Clef_56_P.Constructeur_P;
