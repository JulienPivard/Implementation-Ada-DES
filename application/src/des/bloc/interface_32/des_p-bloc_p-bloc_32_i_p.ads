--  @summary
--  Une interface de bloc de 32 bits.
--  @description
--  Une interface de manipulation des blocs de 32 bits.
--  @group Bloc
package Des_P.Bloc_P.Bloc_32_I_P is

   pragma Pure;

   type Bloc_Interface_T is interface;
   --  Interface de bloc de 32 bits.

   type Intervalle_T is range 1 .. 32;
   --  L'intervalle pour accéder à notre bloc de 32 bits.

   procedure Ecrire_Bit
      (
         B : in out Bloc_Interface_T;
         Position : Intervalle_T;
         Bit : Bit_T
      )
   is abstract;
   --  Écrit le bit à la position demandé dans le bloc de 32.
   --  @param B
   --  L'interface de bloc 32 bits.
   --  @param Position
   --  La position du bit qu'on veut écrire.
   --  @param Bit
   --  Le bit qu'on veut écrire.

   function Lire_Bit
      (
         B : Bloc_Interface_T;
         Position : Intervalle_T
      )
      return Bit_T
   is abstract;
   --  Lit le bit demandé dans le bloc de 32.
   --  @param B
   --  L'interface de bloc 32 bits.
   --  @param Position
   --  La position du bit qu'on veut lire.
   --  @return Le bit demandé.

   function "xor"
      (Bloc, Autre : Bloc_Interface_T)
      return Bloc_Interface_T
   is abstract;
   --  Effectue un xor bit à bit entre les deux blocs de 32.
   --  @param Bloc
   --  L'interface de bloc 32 bits.
   --  @param Autre
   --  L'autre interface bloc de 32 bits.
   --  @return Le résultat du xor bit à bit entre les deux blocs.

end Des_P.Bloc_P.Bloc_32_I_P;
