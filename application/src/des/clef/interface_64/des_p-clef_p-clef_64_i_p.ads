--  @summary
--  Une clef abstraite de 64 bits.
--  @description
--  La représentation d'une clef de 64 bits dans le standard DES.
--  @group Clef
package Des_P.Clef_P.Clef_64_I_P is

   pragma Pure;

   type Clef_Interface_T is interface;
   --  La clef de 64 bits.

   type Intervalle_T is range 1 .. 64;
   --  L'intervalle de bits de la clef.

   function Lire_Bit
      (
         Clef : Clef_Interface_T;
         Position : Intervalle_T
      )
      return Bit_T
   is abstract;
   --  Lit le bit à la position spécifié.
   --  @param Clef
   --  La clef dont on veut lire un bit.
   --  @param Position
   --  La position du bit que l'on veut lire.
   --  @return Le bit lu.

end Des_P.Clef_P.Clef_64_I_P;
