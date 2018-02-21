with Des_P.Bloc_P.Bloc_32_P;

--  @summary
--  Constructeur de bloc de 48 bits.
--  @description
--  Construit le bloc de 48 bits à partir d'un bloc brut.
--  @group Bloc Constructeur
package Des_P.Bloc_P.Bloc_48_P.Constructeur_P is

   pragma Pure;

   --  Constructeur de bloc de 48 bits
   type Constructeur_Bloc_48_T is tagged private;

   --  Initialise un nouveau bloc vide de 48 bits.
   --  @param Constructeur
   --  Le constructeur de bloc de 48 bits.
   procedure Preparer_Nouveau_Bloc
      (Constructeur : in out Constructeur_Bloc_48_T);

   --  Construit le bloc de 48 bits en étendant un bloc de 32 bits.
   --  @param Constructeur
   --  Le constructeur de bloc de 48 bits.
   --  @param Brut
   --  Le bloc de 32 bits.
   procedure Construire_Bloc
      (
         Constructeur : in out Constructeur_Bloc_48_T;
         Brut : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T
      );

   --  Récupère le bloc de 48 bits terminé.
   --  @param Constructeur
   --  Le constructeur de bloc de 48 bits.
   --  @return Le bloc de 48 bits.
   function Recuperer_Bloc
      (Constructeur : Constructeur_Bloc_48_T)
      return Bloc_48_T;

private

   type Constructeur_Bloc_48_T is tagged
      record
         Bloc : Bloc_48_T;
      end record;

end Des_P.Bloc_P.Bloc_48_P.Constructeur_P;
