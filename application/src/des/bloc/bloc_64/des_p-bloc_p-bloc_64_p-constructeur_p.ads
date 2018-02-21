--  @summary
--  Constructeur de bloc de 64 bits.
--  @description
--  Construit le bloc de 64 bits à partir d'un bloc brut de 64.
--  @group Bloc Constructeur
package Des_P.Bloc_P.Bloc_64_P.Constructeur_P is

   pragma Pure;

   --  Constructeur de bloc de 64 bits.
   type Constructeur_Bloc_64_T is tagged private;

   --  Le brut de 64 bits qui va être raffiné en
   --  un bloc de 64 bits plus facile à manipuler.
   type Bloc_64_Brut_T is mod 2**64
      with Size => 64;

   --  Initialise un nouveau bloc vide de 64 bits.
   --  @param Constructeur
   --  Le constructeur de bloc de 64 bits.
   procedure Preparer_Nouveau_Bloc
      (Constructeur : in out Constructeur_Bloc_64_T);

   --  Raffine le brut de 64 bits pour construire le bloc de 64 bits.
   --  @param Constructeur
   --  Le constructeur de bloc de 64 bits.
   --  @param Brut
   --  Le brut de 64 bits.
   procedure Construire_Bloc
      (
         Constructeur : in out Constructeur_Bloc_64_T;
         Brut : Bloc_64_Brut_T
      );

   --  Récupère le bloc de 64 bits terminé.
   --  @param Constructeur
   --  Le constructeur de bloc de 64 bits.
   --  @return Le bloc de 64 bits.
   function Recuperer_Bloc
      (Constructeur : Constructeur_Bloc_64_T)
      return Bloc_64_T;

   --  Transforme un bloc de 64 bits en son équivalent en brut.
   --  @param Constructeur
   --  Le constructeur de bloc de 64 bits.
   --  @param Bloc
   --  Le bloc de 64 bits.
   --  @return Le brut de 64 bits.
   function Transformer_En_Brut
      (
         Constructeur : in out Constructeur_Bloc_64_T;
         Bloc : Bloc_64_T
      )
      return Bloc_64_Brut_T;

private

   type Constructeur_Bloc_64_T is tagged
      record
         Bloc : Bloc_64_T;
      end record;

end Des_P.Bloc_P.Bloc_64_P.Constructeur_P;
