with AUnit.Assertions;

with Des_P.Clef_P.Clef_48_Simple_P;

package body Des_P.Bloc_Xor_Clef_P.Test_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      I : Des_P.Bloc_P.Bloc_48_P.Intervalle_T :=
         Des_P.Bloc_P.Bloc_48_P.Intervalle_T'First;
      use type Des_P.Bloc_P.Bloc_48_P.Intervalle_T;
   begin
      loop
         T.bloc.Ecrire_Bit (I, True);
         exit when I = Des_P.Bloc_P.Bloc_48_P.Intervalle_T'Last;
         I := Des_P.Bloc_P.Bloc_48_P.Intervalle_T'Succ (I);
         T.bloc.Ecrire_Bit (I, False);
         exit when I = Des_P.Bloc_P.Bloc_48_P.Intervalle_T'Last;
         I := Des_P.Bloc_P.Bloc_48_P.Intervalle_T'Succ (I);
      end loop;
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
      bit_resulta, bit_attendu : Bit_IO_T;
      bloc_resultat : Des_P.Bloc_P.Bloc_48_P.Bloc_48_T;
      Clef : Des_P.Clef_P.Clef_48_Simple_P.Clef_S_T;
   begin
      bloc_resultat := T.bloc xor Clef;

      for I in Des_P.Bloc_P.Bloc_48_P.Intervalle_T'Range loop
         bit_resulta := (if bloc_resultat.Lire_Bit (I) then 1 else 0);
         bit_attendu := (if T.bloc.Lire_Bit (I) xor True then 1 else 0);

         AUnit.Assertions.Assert
            (bit_resulta = bit_attendu,
            "Le bit " & I'Img &
            " vaut : " & bit_resulta'Img &
            " au lieu de " & bit_attendu'Img
            );
      end loop;
   end Test_Xor_G_D;

   ---------------------------------------------------------------------------
   procedure Test_Xor_D_G (T : in out Test_Fixt_T) is
      bit_resulta, bit_attendu : Bit_IO_T;
      bloc_resultat : Des_P.Bloc_P.Bloc_48_P.Bloc_48_T;
      Clef : Des_P.Clef_P.Clef_48_Simple_P.Clef_S_T;
   begin
      bloc_resultat := T.bloc xor Clef;

      for I in Des_P.Bloc_P.Bloc_48_P.Intervalle_T'Range loop
         bit_resulta := (if bloc_resultat.Lire_Bit (I) then 1 else 0);
         bit_attendu := (if T.bloc.Lire_Bit (I) xor True then 1 else 0);

         AUnit.Assertions.Assert
            (bit_resulta = bit_attendu,
            "Le bit " & I'Img &
            " vaut : " & bit_resulta'Img &
            " au lieu de " & bit_attendu'Img
            );
      end loop;
   end Test_Xor_D_G;

end Des_P.Bloc_Xor_Clef_P.Test_P;
