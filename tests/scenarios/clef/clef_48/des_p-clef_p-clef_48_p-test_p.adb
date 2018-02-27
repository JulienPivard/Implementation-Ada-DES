with AUnit.Assertions;

with Ada.Numerics.Discrete_Random;
with Des_P.Clef_P.Clef_48_I_P;

package body Des_P.Clef_P.Clef_48_P.Test_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      C : Clef_T;
   begin
      C.Bits := (others => False);
      T.clef_48 := C;
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
      bits_attendu : constant Tableau_Bits_T :=
         (1 .. 4 | 9 .. 12 | 17 .. 20 | 25 .. 28 |
         33 .. 36 | 41 .. 44 => False, others => True);
   begin
      T.clef_48.Bits :=
         (1 .. 4 | 9 .. 12 | 17 .. 20 | 25 .. 28 |
         33 .. 36 | 41 .. 44 => False, others => True);
      for I in Des_P.Clef_P.Clef_48_I_P.Intervalle_T'Range loop
         AUnit.Assertions.Assert
            (T.clef_48.Lire_Bit (I) = bits_attendu (I),
            "Le bit " & I'Img &
            " vaut : " & T.clef_48.Lire_Bit (I)'Img &
            " au lieu de " & bits_attendu (I)'Img
            );
      end loop;
   end Test_Lecture_Bit;

   ---------------------------------------------------------------------------
   procedure Test_Bits_Aleatoire (T : in out Test_Fixt_T) is
      b : Bit_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      generateur : Bit_Aleatoire.Generator;
      bits_attendu : Tableau_Bits_T;
   begin
      Bit_Aleatoire.Reset (generateur);
      for I in Des_P.Clef_P.Clef_48_I_P.Intervalle_T'Range loop
         b := Bit_Aleatoire.Random (generateur);
         bits_attendu (I) := b;
         T.clef_48.Bits (I) := b;
      end loop;
      for I in Des_P.Clef_P.Clef_48_I_P.Intervalle_T'Range loop
         AUnit.Assertions.Assert
            (T.clef_48.Lire_Bit (I) = bits_attendu (I),
            "Le bit " & I'Img &
            " vaut : " & T.clef_48.Lire_Bit (I)'Img &
            " au lieu de " & bits_attendu (I)'Img
            );
      end loop;
   end Test_Bits_Aleatoire;

end Des_P.Clef_P.Clef_48_P.Test_P;
