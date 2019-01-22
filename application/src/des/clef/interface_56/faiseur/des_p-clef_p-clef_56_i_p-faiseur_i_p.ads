limited with Des_P.Clef_P.Clef_64_I_P;

--  @summary
--  Le constructeur abstrait de clef de 56 bits.
--  @description
--  Construit une clef de 56 bits à partir d'une clef de 64 bits.
--  Cette clef sera composée de 56 bits provenant de
--  la clef de 64. Le constructeur va sélectionner ces bits
--  selon le tableau PC-1 du standard DES.
--  @group Clef Constructeur
package Des_P.Clef_P.Clef_56_I_P.Faiseur_I_P
   with Pure
is

   type Faiseur_Interface_T is interface;
   --  Constructeur abstrait de clef de 56 bits.

   procedure Preparer_Nouvelle_Clef
      (Constructeur : in out Faiseur_Interface_T)
   is abstract;
   --  Prépare une nouvelle clef vide.
   --  @param Constructeur
   --  Le constructeur de la clef de 56.

   procedure Construire_Clef
      (
         Constructeur : in out Faiseur_Interface_T;
         Clef : Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T'Class
      )
   is abstract;
   --  Construit la clefs de 56 bits avec la clef de 64.
   --  @param Constructeur
   --  Le constructeur de la clef.
   --  @param Clef
   --  La clef à partir de laquelle on va construire la sous clef.

   function Recuperer_Clef
      (Constructeur : Faiseur_Interface_T)
      return Clef_Interface_T'Class
   is abstract;
   --  Permet de récupérer la clef de 56 terminée.
   --  @param Constructeur
   --  Le constructeur de la clef de 56.
   --  @return La clef de 56.

end Des_P.Clef_P.Clef_56_I_P.Faiseur_I_P;
