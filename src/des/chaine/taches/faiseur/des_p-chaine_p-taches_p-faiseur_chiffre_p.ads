with Des_P.Clef_P.Clef_64_I_P;
with Des_P.Clef_P.Clef_56_I_P.Faiseur_I_P;
with Des_P.Clef_P.Clef_48_I_P.Faiseur_I_P;
with Des_P.Chaine_P.Faiseur_I_P;

private with Des_P.Clef_P.Clef_56_I_P.Faiseur_I_P.Holder_P;
private with Des_P.Clef_P.Clef_48_I_P.Faiseur_I_P.Holder_P;

--  @summary
--  Constructeur de chaine de filtres.
--  @description
--  Constructeur de chaine de filtres de chiffrement.
--  @group Chaine Constructeur Chiffrement
package Des_P.Chaine_P.Taches_P.Faiseur_Chiffre_P is

   type Faiseur_Chiffrement_T is new
      Des_P.Chaine_P.Faiseur_I_P.Faiseur_Interface_T with private;
   --  Le constructeur de filtre de chiffrement.

   package Faiseur_56_I_R renames Des_P.Clef_P.Clef_56_I_P.Faiseur_I_P;
   package Faiseur_48_I_R renames Des_P.Clef_P.Clef_48_I_P.Faiseur_I_P;

   overriding
   procedure Initialiser
      (
         Constructeur   : in out Faiseur_Chiffrement_T;
         Faiseur_56     : Faiseur_56_I_R.Faiseur_Interface_T'Class;
         Faiseur_48     : Faiseur_48_I_R.Faiseur_Interface_T'Class
      );
   --  Initialise une nouvelle chaine vide.
   --  @param Constructeur
   --  Le constructeur de chaine
   --  @param Faiseur_56
   --  Le constructeur de clef de 56
   --  @param Faiseur_48
   --  Le constructeur de clef de 48

   overriding
   procedure Construire
      (
         Constructeur   : in out Faiseur_Chiffrement_T;
         Clef           : Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T'Class
      );
   --  Construit la chaine de filtre avec la clef.
   --  @param Constructeur
   --  Le constructeur de chaine
   --  @param Clef
   --  La clef de 64 bits.

   overriding
   function Recuperer_Chaine
      (Constructeur : Faiseur_Chiffrement_T)
      return Chaine_Interface_T'Class;
   --  Récupère la chaine construite.
   --  @param Constructeur
   --  Le constructeur de chaine
   --  @return La chaine après construction

private

   type Faiseur_Chiffrement_T is new
      Des_P.Chaine_P.Faiseur_I_P.Faiseur_Interface_T with
      record
         Chaine : Chaine_T;
         --  La chaine d'étage en cours d'initialisation.
         Faiseur_56 : Faiseur_56_I_R.Holder_P.Holder;
         --  Le constructeur de clefs de 56 bits.
         Faiseur_48 : Faiseur_48_I_R.Holder_P.Holder;
         --  Le constructeur de clefs de 48 bits.
      end record;

end Des_P.Chaine_P.Taches_P.Faiseur_Chiffre_P;
