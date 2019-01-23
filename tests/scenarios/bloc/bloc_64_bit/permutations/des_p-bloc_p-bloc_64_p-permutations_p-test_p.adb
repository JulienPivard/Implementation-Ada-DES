with AUnit.Assertions;

package body Des_P.Bloc_P.Bloc_64_P.Permutations_P.Test_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      b : Bloc_64_T;
   begin
      T.bloc := b;
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
   procedure Test_Permutations_Entrantes
      (T : in out Test_Fixt_T)
   is
      --  Nombre de départ
      --  11110000 11110000 11110000 11110000
      --  11110000 11110000 11110000 11110000
      depart : constant array (Intervalle_T) of Bit_T :=
         (
            True, True, True, True, False, False, False, False,
            True, True, True, True, False, False, False, False,
            True, True, True, True, False, False, False, False,
            True, True, True, True, False, False, False, False,
            True, True, True, True, False, False, False, False,
            True, True, True, True, False, False, False, False,
            True, True, True, True, False, False, False, False,
            True, True, True, True, False, False, False, False
         );
      --  Valeur attendu
      --  11111111 11111111 00000000 00000000
      --  11111111 11111111 00000000 00000000
      attendu : constant array (Intervalle_T) of Bit_T :=
         (
            True, True, True, True, True, True, True, True,
            True, True, True, True, True, True, True, True,
            False, False, False, False, False, False, False, False,
            False, False, False, False, False, False, False, False,
            True, True, True, True, True, True, True, True,
            True, True, True, True, True, True, True, True,
            False, False, False, False, False, False, False, False,
            False, False, False, False, False, False, False, False
         );
   begin
      for I in Intervalle_T'Range loop
         T.bloc.Ecrire_Bit (I, depart (I));
      end loop;

      Permutation_Entrante (T.bloc);

      for I in Intervalle_T'Range loop
         declare
            b : constant Bit_T := T.bloc.Lire_Bit (I);
            bit_resulta : constant Bit_IO_T := (if b then 1 else 0);
            bit_attendu : constant Bit_IO_T := (if attendu (I) then 1 else 0);
         begin
            AUnit.Assertions.Assert
               (bit_resulta = bit_attendu,
               "Le bit " & I'Img &
               " vaut : " & bit_resulta'Img &
               " au lieu de " & bit_attendu'Img
               );
         end;
      end loop;

   end Test_Permutations_Entrantes;

   ---------------------------------------------------------------------------
   procedure Test_Permutations_Sortantes
      (T : in out Test_Fixt_T)
   is
      --  Nombre de départ
      --  11110000 11110000 11110000 11110000
      --  11110000 11110000 11110000 11110000
      depart : constant array (Intervalle_T) of Bit_T :=
         (
            True, True, True, True, False, False, False, False,
            True, True, True, True, False, False, False, False,
            True, True, True, True, False, False, False, False,
            True, True, True, True, False, False, False, False,
            True, True, True, True, False, False, False, False,
            True, True, True, True, False, False, False, False,
            True, True, True, True, False, False, False, False,
            True, True, True, True, False, False, False, False
         );
      --  Valeur attendue
      --  00000000 00000000 00000000 00000000
      --  11111111 11111111 11111111 11111111
      attendu : constant array (Intervalle_T) of Bit_T :=
         (
            False, False, False, False, False, False, False, False,
            False, False, False, False, False, False, False, False,
            False, False, False, False, False, False, False, False,
            False, False, False, False, False, False, False, False,
            True, True, True, True, True, True, True, True,
            True, True, True, True, True, True, True, True,
            True, True, True, True, True, True, True, True,
            True, True, True, True, True, True, True, True
         );
   begin
      for I in Intervalle_T'Range loop
         T.bloc.Ecrire_Bit (I, depart (I));
      end loop;

      Permutation_Sortante (T.bloc);

      for I in Intervalle_T'Range loop
         declare
            b : constant Bit_T := T.bloc.Lire_Bit (I);
            bit_resulta : constant Bit_IO_T := (if b then 1 else 0);
            bit_attendu : constant Bit_IO_T := (if attendu (I) then 1 else 0);
         begin
            AUnit.Assertions.Assert
               (bit_resulta = bit_attendu,
               "Le bit " & I'Img &
               " vaut : " & bit_resulta'Img &
               " au lieu de " & bit_attendu'Img
               );
         end;
      end loop;

   end Test_Permutations_Sortantes;

end Des_P.Bloc_P.Bloc_64_P.Permutations_P.Test_P;
