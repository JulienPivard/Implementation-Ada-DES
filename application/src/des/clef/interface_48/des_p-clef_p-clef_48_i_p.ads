--  @summary
--  Une clef abstraite de 48 bits.
--  @description
--  La représentation d'une clef de 48 bits dans le standard DES.
--  @group Clef
package Des_P.Clef_P.Clef_48_I_P is

   pragma Pure;

   type Clef_Interface_T is interface;
   --  L'interface d'une clef de 48.

   type Intervalle_T is range 1 .. 48;
   --  Le nombre de bits que contient la sous clef.

   function Lire_Bit
      (
         Clef : Clef_Interface_T;
         Position : Intervalle_T
      )
      return Bit_T
   is abstract;
   --  Permet de lire le bit n de la clef.
   --  @param Clef
   --  La clef dont on veut lire un bit.
   --  @param Position
   --  La position du bit dans la clef.
   --  @return Le bit lu.

end Des_P.Clef_P.Clef_48_I_P;
