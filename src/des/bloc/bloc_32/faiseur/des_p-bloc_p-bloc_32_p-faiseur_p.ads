with Des_P.Bloc_P.Bloc_48_I_P;

--  @summary
--  Constructeur de bloc de 32 bits.
--  @description
--  Construit le bloc de 32 bits à partir d'un bloc brut.
--  @group Bloc Constructeur
package Des_P.Bloc_P.Bloc_32_P.Faiseur_P
   with Pure
is

   type Faiseur_Bloc_T is tagged private;
   --  Constructeur de bloc de 32 bits

   type Bloc_32_Brut_T is mod 2**32
      with Size => 32;
   --  Le brut de 32 bits qui va être raffiné en
   --  un bloc de 32 bits plus facile à manipuler.

   procedure Preparer_Nouveau_Bloc
      (Constructeur : in out Faiseur_Bloc_T)
      with Inline;
   --  Initialise un nouveau bloc vide de 32 bits.
   --  @param Constructeur
   --  Le constructeur de bloc de 32 bits.

   procedure Construire_Bloc
      (
         Constructeur : in out Faiseur_Bloc_T;
         Brut         : Bloc_32_Brut_T
      );
   --  Raffine le brut de 32 bits pour construire le bloc de 32 bits.
   --  @param Constructeur
   --  Le constructeur de bloc de 32 bits.
   --  @param Brut
   --  Le brut de 32 bits.

   procedure Construire_Bloc
      (
         Constructeur : in out Faiseur_Bloc_T;
         Bloc         : Bloc_32_T
      );
   --  Construit un bloc de 32 bits par permutation de la table P
   --  à partir d'un autre bloc de même taille.
   --  @param Constructeur
   --  Le constructeur de bloc de 32 bits.
   --  @param Bloc
   --  L'autre bloc de 32 bits.

   procedure Construire_Bloc
      (
         Constructeur : in out Faiseur_Bloc_T;
         Bloc         : Des_P.Bloc_P.Bloc_48_I_P.Bloc_Interface_T'Class
      );
   --  Construit un bloc de 32 bits réduction d'un bloc de 48 bits.
   --  @param Constructeur
   --  Le constructeur de bloc de 32 bits.
   --  @param Bloc
   --  le bloc de 48 bits.

   function Recuperer_Bloc
      (Constructeur : Faiseur_Bloc_T)
      return Bloc_32_T
      with Inline;
   --  Récupère le bloc de 32 bits terminé.
   --  @param Constructeur
   --  Le constructeur de bloc de 32 bits.
   --  @return Le bloc de 32 bits.

   function Transformer_En_Brut
      (
         Constructeur : in out Faiseur_Bloc_T;
         Bloc         : Bloc_32_T
      )
      return Bloc_32_Brut_T
      with Inline;
   --  Transforme un bloc de 32 bits en son brut équivalent.
   --  @param Constructeur
   --  Le constructeur de bloc de 32 bits.
   --  @param Bloc
   --  Le bloc de 32 bits.
   --  @return Le brut de 32 bits.

private

   type Faiseur_Bloc_T is tagged
      record
         Bloc : Bloc_32_T;
         --  Le bloc en cours de construction.
      end record;

end Des_P.Bloc_P.Bloc_32_P.Faiseur_P;
