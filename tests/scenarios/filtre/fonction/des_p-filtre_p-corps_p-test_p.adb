with AUnit.Assertions;

with Des_P.Clef_P.Clef_48_Simplifie_P;

package body Des_P.Filtre_P.Corps_P.Test_P is

   --  Nombre de départ
   --  11110000 11110000 11110000 11110000
   depart : constant array
      (Des_P.Bloc_P.Bloc_32_P.Intervalle_T)
      of Des_P.Bloc_P.Bit_T :=
      (
         False, False, False, False, True, True, True, True,
         False, False, False, False, True, True, True, True,
         False, False, False, False, True, True, True, True,
         False, False, False, False, True, True, True, True
      );

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      Bloc : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;
   begin

      for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T'Range loop
         Bloc.Ecrire_Bit (I, depart (I));
      end loop;
      T.Bloc := Bloc;

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
   procedure Test_Fonction_F (T : in out Test_Fixt_T) is
      --  Valeur attendu
      --  00011011 01011000
      --  11011100 10111010
      attendu : constant array
         (Des_P.Bloc_P.Bloc_32_P.Intervalle_T)
         of Des_P.Bloc_P.Bit_T :=
         (
            False, False, False, True, True, False, True, True,
            False, True, False, True, True, False, False, False,
            True, True, False, True, True, True, False, False,
            True, False, True, True, True, False, True, False
         );
      C : constant Des_P.Clef_P.Clef_48_Simplifie_P.Champ_De_Bits_T :=
         (
            False, False, False, False, True, True, True, True,
            False, False, False, False, True, True, True, True,
            False, False, False, False, True, True, True, True,
            False, False, False, False, True, True, True, True,
            False, False, False, False, True, True, True, True,
            False, False, False, False, True, True, True, True
         );
      Clef : Des_P.Clef_P.Clef_48_Simplifie_P.Clef_S_T;
      Bloc : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;
   begin

      Clef.Init (C);

      Bloc := Fonction_F (T.Bloc, Clef);

      for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T'Range loop
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

   end Test_Fonction_F;

end Des_P.Filtre_P.Corps_P.Test_P;
