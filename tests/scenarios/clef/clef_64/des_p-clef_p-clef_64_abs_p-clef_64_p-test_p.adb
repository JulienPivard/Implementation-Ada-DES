with AUnit.Assertions;

with Ada.Numerics.Discrete_Random;

with Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Constructeur_48_P;
with Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Constructeur_56_P;
with Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P;
with Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P;
with Des_P.Clef_P.Clef_48_Abs_P;
with Des_P.Clef_P.Clef_56_Abs_P;

package body Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P.Test_P is

   use Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P;
   use Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P;
   use Des_P.Clef_P.Clef_48_Abs_P;
   use Des_P.Clef_P.Clef_56_Abs_P;

   --  La clef de 64 bits:
   --  1111 0000 1111 0000 1111 0000 1111 0000
   --  1    5    9    13   17   21   25   29
   --  1111 0000 1111 0000 1111 0000 1111 0000
   --  33   37   41   45   49   53   57   61
   bits_64_attendu : constant Tableau_Bits_T :=
      (
         1 .. 4 | 9 .. 12 | 17 .. 20 | 25 .. 28 | 33 .. 36 |
         41 .. 44 | 49 .. 52 | 57 .. 60 => False, others => True
      );

   --  La bits clef de 56 bits attendu après construction avec la
   --  clef de 64 bits ci-dessus.
   --  1111 1111 1111 1111 1111 1111 1111
   --  1    5    9    13   17   21   25
   --  0000 0000 0000 0000 0000 0000 1111
   --  29   33   37   41   45   49   53
   bits_56_attendu : constant array (Intervalle_Clef_56_T) of Bit_T :=
      (
         False, False, False, False, False, False, False,
         False, False, False, False, False, False, False,
         False, False, False, False, False, False, False,
         False, False, False, False, False, False, False,
         True, True, True, True, True, True, True,
         True, True, True, True, True, True, True,
         True, True, True, True, True, True, True,
         True, True, True, False, False, False, False
      );

   --  La bits clef de 48 bits attendu après construction avec la
   --  clef de 56 bits ci-dessus.
   --  1111 1111 1111 1111 1111 1111
   --  False    5    9    13   17   21
   --  0000 0100 0000 0001 0100 0000
   --  25   29   33   37   41   45
   bits_48_attendu : constant array (Intervalle_Clef_48_T) of Bit_T :=
      (
         False, False, False, False, False, False,
         False, False, False, False, False, False,
         False, False, False, False, False, False,
         False, False, False, False, False, False,
         True, True, True, True, True, False,
         True, True, True, True, True, True,
         True, True, True, False, True, False,
         True, True, True, True, True, True
      );

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      use Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Constructeur_48_P;
      constr_48 : constant access Constructeur_Clef_48_T :=
         new Constructeur_Clef_48_T;
      use Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Constructeur_56_P;
      constr_56 : constant access Constructeur_Clef_56_T :=
         new Constructeur_Clef_56_T;
      clef_64 : Clef_64_T;
   begin
      clef_64.Bits :=
      (
         1 .. 4 | 9 .. 12 | 17 .. 20 | 25 .. 28 | 33 .. 36 |
         41 .. 44 | 49 .. 52 | 57 .. 60 => False, others => True
      );
      clef_64.Constructeur_48 := constr_48;
      clef_64.Constructeur_56 := constr_56;
      T.clef_64 := clef_64;
   end Set_Up;

   ---------------------------------------------------------------------------
   overriding
   procedure Tear_Down (T : in out Test_Fixt_T) is
   begin
      T.clef_64.Constructeur_48 := null;
      T.clef_64.Constructeur_56 := null;
   end Tear_Down;

   ---------------------------------------------------------------------------
   --                              scénarios                                --
   ---------------------------------------------------------------------------
   ---------------------------------------------------------------------------
   procedure Test_Possede_Constructeur_56 (T : in out Test_Fixt_T) is
   begin
      AUnit.Assertions.Assert
         (T.clef_64.Possede_Constructeur_56,
         "La clef devrait posseder un constructeur 56 bits, " &
         "mais n'en a pas."
         );
      T.clef_64.Constructeur_56 := null;
      AUnit.Assertions.Assert
         (not T.clef_64.Possede_Constructeur_56,
         "La clef ne devrait pas posseder un " &
         "constructeur 56 bits, mais en a un."
         );
   end Test_Possede_Constructeur_56;

   ---------------------------------------------------------------------------
   procedure Test_Possede_Constructeur_48 (T : in out Test_Fixt_T) is
   begin
      AUnit.Assertions.Assert
         (T.clef_64.Possede_Constructeur_48,
         "La clef devrait posseder un constructeur 48 bits, " &
         "mais n'en a pas."
         );
      T.clef_64.Constructeur_48 := null;
      AUnit.Assertions.Assert
         (not T.clef_64.Possede_Constructeur_48,
         "La clef ne devrait pas posseder un " &
         "constructeur 48 bits, mais en a un."
         );
   end Test_Possede_Constructeur_48;

   ---------------------------------------------------------------------------
   procedure Test_Construire_Clef_56_Exception (T : in out Test_Fixt_T) is
      pragma Unreferenced (T);
      Exception_Constructeur_56_Absent : constant
         AUnit.Assertions.Throwing_Exception_Proc :=
         Declencher_Exception_Constructeur_56'Access;
   begin
      AUnit.Assertions.Assert_Exception
      (
         Exception_Constructeur_56_Absent,
         "La clef ne devrait pas posséder de constructeur 48"
      );
   end Test_Construire_Clef_56_Exception;

   ---------------------------------------------------------------------------
   procedure Test_Construire_Clef_56 (T : in out Test_Fixt_T) is
      clef_56 : constant Clef_56_T := T.clef_64.Lire_Clef_56;
      bit_lu : Bit_T;
      bit_attendu : Bit_T;
   begin
      for I in Intervalle_Clef_56_T'Range loop
         bit_lu := clef_56.Lire_Bit (I);
         bit_attendu := bits_56_attendu (I);
         AUnit.Assertions.Assert
         (
            bit_lu = bit_attendu,
            "Le bit " & I'Img &
            " vaut " & bit_lu'Img &
            " au lieu de " & bit_attendu'Img
         );
      end loop;
   end Test_Construire_Clef_56;

   ---------------------------------------------------------------------------
   procedure Test_Construire_Clef_48_Via_56 (T : in out Test_Fixt_T) is
      clef_56 : constant Clef_56_T := T.clef_64.Lire_Clef_56;
      clef_48 : constant Clef_48_T := clef_56.Lire_Clef_48;
      bit_lu : Bit_T;
      bit_attendu : Bit_T;
   begin
      for I in Intervalle_Clef_48_T'Range loop
         bit_lu := clef_48.Lire_Bit (I);
         bit_attendu := bits_48_attendu (I);
         AUnit.Assertions.Assert
         (
            bit_lu = bit_attendu,
            "Le bit " & I'Img &
            " vaut " & bit_lu'Img &
            " au lieu de " & bit_attendu'Img
         );
      end loop;
   end Test_Construire_Clef_48_Via_56;

   ---------------------------------------------------------------------------
   procedure Test_Lecture_Bit (T : in out Test_Fixt_T) is
      bit_lu : Bit_T;
      bit_attendu : Bit_T;
   begin
      for I in Intervalle_Clef_64_T'Range loop
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
   procedure Test_Bits_Aleatoire (T : in out Test_Fixt_T) is
      b : Bit_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      generateur : Bit_Aleatoire.Generator;
      bits_attendu : Tableau_Bits_T;
      bit_lu : Bit_T;
      bit_attendu : Bit_T;
   begin
      Bit_Aleatoire.Reset (generateur);
      for I in Intervalle_Clef_64_T'Range loop
         b := Bit_Aleatoire.Random (generateur);
         bits_attendu (I) := b;
         T.clef_64.Bits (I) := b;
      end loop;
      for I in Intervalle_Clef_64_T'Range loop
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

   ---------------------------------------------------------------------------
   --                         Procédure d'exception                         --
   ---------------------------------------------------------------------------
   procedure Declencher_Exception_Constructeur_56 is
      c : Clef_56_T;
      clef_64 : Clef_64_T;
   begin
      c := clef_64.Lire_Clef_56;
      pragma Unreferenced (c);
   end Declencher_Exception_Constructeur_56;

end Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P.Test_P;
