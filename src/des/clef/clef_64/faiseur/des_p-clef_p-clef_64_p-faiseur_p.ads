with Des_P.Clef_P.Clef_64_I_P;
with Des_P.Clef_P.Clef_64_I_P.Faiseur_I_P;

--  @summary
--  Le constructeur concret de clef de 64 bits.
--  @description
--  Construit une clef de 64 bits à partir d'un brut de 64 bits.
--  @group Clef Constructeur 64
package Des_P.Clef_P.Clef_64_P.Faiseur_P
   with Pure
is

   package Interface_R renames
      Des_P.Clef_P.Clef_64_I_P.Faiseur_I_P;

   type Faiseur_Clef_T is new
      Interface_R.Faiseur_Interface_T with private;
   --  Constructeur concret de clef de 64 bits.

   overriding
   procedure Preparer_Nouvelle_Clef
      (Constructeur : in out Faiseur_Clef_T)
      with Inline;
   --  Prépare une nouvelle clef vide.
   --  @param Constructeur
   --  Le constructeur de la clef de 64 bits.

   overriding
   procedure Construire_Clef
      (
         Constructeur   : in out Faiseur_Clef_T;
         Brut           : Interface_R.Clef_64_Brut_T
      );
   --  Construit la clefs de 64 bits avec le brut de 64 bits.
   --  @param Constructeur
   --  Le constructeur de la clef.
   --  @param Brut
   --  Le brut à partir duquel on va construire la clef.

   overriding
   function Recuperer_Clef
      (Constructeur : Faiseur_Clef_T)
      return Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T'Class
      with Inline;
   --  Permet de récupérer la clef de 64 terminée.
   --  @param Constructeur
   --  Le constructeur de la clef de 64.
   --  @return La clef de 64.

   function Recuperer_Clef
      (Constructeur : Faiseur_Clef_T)
      return Clef_T
      with Inline;
   --  Permet de récupérer la clef de 64 terminée.
   --  @param Constructeur
   --  Le constructeur de la clef de 64.
   --  @return La clef de 64.

private

   type Faiseur_Clef_T is new
      Interface_R.Faiseur_Interface_T with
      record
         Clef : Clef_T;
      end record;

end Des_P.Clef_P.Clef_64_P.Faiseur_P;
