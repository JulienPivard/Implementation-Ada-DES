with AUnit.Assertions;

with Des_P.Clef_P.Clef_56_I_P;
with Des_P.Clef_P.Clef_48_I_P;
with Des_P.Clef_P.Clef_48_P;

package body Des_P.Clef_P.Clef_56_P.Test_P is

   --  1111 0000 1111 0000 1111 0000 1111 0000 1111 0000 1111 0000 1111 0000
   --  1    5    9    13   17   21   25   29   33   37   41   45   49   53
   c56 : constant array
      (Des_P.Clef_P.Clef_56_I_P.Intervalle_T)
      of Bit_T :=
         (
            1 .. 4 | 9 .. 12 | 17 .. 20 | 25 .. 28 |
            33 .. 36 | 41 .. 44 | 49 .. 52 => False,
            others => True
         );

   --  1110 0001 1110 0001 1110 0001 1111 0001 1110 0001 1110 0001 1110 0000
   --  1    5    9    13   17   21   25   29   33   37   41   45   49   53
   c56_1_decalage : constant array
      (Des_P.Clef_P.Clef_56_I_P.Intervalle_T)
      of Bit_T :=
         (
            1 .. 3 | 8 .. 11 | 16 .. 19 | 24 .. 28 |
            32 .. 35 | 40 .. 43 | 48 .. 51 => False,
            others => True
         );

   --  1100 0011 1100 0011 1100 0011 1111 0011 1100 0011 1100 0011 1100 0000
   --  1    5    9    13   17   21   25   29   33   37   41   45   49   53
   c56_2_decalage : constant array
      (Des_P.Clef_P.Clef_56_I_P.Intervalle_T)
      of Bit_T :=
         (
            1 .. 2 | 7 .. 10 | 15 .. 18 | 23 .. 28 |
            31 .. 34 | 39 .. 42 | 47 .. 50 => False,
            others => True
         );

   --  1000 0111 1000 0111 1000 0111 1111 0111 1000 0111 1000 0111 1000 0000
   --  1    5    9    13   17   21   25   29   33   37   41   45   49   53
   c56_3_decalage : constant array
      (Des_P.Clef_P.Clef_56_I_P.Intervalle_T)
      of Bit_T :=
         (
            1 .. 1 | 6 .. 9 | 14 .. 17 | 22 .. 28 |
            30 .. 33 | 38 .. 41 | 46 .. 49 => False,
            others => True
         );

   --  La clef de 56 bits:
   --  1111 0000 1111 0000 1111 0000 1111 0000 1111 0000 1111 0000 1111 0000
   --  Donne la sous clef suivante :
   --  0110 1011 0001 0111 1000 1101 1100 0000 1010 1100 1001 1100
   c48_0_decalage : constant array
      (Des_P.Clef_P.Clef_48_I_P.Intervalle_T)
      of Bit_T :=
         (
            True, False, False, True, False, True,
            False, False, True, True, True, False,
            True, False, False, False, False, True,
            True, True, False, False, True, False,
            False, False, True, True, True, True,
            True, True, False, True, False, True,
            False, False, True, True, False, True,
            True, False, False, False, True, True
         );

   --  La clef de 56 bits:
   --  1110 0001 1110 0001 1110 0001 1111 0001 1110 0001 1110 0001 1110 0000
   --  Donne la sous clef suivante :
   --  0110 1011 0001 0111 1000 1101 1100 0000 1010 1100 1001 1100
   c48_1_decalage : constant array
      (Des_P.Clef_P.Clef_48_I_P.Intervalle_T)
      of Bit_T :=
         (
            True, False, False, False, False, True,
            False, False, True, True, True, False,
            True, False, True, True, False, False,
            False, True, False, True, True, True,
            False, True, True, True, True, True,
            True, False, False, True, False, False,
            True, False, True, True, False, True,
            True, False, False, True, True, False
         );

   --  La clef de 56 bits:
   --  1100 0011 1100 0011 1100 0011 1111 0011 1100 0011 1100 0011 1100 0000
   --  Donne la sous clef suivante :
   --  0110 1011 0001 0111 1000 1101 1100 0000 1010 1100 1001 1100
   c48_2_decalage : constant array
      (Des_P.Clef_P.Clef_48_I_P.Intervalle_T)
      of Bit_T :=
         (
            True, False, True, False, False, True,
            True, False, False, True, True, False,
            False, True, True, True, False, False,
            False, False, False, True, True, True,
            False, True, False, True, False, True,
            True, False, True, True, False, False,
            True, False, False, True, False, True,
            True, False, False, True, True, False
         );

   --  La clef de 56 bits:
   --  1000 0111 1000 0111 1000 0111 1111 0111 1000 0111 1000 0111 1000 0000
   --  Donne la sous clef suivante :
   --  0110 1011 0001 0111 1000 1101 1100 0000 1010 1100 1001 1100
   c48_3_decalage : constant array
      (Des_P.Clef_P.Clef_48_I_P.Intervalle_T)
      of Bit_T :=
         (
            False, False, True, False, False, True,
            True, False, False, False, True, True,
            False, True, True, True, False, False,
            False, False, False, True, True, True,
            False, True, False, True, False, True,
            False, False, True, True, False, False,
            True, False, False, True, True, True,
            False, True, True, True, True, False
         );

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up
      (T : in out Test_Fixt_T)
   is
      clef_56 : Clef_T;
      --  1111 0000 1111 0000 1111 0000 1111
      --  0    4    8    12   16   20   24
      champ1 : constant Champ_De_Bits_T :=
         (0 .. 3 | 8 .. 11 | 16 .. 19 | 24 .. 27 => False, others => True);
      --  0000 1111 0000 1111 0000 1111 0000
      champ2 : constant Champ_De_Bits_T :=
         (0 .. 3 | 8 .. 11 | 16 .. 19 | 24 .. 27 => True, others => False);
   begin
      clef_56.C1 := champ1;
      clef_56.C2 := champ2;
      T.clef_56 := clef_56;
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
   procedure Test_Decaler_0_Bit_A_Gauche
      (T : in out Test_Fixt_T)
   is
      decalage_attendu : constant Des_P.Clef_P.Clef_56_I_P.Decalage_T := 0;
      use type Des_P.Clef_P.Clef_56_I_P.Decalage_T;
   begin
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
      T.clef_56.Decaler_Bits_A_Gauche
         (Des_P.Clef_P.Clef_56_I_P.Decalage_T'Last + 1);
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
      T.clef_56.Decaler_Bits_A_Gauche
         (-(Des_P.Clef_P.Clef_56_I_P.Decalage_T'Last) - 1);
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
   end Test_Decaler_0_Bit_A_Gauche;

   ---------------------------------------------------------------------------
   procedure Test_Decaler_1_Bit_A_Gauche
      (T : in out Test_Fixt_T)
   is
      decalage_attendu : constant Des_P.Clef_P.Clef_56_I_P.Decalage_T := 1;
      use type Des_P.Clef_P.Clef_56_I_P.Decalage_T;
   begin
      T.clef_56.Decaler_Bits_A_Gauche (decalage_attendu);
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
      T.clef_56.Decalage := 0;
      T.clef_56.Decaler_Bits_A_Gauche
         (Des_P.Clef_P.Clef_56_I_P.Decalage_T'Last + 2);
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
      T.clef_56.Decalage := 0;
      T.clef_56.Decaler_Bits_A_Gauche
         (-(Des_P.Clef_P.Clef_56_I_P.Decalage_T'Last));
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
   end Test_Decaler_1_Bit_A_Gauche;

   ---------------------------------------------------------------------------
   procedure Test_Decaler_2_Bit_A_Gauche
      (T : in out Test_Fixt_T)
   is
      decalage_attendu : constant Des_P.Clef_P.Clef_56_I_P.Decalage_T := 2;
      use type Des_P.Clef_P.Clef_56_I_P.Decalage_T;
   begin
      T.clef_56.Decaler_Bits_A_Gauche (decalage_attendu);
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
      T.clef_56.Decalage := 0;
      T.clef_56.Decaler_Bits_A_Gauche
         (Des_P.Clef_P.Clef_56_I_P.Decalage_T'Last + 3);
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
      T.clef_56.Decalage := 0;
      T.clef_56.Decaler_Bits_A_Gauche
         (-(Des_P.Clef_P.Clef_56_I_P.Decalage_T'Last) + 1);
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
   end Test_Decaler_2_Bit_A_Gauche;

   ---------------------------------------------------------------------------
   procedure Test_Decaler_3_Bit_A_Gauche
      (T : in out Test_Fixt_T)
   is
      decalage_attendu : constant Des_P.Clef_P.Clef_56_I_P.Decalage_T := 3;
      use type Des_P.Clef_P.Clef_56_I_P.Decalage_T;
   begin
      T.clef_56.Decaler_Bits_A_Gauche (decalage_attendu);
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
      T.clef_56.Decalage := 0;
      T.clef_56.Decaler_Bits_A_Gauche
         (Des_P.Clef_P.Clef_56_I_P.Decalage_T'Last + 4);
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
      T.clef_56.Decalage := 0;
      T.clef_56.Decaler_Bits_A_Gauche
         (-(Des_P.Clef_P.Clef_56_I_P.Decalage_T'Last) + 2);
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
   end Test_Decaler_3_Bit_A_Gauche;

   ---------------------------------------------------------------------------
   procedure Test_1_Decalage_Successif_A_Gauche
      (T : in out Test_Fixt_T)
   is
      decalage_attendu : Des_P.Clef_P.Clef_56_I_P.Decalage_T := 0;
      use type Des_P.Clef_P.Clef_56_I_P.Decalage_T;
   begin
      T.clef_56.Decaler_Bits_A_Gauche;
      decalage_attendu := 1;
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
   end Test_1_Decalage_Successif_A_Gauche;

   ---------------------------------------------------------------------------
   procedure Test_1_Decalage_Successif_A_Droite
      (T : in out Test_Fixt_T)
   is
      decalage_attendu : Des_P.Clef_P.Clef_56_I_P.Decalage_T := 0;
      use type Des_P.Clef_P.Clef_56_I_P.Decalage_T;
   begin
      T.clef_56.Decaler_Bits_A_Gauche (-1);
      decalage_attendu := 27;
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
   end Test_1_Decalage_Successif_A_Droite;

   ---------------------------------------------------------------------------
   procedure Test_2_Decalage_Successif_A_Gauche
      (T : in out Test_Fixt_T)
   is
      decalage_attendu : Des_P.Clef_P.Clef_56_I_P.Decalage_T := 0;
      use type Des_P.Clef_P.Clef_56_I_P.Decalage_T;
   begin
      T.clef_56.Decaler_Bits_A_Gauche;
      decalage_attendu := 1;
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
      T.clef_56.Decaler_Bits_A_Gauche;
      decalage_attendu := 2;
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
   end Test_2_Decalage_Successif_A_Gauche;

   ---------------------------------------------------------------------------
   procedure Test_2_Decalage_Successif_A_Droite
      (T : in out Test_Fixt_T)
   is
      decalage_attendu : Des_P.Clef_P.Clef_56_I_P.Decalage_T := 0;
      use type Des_P.Clef_P.Clef_56_I_P.Decalage_T;
   begin
      T.clef_56.Decaler_Bits_A_Gauche (-1);
      decalage_attendu := 27;
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
      T.clef_56.Decaler_Bits_A_Gauche (-1);
      decalage_attendu := 26;
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
   end Test_2_Decalage_Successif_A_Droite;

   ---------------------------------------------------------------------------
   procedure Test_3_Decalage_Successif_A_Gauche
      (T : in out Test_Fixt_T)
   is
      decalage_attendu : Des_P.Clef_P.Clef_56_I_P.Decalage_T := 0;
      use type Des_P.Clef_P.Clef_56_I_P.Decalage_T;
   begin
      T.clef_56.Decaler_Bits_A_Gauche;
      decalage_attendu := 1;
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
      T.clef_56.Decaler_Bits_A_Gauche;
      decalage_attendu := 2;
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
      T.clef_56.Decaler_Bits_A_Gauche;
      decalage_attendu := 3;
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
   end Test_3_Decalage_Successif_A_Gauche;

   ---------------------------------------------------------------------------
   procedure Test_3_Decalage_Successif_A_Droite
      (T : in out Test_Fixt_T)
   is
      decalage_attendu : Des_P.Clef_P.Clef_56_I_P.Decalage_T := 0;
      use type Des_P.Clef_P.Clef_56_I_P.Decalage_T;
   begin
      T.clef_56.Decaler_Bits_A_Gauche (-1);
      decalage_attendu := 27;
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
      T.clef_56.Decaler_Bits_A_Gauche (-1);
      decalage_attendu := 26;
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
      T.clef_56.Decaler_Bits_A_Gauche (-1);
      decalage_attendu := 25;
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
   end Test_3_Decalage_Successif_A_Droite;

   ---------------------------------------------------------------------------
   procedure Test_Lire_Bit_Sans_Decalage
      (T : in out Test_Fixt_T)
   is
   begin
      for I in Des_P.Clef_P.Clef_56_I_P.Intervalle_T'Range loop
         AUnit.Assertions.Assert
            (T.clef_56.Lire_Bit (I) = c56 (I),
            "Le bit " & I'Img &
            " vaut : " & T.clef_56.Lire_Bit (I)'Img &
            " au lieu de " & c56 (I)'Img
            );
      end loop;
   end Test_Lire_Bit_Sans_Decalage;

   ---------------------------------------------------------------------------
   procedure Test_Lire_Bit_1_Decalage
      (T : in out Test_Fixt_T)
   is
   begin
      T.clef_56.Decaler_Bits_A_Gauche (1);
      for I in Des_P.Clef_P.Clef_56_I_P.Intervalle_T'Range loop
         AUnit.Assertions.Assert
            (T.clef_56.Lire_Bit (I) = c56_1_decalage (I),
            "Le bit " & I'Img &
            " vaut : " & T.clef_56.Lire_Bit (I)'Img &
            " au lieu de " & c56_1_decalage (I)'Img
            );
      end loop;
   end Test_Lire_Bit_1_Decalage;

   ---------------------------------------------------------------------------
   procedure Test_Lire_Bit_2_Decalage
      (T : in out Test_Fixt_T)
   is
   begin
      T.clef_56.Decaler_Bits_A_Gauche (2);
      for I in Des_P.Clef_P.Clef_56_I_P.Intervalle_T'Range loop
         AUnit.Assertions.Assert
            (T.clef_56.Lire_Bit (I) = c56_2_decalage (I),
            "Le bit " & I'Img &
            " vaut : " & T.clef_56.Lire_Bit (I)'Img &
            " au lieu de " & c56_2_decalage (I)'Img
            );
      end loop;
   end Test_Lire_Bit_2_Decalage;

   ---------------------------------------------------------------------------
   procedure Test_Lire_Bit_3_Decalage
      (T : in out Test_Fixt_T)
   is
   begin
      T.clef_56.Decaler_Bits_A_Gauche (3);
      for I in Des_P.Clef_P.Clef_56_I_P.Intervalle_T'Range loop
         AUnit.Assertions.Assert
            (T.clef_56.Lire_Bit (I) = c56_3_decalage (I),
            "Le bit " & I'Img &
            " vaut : " & T.clef_56.Lire_Bit (I)'Img &
            " au lieu de " & c56_3_decalage (I)'Img
            );
      end loop;
   end Test_Lire_Bit_3_Decalage;

   ---------------------------------------------------------------------------
   procedure Test_Lire_Bit_1_Decalage_Successif
      (T : in out Test_Fixt_T)
   is
   begin
      T.clef_56.Decaler_Bits_A_Gauche;
      for I in Des_P.Clef_P.Clef_56_I_P.Intervalle_T'Range loop
         AUnit.Assertions.Assert
            (T.clef_56.Lire_Bit (I) = c56_1_decalage (I),
            "Le bit " & I'Img &
            " vaut : " & T.clef_56.Lire_Bit (I)'Img &
            " au lieu de " & c56_1_decalage (I)'Img
            );
      end loop;
   end Test_Lire_Bit_1_Decalage_Successif;

   ---------------------------------------------------------------------------
   procedure Test_Lire_Bit_2_Decalage_Successif
      (T : in out Test_Fixt_T)
   is
   begin
      T.clef_56.Decaler_Bits_A_Gauche;
      T.clef_56.Decaler_Bits_A_Gauche;
      for I in Des_P.Clef_P.Clef_56_I_P.Intervalle_T'Range loop
         AUnit.Assertions.Assert
            (T.clef_56.Lire_Bit (I) = c56_2_decalage (I),
            "Le bit " & I'Img &
            " vaut : " & T.clef_56.Lire_Bit (I)'Img &
            " au lieu de " & c56_2_decalage (I)'Img
            );
      end loop;
   end Test_Lire_Bit_2_Decalage_Successif;

   ---------------------------------------------------------------------------
   procedure Test_Lire_Bit_3_Decalage_Successif
      (T : in out Test_Fixt_T)
   is
   begin
      T.clef_56.Decaler_Bits_A_Gauche;
      T.clef_56.Decaler_Bits_A_Gauche;
      T.clef_56.Decaler_Bits_A_Gauche;
      for I in Des_P.Clef_P.Clef_56_I_P.Intervalle_T'Range loop
         AUnit.Assertions.Assert
            (T.clef_56.Lire_Bit (I) = c56_3_decalage (I),
            "Le bit " & I'Img &
            " vaut : " & T.clef_56.Lire_Bit (I)'Img &
            " au lieu de " & c56_3_decalage (I)'Img
            );
      end loop;
   end Test_Lire_Bit_3_Decalage_Successif;

   ---------------------------------------------------------------------------
   procedure Test_Construire_Clef_48_0_Decalages
      (T : in out Test_Fixt_T)
   is
      c : Des_P.Clef_P.Clef_48_P.Clef_T;
   begin
      T.Faiseur.Preparer_Nouvelle_Clef;
      T.Faiseur.Construire_Clef (T.clef_56);
      c := T.Faiseur.Recuperer_Clef;
      for I in Des_P.Clef_P.Clef_48_I_P.Intervalle_T'Range loop
         AUnit.Assertions.Assert
            (c.Lire_Bit (I) = c48_0_decalage (I),
            "Le bit " & I'Img &
            " vaut : " & c.Lire_Bit (I)'Img &
            " au lieu de " & c48_0_decalage (I)'Img
            );
      end loop;
   end Test_Construire_Clef_48_0_Decalages;

   ---------------------------------------------------------------------------
   procedure Test_Construire_Clef_48_1_Decalages
      (T : in out Test_Fixt_T)
   is
      c : Des_P.Clef_P.Clef_48_P.Clef_T;
   begin
      T.clef_56.Decaler_Bits_A_Gauche;
      T.Faiseur.Preparer_Nouvelle_Clef;
      T.Faiseur.Construire_Clef (T.clef_56);
      c := T.Faiseur.Recuperer_Clef;
      for I in Des_P.Clef_P.Clef_48_I_P.Intervalle_T'Range loop
         AUnit.Assertions.Assert
            (c.Lire_Bit (I) = c48_1_decalage (I),
            "Le bit " & I'Img &
            " vaut : " & c.Lire_Bit (I)'Img &
            " au lieu de " & c48_1_decalage (I)'Img
            );
      end loop;
   end Test_Construire_Clef_48_1_Decalages;

   ---------------------------------------------------------------------------
   procedure Test_Construire_Clef_48_2_Decalages
      (T : in out Test_Fixt_T)
   is
      c : Des_P.Clef_P.Clef_48_P.Clef_T;
   begin
      T.clef_56.Decaler_Bits_A_Gauche (2);
      T.Faiseur.Preparer_Nouvelle_Clef;
      T.Faiseur.Construire_Clef (T.clef_56);
      c := T.Faiseur.Recuperer_Clef;
      for I in Des_P.Clef_P.Clef_48_I_P.Intervalle_T'Range loop
         AUnit.Assertions.Assert
            (c.Lire_Bit (I) = c48_2_decalage (I),
            "Le bit " & I'Img &
            " vaut : " & c.Lire_Bit (I)'Img &
            " au lieu de " & c48_2_decalage (I)'Img
            );
      end loop;
   end Test_Construire_Clef_48_2_Decalages;

   ---------------------------------------------------------------------------
   procedure Test_Construire_Clef_48_3_Decalages
      (T : in out Test_Fixt_T)
   is
      c : Des_P.Clef_P.Clef_48_P.Clef_T;
   begin
      T.clef_56.Decaler_Bits_A_Gauche (3);
      T.Faiseur.Preparer_Nouvelle_Clef;
      T.Faiseur.Construire_Clef (T.clef_56);
      c := T.Faiseur.Recuperer_Clef;
      for I in Des_P.Clef_P.Clef_48_I_P.Intervalle_T'Range loop
         AUnit.Assertions.Assert
            (c.Lire_Bit (I) = c48_3_decalage (I),
            "Le bit " & I'Img &
            " vaut : " & c.Lire_Bit (I)'Img &
            " au lieu de " & c48_3_decalage (I)'Img
            );
      end loop;
   end Test_Construire_Clef_48_3_Decalages;

end Des_P.Clef_P.Clef_56_P.Test_P;