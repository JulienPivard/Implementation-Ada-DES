--  @summary
--  Une interface de bloc de 48 bits de données.
--  @description
--  Une interface de manipulation des blocs de 48 bits.
--  @group Bloc
package Des_P.Bloc_P.Bloc_48_I_P
   with Pure
is

   type Intervalle_T is range 1 .. 48;
   --  L'intervalle pour accéder à notre bloc de 48 bits.

   type Bloc_Interface_T is interface;
   --  L'interface de bloc de 48 bits.

   procedure Ecrire_Bit
      (
         B        : in out Bloc_Interface_T;
         Position : Intervalle_T;
         Bit      : Bit_T
      )
   is abstract;
   --  Écrit le bit à la position demandé dans le bloc de 48.
   --  @param B
   --  L'interface bloc de 48 bits.
   --  @param Position
   --  La position du bit qu'on veut écrire.
   --  @param Bit
   --  Le bit qu'on veut écrire.

   function Lire_Bit
      (
         B        : Bloc_Interface_T;
         Position : Intervalle_T
      )
      return Bit_T
   is abstract;
   --  Lit le bit demandé dans le bloc de 48.
   --  @param B
   --  L'interface bloc de 48 bits.
   --  @param Position
   --  La position du bit qu'on veut lire.
   --  @return Le bit demandé.

end Des_P.Bloc_P.Bloc_48_I_P;
