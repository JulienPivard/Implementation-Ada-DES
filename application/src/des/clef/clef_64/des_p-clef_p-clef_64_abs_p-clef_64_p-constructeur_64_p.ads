with Des_P.Clef_P.Constructeur_64_Abs_P;

--  @summary
--  Le constructeur concret de clef de 64 bits.
--  @description
--  Construit une clef de 64 bits à partir d'un brut de 64 bits.
--  @group Clef
package Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P.Constructeur_64_P is

   pragma Pure;
   use Des_P.Clef_P.Constructeur_64_Abs_P;

   --  Constructeur concret de clef de 64 bits.
   type Constructeur_Clef_64_T is new Constructeur_Clef_64_Abs_T with private;

   overriding
   --  Prépare une nouvelle clef vide.
   --  @param Constructeur
   --  Le constructeur de la clef de 64 bits.
   procedure Preparer_Nouvelle_Clef_64
      (Constructeur : in out Constructeur_Clef_64_T);

   overriding
   --  Construit la clefs de 64 bits avec le brut de 64 bits.
   --  @param Constructeur
   --  Le constructeur de la clef.
   --  @param Brut
   --  Le brut à partir duquel on va construire la clef.
   procedure Construire_Clef_64
   (
      Constructeur : in out Constructeur_Clef_64_T;
      Brut : Clef_64_Brut_T
   );

   overriding
   --  Ajoute un constructeur de clef 56 bits à la clef de 64.
   --  @param Constructeur
   --  Le constructeur de la clef.
   --  @param Constructeur_56
   --  Le constructeur de clef 56 bits.
   procedure Construire_Ajouter_Constructeur_56
   (
      Constructeur : in out Constructeur_Clef_64_T;
      Constructeur_56 : access Des_P.Clef_P.Constructeur_56_Abs_P.
         Constructeur_Clef_56_Abs_T'Class
   );

   overriding
   --  Ajoute un constructeur de clef 48 bits à la clef de 64.
   --  @param Constructeur
   --  Le constructeur de la clef.
   --  @param Constructeur_48
   --  Le constructeur de clef 48 bits.
   procedure Construire_Ajouter_Constructeur_48
   (
      Constructeur : in out Constructeur_Clef_64_T;
      Constructeur_48 : access Des_P.Clef_P.Constructeur_48_Abs_P.
         Constructeur_Clef_48_Abs_T'Class
   );

   overriding
   --  Permet de récupérer la clef de 64 terminée.
   --  @param Constructeur
   --  Le constructeur de la clef de 64.
   --  @return La clef de 64.
   function Recuperer_Clef_64
      (Constructeur : in out Constructeur_Clef_64_T)
      return Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P.Clef_64_T;

private

   type Constructeur_Clef_64_T is new Constructeur_Clef_64_Abs_T with
      record
         Clef_64 : Clef_64_T;
         Constructeur_56 : access Des_P.Clef_P.Constructeur_56_Abs_P.
            Constructeur_Clef_56_Abs_T'Class;
         Constructeur_48 : access Des_P.Clef_P.Constructeur_48_Abs_P.
            Constructeur_Clef_48_Abs_T'Class;
      end record;

end Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P.Constructeur_64_P;
