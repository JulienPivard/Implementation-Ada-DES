with AUnit.Assertions;

with Des_P.Bloc_P.Bloc_64_P;
with Des_P.Clef_P.Clef_56_Abs_P.Clef_Simplifie_P;

package body Des_P.Filtre_P.Sortie_P.Sortie_Cryptage_P.Test_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      Filtre : Sortie_T;
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
   procedure Test_Permutation_Sortante
      (T : in out Test_Fixt_T)
   is
      --  Nombre de départ
      --  11110000 11110000 11110000 11110000
      --  11110000 11110000 11110000 11110000
      Depart : constant array
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
      --  Valeur attendue
      --  00000000 00000000 00000000 00000000
      --  11111111 11111111 11111111 11111111
      Attendu : constant array
         (Des_P.Bloc_P.Bloc_64_P.Intervalle_Bloc_64_T)
         of Des_P.Bloc_P.Bit_T :=
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
      Bloc : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
      Clef : Des_P.Clef_P.Clef_56_Abs_P.Clef_Simplifie_P.Clef_Simplifie_T;
   begin

      for I in Des_P.Bloc_P.Bloc_64_P.Intervalle_Bloc_64_T'Range loop
         Bloc.Ecrire_Bit (I, Depart (I));
      end loop;

      T.Filtre.Filtrer (Bloc, Clef);

      for I in Des_P.Bloc_P.Bloc_64_P.Intervalle_Bloc_64_T'Range loop
         declare
            B : constant Des_P.Bloc_P.Bit_T := Bloc.Lire_Bit (I);
            Bit_Resulta : constant Bit_IO_T := (if B then 1 else 0);
            Bit_Attendu : constant Bit_IO_T := (if Attendu (I) then 1 else 0);
         begin
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img
               );
         end;
      end loop;

   end Test_Permutation_Sortante;

end Des_P.Filtre_P.Sortie_P.Sortie_Cryptage_P.Test_P;
