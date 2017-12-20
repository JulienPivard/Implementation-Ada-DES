--  @summary
--  Un bloc de 32 bits de données.
--  @description
--  Cette représentation permet de manipuler facilement des
--  blocs de 32 bits sans avoir à en connaitre le détail.
--  @group Bloc
package Des_P.Bloc_P.Bloc_32_P is

   pragma Pure;

   --  L'intervalle pour accéder à notre bloc de 32 bits.
   type Intervalle_Bloc_32_T is range 1 .. 32;

   --  Représente un bloc de 32 bits.
   type Bloc_32_T is new Bloc_Abstrait_T with private;

   overriding
   --  Création d'un bloc de 32 bits avec la valeur 0.
   --  @param B
   --  Le bloc de 32 bits.
   procedure Initialize (B : in out Bloc_32_T);

   overriding
   --  Supprime le bloc.
   --  @param B
   --  Le bloc de 32 bits.
   procedure Finalize (B : in out Bloc_32_T);

   overriding
   --  Ajuste le contenu après l'affectation.
   --  @param B
   --  Le bloc de 32 bits.
   procedure Adjust (B : in out Bloc_32_T);

   --  Écrit le bit à la position demandé dans le bloc de 32.
   --  @param B
   --  Le bloc de 32 bits.
   --  @param Position
   --  La position du bit qu'on veut écrire.
   --  @param Bit
   --  Le bit qu'on veut écrire.
   procedure Ecrire_Bit
   (
      B : in out Bloc_32_T;
      Position : Intervalle_Bloc_32_T;
      Bit : Bit_T
   );

   --  Lit le bit demandé dans le bloc de 32.
   --  @param B
   --  Le bloc de 32 bits.
   --  @param Position
   --  La position du bit qu'on veut lire.
   --  @return Le bit demandé.
   function Lire_Bit
   (
      B : Bloc_32_T;
      Position : Intervalle_Bloc_32_T
   )
   return Bit_T;

private

   type Tableau_Bits_T is array
      (Intervalle_Bloc_32_T range Intervalle_Bloc_32_T'Range)
      of Bit_T with Size => 32, Pack;

   type Bloc_32_T is new Bloc_Abstrait_T with
      record
         Bits : Tableau_Bits_T;
      end record;

end Des_P.Bloc_P.Bloc_32_P;