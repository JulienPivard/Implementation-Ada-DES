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
            Intervalle_01_T | Intervalle_02_T | Intervalle_03_T |
            Intervalle_04_T | Intervalle_05_T | Intervalle_06_T |
            Intervalle_07_T => False,
            others => True
         );

   --  1110 0001 1110 0001 1110 0001 1111 0001 1110 0001 1110 0001 1110 0000
   --  1    5    9    13   17   21   25   29   33   37   41   45   49   53
   c56_1_decalage : constant array
      (Des_P.Clef_P.Clef_56_I_P.Intervalle_T)
      of Bit_T :=
         (
            Intervalle_11_T | Intervalle_12_T | Intervalle_13_T |
            Intervalle_14_T | Intervalle_15_T | Intervalle_16_T |
            Intervalle_17_T => False,
            others => True
         );

   --  1100 0011 1100 0011 1100 0011 1111 0011 1100 0011 1100 0011 1100 0000
   --  1    5    9    13   17   21   25   29   33   37   41   45   49   53
   c56_2_decalage : constant array
      (Des_P.Clef_P.Clef_56_I_P.Intervalle_T)
      of Bit_T :=
         (
            Intervalle_21_T | Intervalle_22_T | Intervalle_23_T |
            Intervalle_24_T | Intervalle_25_T | Intervalle_26_T |
            Intervalle_27_T => False,
            others => True
         );

   --  1000 0111 1000 0111 1000 0111 1111 0111 1000 0111 1000 0111 1000 0000
   --  1    5    9    13   17   21   25   29   33   37   41   45   49   53
   c56_3_decalage : constant array
      (Des_P.Clef_P.Clef_56_I_P.Intervalle_T)
      of Bit_T :=
         (
            Intervalle_31_T | Intervalle_32_T | Intervalle_33_T |
            Intervalle_34_T | Intervalle_35_T | Intervalle_36_T |
            Intervalle_37_T => False,
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
      subtype Intervalle_1_T is Clef_56_I_R.Decalage_T range 0 .. 3;
      subtype Intervalle_2_T is Clef_56_I_R.Decalage_T range 8 .. 11;
      subtype Intervalle_3_T is Clef_56_I_R.Decalage_T range 16 .. 19;
      subtype Intervalle_4_T is Clef_56_I_R.Decalage_T range 24 .. 27;
      clef_56 : Clef_T;
      --  1111 0000 1111 0000 1111 0000 1111
      --  0    4    8    12   16   20   24
      champ1 : constant Champ_De_Bits_T :=
         (
            Intervalle_1_T | Intervalle_2_T | Intervalle_3_T |
            Intervalle_4_T => False,
            others => True
         );
      --  0000 1111 0000 1111 0000 1111 0000
      champ2 : constant Champ_De_Bits_T :=
         (
            Intervalle_1_T | Intervalle_2_T | Intervalle_3_T |
            Intervalle_4_T => True,
            others => False
         );
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
      T.clef_56.Decaler_Bits_A_Droite (1);
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
      T.clef_56.Decaler_Bits_A_Droite (1);
      decalage_attendu := 27;
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
      T.clef_56.Decaler_Bits_A_Droite (1);
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
      T.clef_56.Decaler_Bits_A_Droite (1);
      decalage_attendu := 27;
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
      T.clef_56.Decaler_Bits_A_Droite (1);
      decalage_attendu := 26;
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
      T.clef_56.Decaler_Bits_A_Droite (1);
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
      for I in Des_P.Clef_P.Clef_56_I_P.Intervalle_T loop
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
      for I in Des_P.Clef_P.Clef_56_I_P.Intervalle_T loop
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
      for I in Des_P.Clef_P.Clef_56_I_P.Intervalle_T loop
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
      for I in Des_P.Clef_P.Clef_56_I_P.Intervalle_T loop
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
      for I in Des_P.Clef_P.Clef_56_I_P.Intervalle_T loop
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
      for I in Des_P.Clef_P.Clef_56_I_P.Intervalle_T loop
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
      for I in Des_P.Clef_P.Clef_56_I_P.Intervalle_T loop
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
      for I in Des_P.Clef_P.Clef_48_I_P.Intervalle_T loop
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
      for I in Des_P.Clef_P.Clef_48_I_P.Intervalle_T loop
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
      for I in Des_P.Clef_P.Clef_48_I_P.Intervalle_T loop
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
      for I in Des_P.Clef_P.Clef_48_I_P.Intervalle_T loop
         AUnit.Assertions.Assert
            (c.Lire_Bit (I) = c48_3_decalage (I),
            "Le bit " & I'Img &
            " vaut : " & c.Lire_Bit (I)'Img &
            " au lieu de " & c48_3_decalage (I)'Img
            );
      end loop;
   end Test_Construire_Clef_48_3_Decalages;

end Des_P.Clef_P.Clef_56_P.Test_P;
