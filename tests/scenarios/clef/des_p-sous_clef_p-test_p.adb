with AUnit.Assertions;

with Ada.Numerics.Discrete_Random;

package body Des_P.Sous_Clef_P.Test_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      C : Sous_Clef_T;
   begin
      C.Bits := (others => 0);
      T.sous_clef := C;
   end Set_Up;

   ---------------------------------------------------------------------------
   overriding
   procedure Tear_Down (T : in out Test_Fixt_T) is
   begin
      null;
   end Tear_Down;

   ---------------------------------------------------------------------------
   procedure Test_Lecture_Bit (T : in out Test_Fixt_T) is
      bits_attendu : constant Tableau_Bits_T :=
         (1 .. 4 | 9 .. 12 | 17 .. 20 | 25 .. 28 | 33 .. 36 | 41 .. 44 => 1,
         others => 0);
   begin
      T.sous_clef.Bits :=
         (1 .. 4 | 9 .. 12 | 17 .. 20 | 25 .. 28 | 33 .. 36 | 41 .. 44 => 1,
         others => 0);
      for I in Interval_Sous_Clef_T'Range loop
         AUnit.Assertions.Assert
            (T.sous_clef.Lire_Bit (I) = bits_attendu (I),
            "Le bit " & I'Img &
            " vaut : " & T.sous_clef.Lire_Bit (I)'Img &
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
      for I in Interval_Sous_Clef_T'Range loop
         b := Bit_Aleatoire.Random (generateur);
         bits_attendu (I) := b;
         T.sous_clef.Bits (I) := b;
      end loop;
      for I in Interval_Sous_Clef_T'Range loop
         AUnit.Assertions.Assert
            (T.sous_clef.Lire_Bit (I) = bits_attendu (I),
            "Le bit " & I'Img &
            " vaut : " & T.sous_clef.Lire_Bit (I)'Img &
            " au lieu de " & bits_attendu (I)'Img
            );
      end loop;
   end Test_Bits_Aleatoire;

end Des_P.Sous_Clef_P.Test_P;
