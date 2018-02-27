with Des_P.Bloc_P.Bloc_48_P;

--  @summary
--  Constructeur de bloc de 32 bits.
--  @description
--  Construit le bloc de 32 bits à partir d'un bloc brut.
--  @group Bloc Constructeur
package Des_P.Bloc_P.Bloc_32_P.Constructeur_P is

   pragma Pure;

   type Constructeur_Bloc_32_T is tagged private;
   --  Constructeur de bloc de 32 bits

   type Bloc_32_Brut_T is mod 2**32
      with Size => 32;
   --  Le brut de 32 bits qui va être raffiné en
   --  un bloc de 32 bits plus facile à manipuler.

   procedure Preparer_Nouveau_Bloc
      (Constructeur : in out Constructeur_Bloc_32_T);
   --  Initialise un nouveau bloc vide de 32 bits.
   --  @param Constructeur
   --  Le constructeur de bloc de 32 bits.

   procedure Construire_Bloc
      (
         Constructeur : in out Constructeur_Bloc_32_T;
         Brut : Bloc_32_Brut_T
      );
   --  Raffine le brut de 32 bits pour construire le bloc de 32 bits.
   --  @param Constructeur
   --  Le constructeur de bloc de 32 bits.
   --  @param Brut
   --  Le brut de 32 bits.

   procedure Construire_Bloc
      (
         Constructeur : in out Constructeur_Bloc_32_T;
         Brut : Bloc_32_T
      );
   --  Construit un bloc de 32 bits par permutation de la table P
   --  à partir d'un autre bloc de même taille.
   --  @param Constructeur
   --  Le constructeur de bloc de 32 bits.
   --  @param Brut
   --  L'autre bloc de 32 bits.

   procedure Construire_Bloc
      (
         Constructeur : in out Constructeur_Bloc_32_T;
         Brut : Des_P.Bloc_P.Bloc_48_P.Bloc_48_T
      );
   --  Construit un bloc de 32 bits réduction d'un bloc de 48 bits.
   --  @param Constructeur
   --  Le constructeur de bloc de 32 bits.
   --  @param Brut
   --  le bloc de 48 bits.

   function Recuperer_Bloc
      (Constructeur : Constructeur_Bloc_32_T)
      return Bloc_32_T;
   --  Récupère le bloc de 32 bits terminé.
   --  @param Constructeur
   --  Le constructeur de bloc de 32 bits.
   --  @return Le bloc de 32 bits.

   function Transformer_En_Brut
      (
         Constructeur : in out Constructeur_Bloc_32_T;
         Bloc : Bloc_32_T
      )
      return Bloc_32_Brut_T;
   --  Transforme un bloc de 32 bits en son brut équivalent.
   --  @param Constructeur
   --  Le constructeur de bloc de 32 bits.
   --  @param Bloc
   --  Le bloc de 32 bits.
   --  @return Le brut de 32 bits.

private

   type Constructeur_Bloc_32_T is tagged
      record
         Bloc : Bloc_32_T;
      end record;

end Des_P.Bloc_P.Bloc_32_P.Constructeur_P;
