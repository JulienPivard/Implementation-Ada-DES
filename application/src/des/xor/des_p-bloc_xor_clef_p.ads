with Des_P.Bloc_P.Bloc_48_P;
with Des_P.Clef_P.Clef_48_Abs_P;

--  @summary
--  L'opération xor entre un bloc de bits et une clef.
--  @description
--  Permet de faire un xor entre un bloc de 48 bits et
--  une clef de même taille.
--  @group XOR
package Des_P.Bloc_Xor_Clef_P is

   pragma Pure;

   --  Le xor entre le bloc et la clef de 48 bits.
   --  @param Gauche
   --  Le bloc de 48 bits.
   --  @param Droite
   --  La clef de 48 bits.
   --  @return Le résultat du xor.
   function "xor"
      (
         Gauche : Des_P.Bloc_P.Bloc_48_P.Bloc_48_T;
         Droite : Des_P.Clef_P.Clef_48_Abs_P.Clef_48_Abs_T'Class
      )
      return Des_P.Bloc_P.Bloc_48_P.Bloc_48_T;

   --  Le xor entre le bloc et la clef de 48 bits.
   --  @param Gauche
   --  La clef de 48 bits.
   --  @param Droite
   --  Le bloc de 48 bits.
   --  @return Le résultat du xor.
   function "xor"
      (
         Gauche : Des_P.Clef_P.Clef_48_Abs_P.Clef_48_Abs_T'Class;
         Droite : Des_P.Bloc_P.Bloc_48_P.Bloc_48_T
      )
      return Des_P.Bloc_P.Bloc_48_P.Bloc_48_T;

end Des_P.Bloc_Xor_Clef_P;