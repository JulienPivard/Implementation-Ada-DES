with Des_P.Bloc_P;

package body Des_P.Bloc_Xor_Clef_P is

   ---------------------------------------------------------------------------
   function "xor"
      (
         Gauche : Des_P.Bloc_P.Bloc_48_P.Bloc_48_T;
         Droite : Des_P.Clef_P.Clef_48_Abs_P.Clef_48_Abstrait_T'Class
      )
      return Des_P.Bloc_P.Bloc_48_P.Bloc_48_T
   is
      use Des_P.Bloc_P.Bloc_48_P;
      use Des_P.Clef_P.Clef_48_Abs_P;
      use Des_P.Bloc_P;
      B : Bloc_48_T;
      Bit : Bit_T;
   begin
      for I in Intervalle_Bloc_48_T loop
         Bit :=
            Gauche.Lire_Bit (I) xor Droite.Lire_Bit (Intervalle_Clef_48_T (I));
         B.Ecrire_Bit (I, Bit);
      end loop;
      return B;
   end "xor";

   ---------------------------------------------------------------------------
   function "xor"
      (
         Gauche : Des_P.Clef_P.Clef_48_Abs_P.Clef_48_Abstrait_T'Class;
         Droite : Des_P.Bloc_P.Bloc_48_P.Bloc_48_T
      )
      return Des_P.Bloc_P.Bloc_48_P.Bloc_48_T
   is
   begin
      return Droite xor Gauche;
   end "xor";

end Des_P.Bloc_Xor_Clef_P;
