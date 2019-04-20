with Des_P.Clef_P.Clef_64_I_P;
with Des_P.Clef_P.Clef_56_I_P.Faiseur_I_P;
with Des_P.Clef_P.Clef_48_I_P.Faiseur_I_P;

--  @summary
--  Constructeur de chaine de filtres.
--  @description
--  Interface de Constructeur de chaine de filtres.
--  @group Chaine Constructeur
package Des_P.Chaine_P.Faiseur_I_P
   with Pure
is

   --  L'interface de constructeur.
   type Faiseur_Interface_T is interface;

   package Faiseur_56_I_R renames Des_P.Clef_P.Clef_56_I_P.Faiseur_I_P;
   package Faiseur_48_I_R renames Des_P.Clef_P.Clef_48_I_P.Faiseur_I_P;

   procedure Initialiser
      (
         Constructeur   : in out Faiseur_Interface_T;
         Faiseur_56     : Faiseur_56_I_R.Faiseur_Interface_T'Class;
         Faiseur_48     : Faiseur_48_I_R.Faiseur_Interface_T'Class
      )
   is abstract;
   --  Initialise une nouvelle chaine vide.
   --  @param Constructeur
   --  Le constructeur de chaine
   --  @param Faiseur_56
   --  Le constructeur de clef de 56
   --  @param Faiseur_48
   --  Le constructeur de clef de 48

   procedure Construire
      (
         Constructeur   : in out Faiseur_Interface_T;
         Clef           : Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T'Class
      )
   is abstract;
   --  Construit la chaine de filtre avec la clef.
   --  @param Constructeur
   --  Le constructeur de chaine
   --  @param Clef
   --  La clef de 64 bits.

   function Recuperer_Chaine
      (Constructeur : Faiseur_Interface_T)
      return Chaine_Interface_T'Class
   is abstract;
   --  Récupère la chaine construite.
   --  @param Constructeur
   --  Le constructeur de chaine
   --  @return La chaine après construction

end Des_P.Chaine_P.Faiseur_I_P;
