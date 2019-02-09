with AUnit.Assertions;

with Des_P.Clef_P.Clef_48_Simple_P;
with Des_P.Bloc_P.Bloc_48_I_P;

package body Des_P.Bloc_Xor_Clef_P.Test_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      I : Des_P.Bloc_P.Bloc_48_I_P.Intervalle_T :=
         Des_P.Bloc_P.Bloc_48_I_P.Intervalle_T'First;
      use type Des_P.Bloc_P.Bloc_48_I_P.Intervalle_T;
   begin
      Construction_Bloc :
      loop
         T.Bloc.Ecrire_Bit (I, True);
         exit Construction_Bloc when
            I = Des_P.Bloc_P.Bloc_48_I_P.Intervalle_T'Last;
         I := Des_P.Bloc_P.Bloc_48_I_P.Intervalle_T'Succ (I);
         T.Bloc.Ecrire_Bit (I, False);
         exit Construction_Bloc when
            I = Des_P.Bloc_P.Bloc_48_I_P.Intervalle_T'Last;
         I := Des_P.Bloc_P.Bloc_48_I_P.Intervalle_T'Succ (I);
      end loop Construction_Bloc;
   end Set_Up;

   ---------------------------------------------------------------------------
   overriding
   procedure Tear_Down (T : in out Test_Fixt_T) is
   begin
      null;
   end Tear_Down;

   ---------------------------------------------------------------------------
   --                              scénarios                                --
   ---------------------------------------------------------------------------
   ---------------------------------------------------------------------------
   procedure Test_Xor_G_D (T : in out Test_Fixt_T) is
      Bit_Resulta, Bit_Attendu : Bit_IO_T;
      Bloc_Resultat : Des_P.Bloc_P.Bloc_48_P.Bloc_48_T;
      Clef : Des_P.Clef_P.Clef_48_Simple_P.Clef_S_T;
   begin
      Bloc_Resultat := Des_P.Bloc_P.Bloc_48_P.Bloc_48_T (T.Bloc xor Clef);

      for I in Des_P.Bloc_P.Bloc_48_I_P.Intervalle_T loop
         Bit_Resulta := (if Bloc_Resultat.Lire_Bit (I) then 1 else 0);
         Bit_Attendu := (if T.Bloc.Lire_Bit (I) xor True then 1 else 0);

         AUnit.Assertions.Assert
            (Bit_Resulta = Bit_Attendu,
            "Le bit " & I'Img &
            " vaut : " & Bit_Resulta'Img &
            " au lieu de " & Bit_Attendu'Img
            );
      end loop;
   end Test_Xor_G_D;

   ---------------------------------------------------------------------------
   procedure Test_Xor_D_G (T : in out Test_Fixt_T) is
      Bit_Resulta, Bit_Attendu : Bit_IO_T;
      Bloc_Resultat : Des_P.Bloc_P.Bloc_48_P.Bloc_48_T;
      Clef : Des_P.Clef_P.Clef_48_Simple_P.Clef_S_T;
   begin
      Bloc_Resultat := Des_P.Bloc_P.Bloc_48_P.Bloc_48_T (T.Bloc xor Clef);

      for I in Des_P.Bloc_P.Bloc_48_I_P.Intervalle_T loop
         Bit_Resulta := (if Bloc_Resultat.Lire_Bit (I) then 1 else 0);
         Bit_Attendu := (if T.Bloc.Lire_Bit (I) xor True then 1 else 0);

         AUnit.Assertions.Assert
            (Bit_Resulta = Bit_Attendu,
            "Le bit " & I'Img &
            " vaut : " & Bit_Resulta'Img &
            " au lieu de " & Bit_Attendu'Img
            );
      end loop;
   end Test_Xor_D_G;

end Des_P.Bloc_Xor_Clef_P.Test_P;
