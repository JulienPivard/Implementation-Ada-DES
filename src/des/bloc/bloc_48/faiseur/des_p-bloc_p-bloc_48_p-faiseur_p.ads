with Des_P.Bloc_P.Bloc_32_P;

--  @summary
--  Constructeur de bloc de 48 bits.
--  @description
--  Construit le bloc de 48 bits à partir d'un bloc brut.
--  @group Bloc Constructeur
package Des_P.Bloc_P.Bloc_48_P.Faiseur_P
   with Pure
is

   type Faiseur_Bloc_T is tagged private;
   --  Constructeur de bloc de 48 bits

   procedure Preparer_Nouveau_Bloc
      (Constructeur : in out Faiseur_Bloc_T)
      with Inline;
   --  Initialise un nouveau bloc vide de 48 bits.
   --  @param Constructeur
   --  Le constructeur de bloc de 48 bits.

   procedure Construire_Bloc
      (
         Constructeur : in out Faiseur_Bloc_T;
         Brut         : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T
      );
   --  Construit le bloc de 48 bits en étendant un bloc de 32 bits.
   --  @param Constructeur
   --  Le constructeur de bloc de 48 bits.
   --  @param Brut
   --  Le bloc de 32 bits.

   function Recuperer_Bloc
      (Constructeur : Faiseur_Bloc_T)
      return Bloc_48_T
      with Inline;
   --  Récupère le bloc de 48 bits terminé.
   --  @param Constructeur
   --  Le constructeur de bloc de 48 bits.
   --  @return Le bloc de 48 bits.

private

   type Faiseur_Bloc_T is tagged
      record
         Bloc : Bloc_48_T;
      end record;

end Des_P.Bloc_P.Bloc_48_P.Faiseur_P;
