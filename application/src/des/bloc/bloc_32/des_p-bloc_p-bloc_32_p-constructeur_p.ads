--  @summary
--  Constructeur de bloc de 32 bits.
--  @description
--  Construit le bloc de 32 bits à partir d'un bloc brut.
--  @group Constructeur_Bloc
package Des_P.Bloc_P.Bloc_32_P.Constructeur_P is

   pragma Pure;

   --  Constructeur de bloc de 32 bits
   type Constructeur_Bloc_32_T is tagged private;

   --  Le brut de 32 bits qui va être raffiné en
   --  un bloc de 32 bits plus facile à manipuler.
   type Bloc_32_Brut_T is mod 2**32
      with Size => 32;

   --  Initialise un nouveau bloc vide de 32 bits.
   --  @param Constructeur
   --  Le constructeur de bloc de 32 bits.
   --  @param Brut
   --  Le brut de 32 bits.
   procedure Preparer_Nouveau_Bloc_32
      (Constructeur : in out Constructeur_Bloc_32_T; Brut : Bloc_32_Brut_T);

   --  Raffine le brut de 32 bits pour construire le bloc de 32 bits.
   --  @param Constructeur
   --  Le constructeur de bloc de 32 bits.
   procedure Construire_Bloc (Constructeur : in out Constructeur_Bloc_32_T);

   --  Récupère le bloc de 32 bits terminé.
   --  @param Constructeur
   --  Le constructeur de bloc de 32 bits.
   --  @return Le bloc de 32 bits.
   function Recuperer_Bloc_32 (Constructeur : Constructeur_Bloc_32_T) return
      Bloc_32_T;

private

   type Constructeur_Bloc_32_T is tagged
      record
         Brut : Bloc_32_Brut_T;
         Bloc : Bloc_32_T;
      end record;

end Des_P.Bloc_P.Bloc_32_P.Constructeur_P;
