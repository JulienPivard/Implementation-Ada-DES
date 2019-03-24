with AUnit.Assertions;

package body Des_P.Bloc_P.Bloc_64_P.Permutations_P.Test_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      B : Bloc_64_T;
   begin
      T.Bloc := B;
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
      Depart : constant Tableau_Bits_64_T :=
         Tableau_Bits_64_T'
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
      --  Valeur Attendu
      --  11111111 11111111 00000000 00000000
      --  11111111 11111111 00000000 00000000
      Attendu : constant Tableau_Bits_64_T :=
         Tableau_Bits_64_T'
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
      for I in Intervalle_T loop
         T.Bloc.Ecrire_Bit (I, Depart (I));
      end loop;

      Permutation_Entrante (T.Bloc);

      for I in Intervalle_T loop
         Verification_Bit :
         declare
            B : constant Bit_T := T.Bloc.Lire_Bit (I);
            Bit_Resulta : constant Bit_IO_T := (if B then 1 else 0);
            Bit_Attendu : constant Bit_IO_T := (if Attendu (I) then 1 else 0);
         begin
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img
               );
         end Verification_Bit;
      end loop;

   end Test_Permutations_Entrantes;

   ---------------------------------------------------------------------------
   procedure Test_Permutations_Sortantes
      (T : in out Test_Fixt_T)
   is
      --  Nombre de départ
      --  11110000 11110000 11110000 11110000
      --  11110000 11110000 11110000 11110000
      Depart : constant Tableau_Bits_64_T :=
         Tableau_Bits_64_T'
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
      Attendu : constant Tableau_Bits_64_T :=
         Tableau_Bits_64_T'
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
      for I in Intervalle_T loop
         T.Bloc.Ecrire_Bit (I, Depart (I));
      end loop;

      Permutation_Sortante (T.Bloc);

      for I in Intervalle_T loop
         Verification_Bit :
         declare
            B : constant Bit_T := T.Bloc.Lire_Bit (I);
            Bit_Resulta : constant Bit_IO_T := (if B then 1 else 0);
            Bit_Attendu : constant Bit_IO_T := (if Attendu (I) then 1 else 0);
         begin
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img
               );
         end Verification_Bit;
      end loop;

   end Test_Permutations_Sortantes;

end Des_P.Bloc_P.Bloc_64_P.Permutations_P.Test_P;
