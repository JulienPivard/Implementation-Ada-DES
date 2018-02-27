with AUnit.Assertions;

with Des_P.Bloc_P.Bloc_64_P;
with Des_P.Clef_P.Clef_56_I_P;
with Des_P.Filtre_P.Clef_Tests_P;

with Des_P.Clef_P.Clef_48_Simplifie_P;
with Des_P.Clef_P.Clef_48_Simple_P;

package body Des_P.Filtre_P.Corps_P.Cryptage_P.Test_P is

   --  Nombre de départ
   --  00001111 00001111 00001111 00001111
   --  00001111 00001111 00001111 00001111
   depart : constant array
      (Des_P.Bloc_P.Bloc_64_P.Intervalle_Bloc_64_T)
      of Des_P.Bloc_P.Bit_T :=
      (
         False, False, False, False, True, True, True, True,
         False, False, False, False, True, True, True, True,
         False, False, False, False, True, True, True, True,
         False, False, False, False, True, True, True, True,
         False, False, False, False, True, True, True, True,
         False, False, False, False, True, True, True, True,
         False, False, False, False, True, True, True, True,
         False, False, False, False, True, True, True, True
      );

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      Filtre : Corps_T;
      Bloc : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
      Clef : Des_P.Clef_P.Clef_64_Simplifie_P.Clef_S_T;
   begin

      for I in Des_P.Bloc_P.Bloc_64_P.Intervalle_Bloc_64_T'Range loop
         Bloc.Ecrire_Bit (I, depart (I));
      end loop;

      T.Filtre := Filtre;
      T.Bloc := Bloc;

      Clef.Init (Des_P.Filtre_P.Clef_Tests_P.Contenu_Clef);
      T.Clef := Clef;

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
   procedure Test_Cryptage_Niveau_1
      (T : in out Test_Fixt_T)
   is
      --  Valeur attendu
      --  00001111 00001111 00001111 00001111
      --  00010100 01010111 11010011 10110101
      attendu : constant array
         (Des_P.Bloc_P.Bloc_64_P.Intervalle_Bloc_64_T)
         of Des_P.Bloc_P.Bit_T :=
         (
            False, False, False, False, True, True, True, True,
            False, False, False, False, True, True, True, True,
            False, False, False, False, True, True, True, True,
            False, False, False, False, True, True, True, True, --  Bloc droit
            False, False, False, True, False, True, False, False,
            False, True, False, True, False, True, True, True,
            True, True, False, True, False, False, True, True,
            True, False, True, True, False, True, False, True
         );

      use type Des_P.Clef_P.Clef_56_I_P.Decalage_T;

      --  Valeur attendu
      --  11111100 0X001100 00X110X1 0X01 1110 100X10X1 100X1001 011000X1
      Bloc : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T := T.Bloc;
      Champs_48 : constant
      Des_P.Clef_P.Clef_48_Simplifie_P.Champ_De_Bits_T :=
         (
            False, False, False, False, True, True, True, True,
            False, False, False, False, True, True, True, True,
            False, False, False, False, True, True, True, True,
            False, False, False, False, True, True, True, True,
            False, False, False, False, True, True, True, True,
            False, False, False, False, True, True, True, True
         );
      Clef_48 : Des_P.Clef_P.Clef_48_Simplifie_P.Clef_S_T;
   begin

      Clef_48.Init (Champs_48);
      T.Filtre.Modifier_Clef (Clef_48);
      T.Filtre.Filtrer (Bloc);

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

   end Test_Cryptage_Niveau_1;

   ---------------------------------------------------------------------------
   procedure Test_Modifier_Clef_48
      (T : in out Test_Fixt_T)
   is
      C : Des_P.Clef_P.Clef_48_Simple_P.Clef_S_T;
   begin
      AUnit.Assertions.Assert
         (T.Filtre.Clef.Is_Empty,
         "L'estage ne devrait pas posseder de clef."
         );
      T.Filtre.Modifier_Clef (C);
      AUnit.Assertions.Assert
         (T.Filtre.Clef.Is_Empty = False,
         "L'estage devrait posseder une clef."
         );
   end Test_Modifier_Clef_48;

end Des_P.Filtre_P.Corps_P.Cryptage_P.Test_P;