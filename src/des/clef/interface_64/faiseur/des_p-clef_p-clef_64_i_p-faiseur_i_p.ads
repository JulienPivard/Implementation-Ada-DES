--  @summary
--  Le constructeur abstrait de clef de 64 bits.
--  @description
--  Construit une clef de 64 bits à partir d'un brut de 64 bits.
--  @group Clef Constructeur 64
package Des_P.Clef_P.Clef_64_I_P.Faiseur_I_P
   with Pure
is

   type Faiseur_Interface_T is interface;
   --  Constructeur de clef abstraite de 64 bits.

   type Clef_64_Brut_T is mod 2**64
      with Size => 64;
   --  Le bloc de données brut que vas utiliser le constructeur
   --  pour construire la clef de 64 bits.

   procedure Preparer_Nouvelle_Clef
      (Constructeur : in out Faiseur_Interface_T)
   is abstract;
   --  Prépare une nouvelle clef vide.
   --  @param Constructeur
   --  Le constructeur de la clef de 64 bits.

   procedure Construire_Clef
      (
         Constructeur   : in out Faiseur_Interface_T;
         Brut           :        Clef_64_Brut_T
      )
   is abstract;
   --  Construit la clefs de 64 bits avec le brut de 64 bits.
   --  @param Constructeur
   --  Le constructeur de la clef.
   --  @param Brut
   --  Le brut à partir duquel on va construire la clef.

   function Recuperer_Clef
      (Constructeur : Faiseur_Interface_T)
      return Clef_Interface_T'Class
   is abstract;
   --  Permet de récupérer la clef de 64 terminée.
   --  @param Constructeur
   --  Le constructeur de la clef de 64.
   --  @return La clef de 64.

end Des_P.Clef_P.Clef_64_I_P.Faiseur_I_P;
