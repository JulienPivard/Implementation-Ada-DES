with AUnit.Assertions;

with Ada.Numerics.Discrete_Random;

with Des_P.Clef_P.Clef_64_I_P;

package body Des_P.Clef_P.Clef_64_P.Test_P is

   --  La clef de 64 bits:
   --  1111 0000 1111 0000 1111 0000 1111 0000
   --  1    5    9    13   17   21   25   29
   --  1111 0000 1111 0000 1111 0000 1111 0000
   --  33   37   41   45   49   53   57   61
   Bits_64_Attendu : constant Tableau_Bits_T :=
      Tableau_Bits_T'
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
      Clef_64 : Clef_T;
   begin
      Clef_64.Bits :=
         Tableau_Bits_T'
         (
            Intervalle_1_T | Intervalle_2_T | Intervalle_3_T |
            Intervalle_4_T | Intervalle_5_T | Intervalle_6_T |
            Intervalle_7_T | Intervalle_8_T => False,
            others => True
         );
      T.Clef_64 := Clef_64;
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
      Bit_Lu : Bit_T;
      Bit_Attendu : Bit_T;
   begin
      for I in Des_P.Clef_P.Clef_64_I_P.Intervalle_T loop
         Bit_Lu := T.Clef_64.Lire_Bit (I);
         Bit_Attendu := Bits_64_Attendu (I);
         AUnit.Assertions.Assert
         (
            Bit_Lu = Bit_Attendu,
            "Le bit " & I'Img &
            " vaut : " & Bit_Lu'Img &
            " au lieu de " & Bit_Attendu'Img
         );
      end loop;
   end Test_Lecture_Bit;

   ---------------------------------------------------------------------------
   procedure Test_Bits_Aleatoire
      (T : in out Test_Fixt_T)
   is
      B : Bit_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      Generateur : Bit_Aleatoire.Generator;
      Bits_Attendu : Tableau_Bits_T;
      Bit_Lu : Bit_T;
      Bit_Attendu : Bit_T;
   begin
      Bit_Aleatoire.Reset (Generateur);
      for I in Des_P.Clef_P.Clef_64_I_P.Intervalle_T loop
         B := Bit_Aleatoire.Random (Generateur);
         Bits_Attendu (I) := B;
         T.Clef_64.Bits (I) := B;
      end loop;
      for I in Des_P.Clef_P.Clef_64_I_P.Intervalle_T loop
         Bit_Lu := T.Clef_64.Lire_Bit (I);
         Bit_Attendu := Bits_Attendu (I);
         AUnit.Assertions.Assert
         (
            Bit_Lu = Bit_Attendu,
            "Le bit " & I'Img &
            " vaut : " & Bit_Lu'Img &
            " au lieu de " & Bit_Attendu'Img
         );
      end loop;
   end Test_Bits_Aleatoire;

end Des_P.Clef_P.Clef_64_P.Test_P;
