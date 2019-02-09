with AUnit.Assertions;

with Des_P.Clef_P.Clef_48_Simplifie_P;

package body Des_P.Filtre_P.Corps_P.Test_P is

   --  Nombre de départ
   --  11110000 11110000 11110000 11110000
   Depart : constant array
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

      for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
         Bloc.Ecrire_Bit (I, Depart (I));
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
      Attendu : constant array
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

      for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
         Verification_Bit :
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
         end Verification_Bit;
      end loop;

   end Test_Fonction_F;

end Des_P.Filtre_P.Corps_P.Test_P;
