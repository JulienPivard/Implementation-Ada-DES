with AUnit.Assertions;

with Ada.Numerics.Discrete_Random;

with Des_P.Clef_P.Clef_64_I_P;

package body Des_P.Clef_P.Clef_64_P.Test_P is

   --  La clef de 64 bits:
   --  1111 0000 1111 0000 1111 0000 1111 0000
   --  1    5    9    13   17   21   25   29
   --  1111 0000 1111 0000 1111 0000 1111 0000
   --  33   37   41   45   49   53   57   61
   bits_64_attendu : constant Tableau_Bits_T :=
      (
         Intervalle_1_T | Intervalle_2_T | Intervalle_3_T |
         Intervalle_4_T | Intervalle_5_T | Intervalle_6_T |
         Intervalle_7_T | Intervalle_8_T => False,
         others => True
      );

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up
      (T : in out Test_Fixt_T)
   is
      clef_64 : Clef_T;
   begin
      clef_64.Bits :=
      (
         Intervalle_1_T | Intervalle_2_T | Intervalle_3_T |
         Intervalle_4_T | Intervalle_5_T | Intervalle_6_T |
         Intervalle_7_T | Intervalle_8_T => False,
         others => True
      );
      T.clef_64 := clef_64;
   end Set_Up;

   ---------------------------------------------------------------------------
   overriding
   procedure Tear_Down
      (T : in out Test_Fixt_T)
   is
   begin
      null;
   end Tear_Down;

   ---------------------------------------------------------------------------
   --                              scénarios                                --
   ---------------------------------------------------------------------------
   ---------------------------------------------------------------------------
   procedure Test_Lecture_Bit
      (T : in out Test_Fixt_T)
   is
      bit_lu : Bit_T;
      bit_attendu : Bit_T;
   begin
      for I in Des_P.Clef_P.Clef_64_I_P.Intervalle_T loop
         bit_lu := T.clef_64.Lire_Bit (I);
         bit_attendu := bits_64_attendu (I);
         AUnit.Assertions.Assert
         (
            bit_lu = bit_attendu,
            "Le bit " & I'Img &
            " vaut : " & bit_lu'Img &
            " au lieu de " & bit_attendu'Img
         );
      end loop;
   end Test_Lecture_Bit;

   ---------------------------------------------------------------------------
   procedure Test_Bits_Aleatoire
      (T : in out Test_Fixt_T)
   is
      b : Bit_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      generateur : Bit_Aleatoire.Generator;
      bits_attendu : Tableau_Bits_T;
      bit_lu : Bit_T;
      bit_attendu : Bit_T;
   begin
      Bit_Aleatoire.Reset (generateur);
      for I in Des_P.Clef_P.Clef_64_I_P.Intervalle_T loop
         b := Bit_Aleatoire.Random (generateur);
         bits_attendu (I) := b;
         T.clef_64.Bits (I) := b;
      end loop;
      for I in Des_P.Clef_P.Clef_64_I_P.Intervalle_T loop
         bit_lu := T.clef_64.Lire_Bit (I);
         bit_attendu := bits_attendu (I);
         AUnit.Assertions.Assert
         (
            bit_lu = bit_attendu,
            "Le bit " & I'Img &
            " vaut : " & bit_lu'Img &
            " au lieu de " & bit_attendu'Img
         );
      end loop;
   end Test_Bits_Aleatoire;

end Des_P.Clef_P.Clef_64_P.Test_P;
