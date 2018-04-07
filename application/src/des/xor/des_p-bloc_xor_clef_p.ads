with Des_P.Clef_P.Clef_48_I_P;
with Des_P.Bloc_P.Bloc_48_I_P;

--  @summary
--  L'opération xor entre un bloc de bits et une clef.
--  @description
--  Permet de faire un xor entre un bloc de 48 bits et
--  une clef de même taille.
--  @group XOR
package Des_P.Bloc_Xor_Clef_P is

   pragma Pure;

   function "xor"
      (
         Gauche : Des_P.Bloc_P.Bloc_48_I_P.Bloc_Interface_T'Class;
         Droite : Des_P.Clef_P.Clef_48_I_P.Clef_Interface_T'Class
      )
      return Des_P.Bloc_P.Bloc_48_I_P.Bloc_Interface_T'Class;
   --  Le xor entre le bloc et la clef de 48 bits.
   --  @param Gauche
   --  Le bloc de 48 bits.
   --  @param Droite
   --  La clef de 48 bits.
   --  @return Le résultat du xor.

   function "xor"
      (
         Gauche : Des_P.Clef_P.Clef_48_I_P.Clef_Interface_T'Class;
         Droite : Des_P.Bloc_P.Bloc_48_I_P.Bloc_Interface_T'Class
      )
      return Des_P.Bloc_P.Bloc_48_I_P.Bloc_Interface_T'Class;
   --  Le xor entre le bloc et la clef de 48 bits.
   --  @param Gauche
   --  La clef de 48 bits.
   --  @param Droite
   --  Le bloc de 48 bits.
   --  @return Le résultat du xor.

end Des_P.Bloc_Xor_Clef_P;
