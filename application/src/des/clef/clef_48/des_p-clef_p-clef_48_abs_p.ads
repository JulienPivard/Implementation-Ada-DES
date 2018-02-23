--  @summary
--  Une clef abstraite de 48 bits.
--  @description
--  La représentation d'une clef de 48 bits dans le standard DES.
--  @group Clef
package Des_P.Clef_P.Clef_48_Abs_P is

   pragma Pure;

   --  Le nombre de bits que contient la sous clef.
   type Intervalle_Clef_48_T is range 1 .. 48;

   --  La sous clef abstraite.
   type Clef_48_Abstrait_T is abstract new Clef_Abstraite_T with private;

   --  Permet de lire le bit n de la clef.
   --  @param Clef
   --  La clef dont on veut lire un bit.
   --  @param Position
   --  La position du bit dans la sous clef.
   --  @return Le bit lu.
   function Lire_Bit
      (
         Clef : Clef_48_Abstrait_T;
         Position : Intervalle_Clef_48_T
      )
      return Bit_T
   is abstract;

private

   type Clef_48_Abstrait_T is abstract new Clef_Abstraite_T with null record;

end Des_P.Clef_P.Clef_48_Abs_P;
