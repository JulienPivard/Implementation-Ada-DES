limited with Des_P.Clef_P.Clef_56_I_P;

--  @summary
--  Le constructeur abstrait de clef de 48 bits.
--  @description
--  Construit une clef de 48 à partir d'une clef de 56.
--  Cette clef sera composé de 48 bits provenant de la
--  clef de 56. Le constructeur va sélectionner ces bits
--  selon le tableau PC-2 du standard DES.
--  @group Clef Constructeur
package Des_P.Clef_P.Clef_48_I_P.Faiseur_I_P
   with Pure
is

   type Faiseur_Interface_T is interface;
   --  Constructeur de la clef de 48 bits.

   procedure Preparer_Nouvelle_Clef
      (Constructeur : in out Faiseur_Interface_T)
   is abstract;
   --  Prépare une nouvelle sous clef vide.
   --  @param Constructeur
   --  Le constructeur de la clef de 48.

   procedure Construire_Clef
      (
         Constructeur   : in out Faiseur_Interface_T;
         Clef           : Des_P.Clef_P.Clef_56_I_P.Clef_Interface_T'Class
      )
   is abstract;
   --  Construit la clefs de 48 bits avec la clef de 56.
   --  @param Constructeur
   --  Le constructeur de la clef.
   --  @param Clef
   --  La clef à partir de laquelle on va construire la sous clef.

   function Recuperer_Clef
      (Constructeur : Faiseur_Interface_T)
      return Clef_Interface_T'Class
   is abstract;
   --  Permet de récupérer la clef de 48 terminée.
   --  @param Constructeur
   --  Le constructeur de la clef de 48.
   --  @return La clef de 48.

end Des_P.Clef_P.Clef_48_I_P.Faiseur_I_P;
