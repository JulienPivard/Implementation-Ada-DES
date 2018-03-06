with Des_P.Clef_P.Clef_64_I_P;
with Des_P.Clef_P.Clef_64_I_P.Constructeur_I_P;

--  @summary
--  Le constructeur concret de clef de 64 bits.
--  @description
--  Construit une clef de 64 bits à partir d'un brut de 64 bits.
--  @group Clef Constructeur
package Des_P.Clef_P.Clef_64_P.Constructeur_P is

   pragma Pure;

   package Interface_P renames
      Des_P.Clef_P.Clef_64_I_P.Constructeur_I_P;

   type Constructeur_Clef_T is new
      Interface_P.Constructeur_Interface_T with private;
   --  Constructeur concret de clef de 64 bits.

   overriding
   procedure Preparer_Nouvelle_Clef
      (Constructeur : in out Constructeur_Clef_T);
   --  Prépare une nouvelle clef vide.
   --  @param Constructeur
   --  Le constructeur de la clef de 64 bits.

   overriding
   procedure Construire_Clef
      (
         Constructeur : in out Constructeur_Clef_T;
         Brut : Interface_P.Clef_64_Brut_T
      );
   --  Construit la clefs de 64 bits avec le brut de 64 bits.
   --  @param Constructeur
   --  Le constructeur de la clef.
   --  @param Brut
   --  Le brut à partir duquel on va construire la clef.

   overriding
   function Recuperer_Clef
      (Constructeur : Constructeur_Clef_T)
      return Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T'Class;
   --  Permet de récupérer la clef de 64 terminée.
   --  @param Constructeur
   --  Le constructeur de la clef de 64.
   --  @return La clef de 64.

   function Recuperer_Clef
      (Constructeur : Constructeur_Clef_T)
      return Clef_T;
   --  Permet de récupérer la clef de 64 terminée.
   --  @param Constructeur
   --  Le constructeur de la clef de 64.
   --  @return La clef de 64.

private

   type Constructeur_Clef_T is new
      Interface_P.Constructeur_Interface_T with
      record
         Clef : Clef_T;
      end record;

end Des_P.Clef_P.Clef_64_P.Constructeur_P;
