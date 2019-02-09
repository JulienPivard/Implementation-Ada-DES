with AUnit.Assertions;

with Ada.Numerics.Discrete_Random;
with Des_P.Clef_P.Clef_48_I_P;

package body Des_P.Clef_P.Clef_48_P.Test_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      C : Clef_T;
   begin
      C.Bits := Tableau_Bits_T'(others => False);
      T.Clef := C;
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
   procedure Test_Lecture_Bit (T : in out Test_Fixt_T) is
      Bits_Attendu : constant Tableau_Bits_T :=
         Tableau_Bits_T'
         (
            Intervalle_1_T | Intervalle_2_T | Intervalle_3_T |
            Intervalle_4_T | Intervalle_5_T | Intervalle_6_T => False,
            others => True
         );
   begin
      T.Clef.Bits := Tableau_Bits_T'
         (
            Intervalle_1_T | Intervalle_2_T | Intervalle_3_T |
            Intervalle_4_T | Intervalle_5_T | Intervalle_6_T => False,
            others => True
         );
      for I in Des_P.Clef_P.Clef_48_I_P.Intervalle_T loop
         AUnit.Assertions.Assert
            (T.Clef.Lire_Bit (I) = Bits_Attendu (I),
            "Le bit " & I'Img &
            " vaut : " & T.Clef.Lire_Bit (I)'Img &
            " au lieu de " & Bits_Attendu (I)'Img
            );
      end loop;
   end Test_Lecture_Bit;

   ---------------------------------------------------------------------------
   procedure Test_Bits_Aleatoire (T : in out Test_Fixt_T) is
      B : Bit_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      Generateur : Bit_Aleatoire.Generator;
      Bits_Attendu : Tableau_Bits_T;
   begin
      Bit_Aleatoire.Reset (Generateur);
      for I in Des_P.Clef_P.Clef_48_I_P.Intervalle_T loop
         B := Bit_Aleatoire.Random (Generateur);
         Bits_Attendu (I) := B;
         T.Clef.Bits (I) := B;
      end loop;
      for I in Des_P.Clef_P.Clef_48_I_P.Intervalle_T loop
         AUnit.Assertions.Assert
            (T.Clef.Lire_Bit (I) = Bits_Attendu (I),
            "Le bit " & I'Img &
            " vaut : " & T.Clef.Lire_Bit (I)'Img &
            " au lieu de " & Bits_Attendu (I)'Img
            );
      end loop;
   end Test_Bits_Aleatoire;

end Des_P.Clef_P.Clef_48_P.Test_P;
