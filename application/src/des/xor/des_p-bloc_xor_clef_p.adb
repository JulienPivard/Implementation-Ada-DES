with Des_P.Bloc_P;

package body Des_P.Bloc_Xor_Clef_P is

   ---------------------------------------------------------------------------
   function "xor"
      (
         Gauche : Des_P.Bloc_P.Bloc_48_P.Bloc_48_T;
         Droite : Des_P.Clef_P.Clef_48_I_P.Clef_Interface_T'Class
      )
      return Des_P.Bloc_P.Bloc_48_P.Bloc_48_T
   is
      B : Des_P.Bloc_P.Bloc_48_P.Bloc_48_T;
   begin
      for I in Des_P.Bloc_P.Bloc_48_P.Intervalle_T loop
         declare
            I_Bis : constant Des_P.Clef_P.Clef_48_I_P.Intervalle_T :=
               Des_P.Clef_P.Clef_48_I_P.Intervalle_T (I);
            Bit : constant Des_P.Bloc_P.Bit_T :=
               Gauche.Lire_Bit (I) xor Droite.Lire_Bit (I_Bis);
         begin
            B.Ecrire_Bit (I, Bit);
         end;
      end loop;
      return B;
   end "xor";

   ---------------------------------------------------------------------------
   function "xor"
      (
         Gauche : Des_P.Clef_P.Clef_48_I_P.Clef_Interface_T'Class;
         Droite : Des_P.Bloc_P.Bloc_48_P.Bloc_48_T
      )
      return Des_P.Bloc_P.Bloc_48_P.Bloc_48_T
   is
   begin
      return Droite xor Gauche;
   end "xor";

end Des_P.Bloc_Xor_Clef_P;
