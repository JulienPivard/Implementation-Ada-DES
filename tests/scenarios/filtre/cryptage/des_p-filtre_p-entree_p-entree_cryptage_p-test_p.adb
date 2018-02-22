with AUnit.Assertions;

with Des_P.Bloc_P.Bloc_64_P;
with Des_P.Clef_P.Clef_48_Abs_P.Clef_48_Simple_P;

package body Des_P.Filtre_P.Entree_P.Entree_Cryptage_P.Test_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      Filtre : Entree_T;
   begin
      T.Filtre := Filtre;
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
   procedure Test_Permutation_Initial
      (T : in out Test_Fixt_T)
   is
      --  Nombre de départ
      --  11110000 11110000 11110000 11110000
      --  11110000 11110000 11110000 11110000
      depart : constant array
         (Des_P.Bloc_P.Bloc_64_P.Intervalle_Bloc_64_T)
         of Des_P.Bloc_P.Bit_T :=
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
      attendu : constant array
         (Des_P.Bloc_P.Bloc_64_P.Intervalle_Bloc_64_T)
         of Des_P.Bloc_P.Bit_T :=
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
      Bloc : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
      Clef : Des_P.Clef_P.Clef_48_Abs_P.Clef_48_Simple_P.Clef_48_Simplifie_T;
   begin

      for I in Des_P.Bloc_P.Bloc_64_P.Intervalle_Bloc_64_T'Range loop
         Bloc.Ecrire_Bit (I, depart (I));
      end loop;

      T.Filtre.Filtrer (Bloc, Clef);

      for I in Des_P.Bloc_P.Bloc_64_P.Intervalle_Bloc_64_T'Range loop
         declare
            b : constant Des_P.Bloc_P.Bit_T := Bloc.Lire_Bit (I);
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

   end Test_Permutation_Initial;

end Des_P.Filtre_P.Entree_P.Entree_Cryptage_P.Test_P;
