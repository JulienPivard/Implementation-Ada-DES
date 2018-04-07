with Des_P.Bloc_P;

package body Des_P.Bloc_Xor_Clef_P is

   ---------------------------------------------------------------------------
   function "xor"
      (
         Gauche : Des_P.Bloc_P.Bloc_48_I_P.Bloc_Interface_T'Class;
         Droite : Des_P.Clef_P.Clef_48_I_P.Clef_Interface_T'Class
      )
      return Des_P.Bloc_P.Bloc_48_I_P.Bloc_Interface_T'Class
   is
      B : Des_P.Bloc_P.Bloc_48_I_P.Bloc_Interface_T'Class := Gauche;
   begin
      --  Applique un ou exclusif sur tous les bits du bloc et de la clef.
      for I in Des_P.Bloc_P.Bloc_48_I_P.Intervalle_T loop
         declare
            I_Bis : constant Des_P.Clef_P.Clef_48_I_P.Intervalle_T :=
               Des_P.Clef_P.Clef_48_I_P.Intervalle_T (I);
            --  Le bit résultat du xor.
            Bit : constant Des_P.Bloc_P.Bit_T :=
               Gauche.Lire_Bit (I) xor Droite.Lire_Bit (I_Bis);
         begin
            --  On écrit ce bit dans le bloc résultat à la même
            --  position que dans le bloc et la clef d'origine.
            B.Ecrire_Bit (I, Bit);
         end;
      end loop;
      return B;
   end "xor";

   ---------------------------------------------------------------------------
   function "xor"
      (
         Gauche : Des_P.Clef_P.Clef_48_I_P.Clef_Interface_T'Class;
         Droite : Des_P.Bloc_P.Bloc_48_I_P.Bloc_Interface_T'Class
      )
      return Des_P.Bloc_P.Bloc_48_I_P.Bloc_Interface_T'Class
   is
   begin
      return Droite xor Gauche;
   end "xor";

end Des_P.Bloc_Xor_Clef_P;
