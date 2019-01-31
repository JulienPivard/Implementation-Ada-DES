with Des_P.Clef_P.Clef_64_I_P;
with Des_P.Clef_P.Clef_56_I_P;
with Des_P.Clef_P.Clef_48_I_P;
with Des_P.Clef_P.Clef_64_I_P.Faiseur_I_P;
with Des_P.Clef_P.Clef_56_I_P.Faiseur_I_P;
with Des_P.Clef_P.Clef_48_I_P.Faiseur_I_P;

--  @summary
--  Faiseur simplifié de chaine.
--  @description
--  Interface de Constructeur de chaine de filtres.
--  @group Constructeur
package Des_P.Faiseur_P is

   package Faiseur_64_I_R renames Des_P.Clef_P.Clef_64_I_P.Faiseur_I_P;
   package Faiseur_56_I_R renames Des_P.Clef_P.Clef_56_I_P.Faiseur_I_P;
   package Faiseur_48_I_R renames Des_P.Clef_P.Clef_48_I_P.Faiseur_I_P;

   function Faire_Clef
      (
         Faiseur  : in out Faiseur_64_I_R.Faiseur_Interface_T'Class;
         Clef     : Faiseur_64_I_R.Clef_64_Brut_T
      )
      return Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T'Class;
   --  Utilise un constructeur de clef de 64 bits pour construire
   --  une clef de ce type.
   --  @param Faiseur
   --  Le constructeur de la clef.
   --  @param Clef
   --  La clef.

   function Faire_Clef
      (
         Faiseur  : in out Faiseur_56_I_R.Faiseur_Interface_T'Class;
         Clef     : Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T'Class
      )
      return Des_P.Clef_P.Clef_56_I_P.Clef_Interface_T'Class;
   --  Utilise un constructeur de clef de 56 bits pour construire
   --  une clef de ce type.
   --  @param Faiseur
   --  Le constructeur de la clef.
   --  @param Clef
   --  La clef.

   function Faire_Clef
      (
         Faiseur  : in out Faiseur_48_I_R.Faiseur_Interface_T'Class;
         Clef     : Des_P.Clef_P.Clef_56_I_P.Clef_Interface_T'Class
      )
      return Des_P.Clef_P.Clef_48_I_P.Clef_Interface_T'Class;
   --  Utilise un constructeur de clef de 48 bits pour construire
   --  une clef de ce type.
   --  @param Faiseur
   --  Le constructeur de la clef.
   --  @param Clef
   --  La clef.

end Des_P.Faiseur_P;
