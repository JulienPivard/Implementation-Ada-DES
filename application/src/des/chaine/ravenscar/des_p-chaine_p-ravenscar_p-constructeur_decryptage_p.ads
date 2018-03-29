with Des_P.Clef_P.Clef_64_I_P;
with Des_P.Clef_P.Clef_56_I_P.Constructeur_I_P;
with Des_P.Clef_P.Clef_48_I_P.Constructeur_I_P;
with Des_P.Chaine_P.Constructeur_I_P;

private with Des_P.Clef_P.Clef_56_I_P.Constructeur_I_P.Holder_P;
private with Des_P.Clef_P.Clef_48_I_P.Constructeur_I_P.Holder_P;

--  @summary
--  Constructeur de chaine de filtres.
--  @description
--  Constructeur de chaine de filtres de déchiffrement.
--  @group Chaine Constructeur
package Des_P.Chaine_P.Ravenscar_P.Constructeur_Decryptage_P is

   type Constructeur_Dechiffrement_T is new
      Des_P.Chaine_P.Constructeur_I_P.Constructeur_Interface_T with private;
   --  Le constructeur de filtre de déchiffrement.

   package Faiseur_56_I_P renames Des_P.Clef_P.Clef_56_I_P.Constructeur_I_P;
   package Faiseur_48_I_P renames Des_P.Clef_P.Clef_48_I_P.Constructeur_I_P;

   overriding
   procedure Initialiser
      (
         Constructeur : in out Constructeur_Dechiffrement_T;
         Faiseur_56 : Faiseur_56_I_P.Constructeur_Interface_T'Class;
         Faiseur_48 : Faiseur_48_I_P.Constructeur_Interface_T'Class
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
         Constructeur : in out Constructeur_Dechiffrement_T;
         Clef : Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T'Class
      );
   --  Construit la chaine de filtre avec la clef.
   --  @param Constructeur
   --  Le constructeur de chaine
   --  @param Clef
   --  La clef de 64 bits.

   overriding
   function Recuperer_Chaine
      (Constructeur : Constructeur_Dechiffrement_T)
      return Chaine_Interface_T'Class;
   --  Récupère la chaine construite.
   --  @param Constructeur
   --  Le constructeur de chaine
   --  @return La chaine après construction

private

   type Constructeur_Dechiffrement_T is new
      Des_P.Chaine_P.Constructeur_I_P.Constructeur_Interface_T with
      record
         Chaine : Chaine_T;
         Faiseur_56 : Faiseur_56_I_P.Holder_P.Holder;
         Faiseur_48 : Faiseur_48_I_P.Holder_P.Holder;
      end record;

end Des_P.Chaine_P.Ravenscar_P.Constructeur_Decryptage_P;
