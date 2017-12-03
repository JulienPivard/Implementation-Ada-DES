with AUnit.Assertions;

with Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Constructeur_48_P;

package body Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Test_P is

   use Des_P.Clef_P.Clef_48_Abs_P;
   use Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P;

   --  1111 0000 1111 0000 1111 0000 1111 0000 1111 0000 1111 0000 1111 0000
   --  1    5    9    13   17   21   25   29   33   37   41   45   49   53
   c56 : constant array
      (Intervalle_Clef_56_T range Intervalle_Clef_56_T'Range)
      of Bit_T := (1 .. 4 | 9 .. 12 | 17 .. 20 | 25 .. 28 |
         33 .. 36 | 41 .. 44 | 49 .. 52 => 1, others => 0);

   --  1110 0001 1110 0001 1110 0001 1111 0001 1110 0001 1110 0001 1110 0000
   --  1    5    9    13   17   21   25   29   33   37   41   45   49   53
   c56_1_decalage : constant array
      (Intervalle_Clef_56_T range Intervalle_Clef_56_T'Range)
      of Bit_T := (1 .. 3 | 8 .. 11 | 16 .. 19 | 24 .. 28 |
         32 .. 35 | 40 .. 43 | 48 .. 51 => 1, others => 0);

   --  1100 0011 1100 0011 1100 0011 1111 0011 1100 0011 1100 0011 1100 0000
   --  1    5    9    13   17   21   25   29   33   37   41   45   49   53
   c56_2_decalage : constant array
      (Intervalle_Clef_56_T range Intervalle_Clef_56_T'Range)
      of Bit_T := (1 .. 2 | 7 .. 10 | 15 .. 18 | 23 .. 28 |
         31 .. 34 | 39 .. 42 | 47 .. 50 => 1, others => 0);

   --  1000 0111 1000 0111 1000 0111 1111 0111 1000 0111 1000 0111 1000 0000
   --  1    5    9    13   17   21   25   29   33   37   41   45   49   53
   c56_3_decalage : constant array
      (Intervalle_Clef_56_T range Intervalle_Clef_56_T'Range)
      of Bit_T := (1 .. 1 | 6 .. 9 | 14 .. 17 | 22 .. 28 |
         30 .. 33 | 38 .. 41 | 46 .. 49 => 1, others => 0);

   --  La clef de 56 bits:
   --  1111 0000 1111 0000 1111 0000 1111 0000 1111 0000 1111 0000 1111 0000
   --  Donne la sous clef suivante :
   --  0110 1011 0001 0111 1000 1101 1100 0000 1010 1100 1001 1100
   c48_0_decalage : constant array
      (Intervalle_Clef_48_T range Intervalle_Clef_48_T'Range)
      of Bit_T :=
      (
         0, 1, 1, 0, 1, 0,
         1, 1, 0, 0, 0, 1,
         0, 1, 1, 1, 1, 0,
         0, 0, 1, 1, 0, 1,
         1, 1, 0, 0, 0, 0,
         0, 0, 1, 0, 1, 0,
         1, 1, 0, 0, 1, 0,
         0, 1, 1, 1, 0, 0
      );

   --  La clef de 56 bits:
   --  1110 0001 1110 0001 1110 0001 1111 0001 1110 0001 1110 0001 1110 0000
   --  Donne la sous clef suivante :
   --  0110 1011 0001 0111 1000 1101 1100 0000 1010 1100 1001 1100
   c48_1_decalage : constant array
      (Intervalle_Clef_48_T range Intervalle_Clef_48_T'Range)
      of Bit_T :=
      (
         0, 1, 1, 1, 1, 0,
         1, 1, 0, 0, 0, 1,
         0, 1, 0, 0, 1, 1,
         1, 0, 1, 0, 0, 0,
         1, 0, 0, 0, 0, 0,
         0, 1, 1, 0, 1, 1,
         0, 1, 0, 0, 1, 0,
         0, 1, 1, 0, 0, 1
      );

   --  La clef de 56 bits:
   --  1100 0011 1100 0011 1100 0011 1111 0011 1100 0011 1100 0011 1100 0000
   --  Donne la sous clef suivante :
   --  0110 1011 0001 0111 1000 1101 1100 0000 1010 1100 1001 1100
   c48_2_decalage : constant array
      (Intervalle_Clef_48_T range Intervalle_Clef_48_T'Range)
      of Bit_T :=
      (
         0, 1, 0, 1, 1, 0,
         0, 1, 1, 0, 0, 1,
         1, 0, 0, 0, 1, 1,
         1, 1, 1, 0, 0, 0,
         1, 0, 1, 0, 1, 0,
         0, 1, 0, 0, 1, 1,
         0, 1, 1, 0, 1, 0,
         0, 1, 1, 0, 0, 1
      );

   --  La clef de 56 bits:
   --  1000 0111 1000 0111 1000 0111 1111 0111 1000 0111 1000 0111 1000 0000
   --  Donne la sous clef suivante :
   --  0110 1011 0001 0111 1000 1101 1100 0000 1010 1100 1001 1100
   c48_3_decalage : constant array
      (Intervalle_Clef_48_T range Intervalle_Clef_48_T'Range)
      of Bit_T :=
      (
         1, 1, 0, 1, 1, 0,
         0, 1, 1, 1, 0, 0,
         1, 0, 0, 0, 1, 1,
         1, 1, 1, 0, 0, 0,
         1, 0, 1, 0, 1, 0,
         1, 1, 0, 0, 1, 1,
         0, 1, 1, 0, 0, 0,
         1, 0, 0, 0, 0, 1
      );

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      use Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Constructeur_48_P;
      clef_56 : Clef_56_T;
      constr : constant access Constructeur_Clef_48_T :=
         new Constructeur_Clef_48_T;
      --  1111 0000 1111 0000 1111 0000 1111
      --  0    4    8    12   16   20   24
      champ1 : constant Champ_De_Bits_T :=
         (0 .. 3 | 8 .. 11 | 16 .. 19 | 24 .. 27 => 1, others => 0);
      --  0000 1111 0000 1111 0000 1111 0000
      champ2 : constant Champ_De_Bits_T :=
         (0 .. 3 | 8 .. 11 | 16 .. 19 | 24 .. 27 => 0, others => 1);
   begin
      clef_56.Ecrire_Constructeur (constr);
      clef_56.C1 := champ1;
      clef_56.C2 := champ2;
      T.clef_56 := clef_56;
   end Set_Up;

   ---------------------------------------------------------------------------
   overriding
   procedure Tear_Down (T : in out Test_Fixt_T) is
   begin
      T.clef_56.Constructeur := null;
   end Tear_Down;

   ---------------------------------------------------------------------------
   procedure Test_Possede_Constructeur_48 (T : in out Test_Fixt_T) is
   begin
      AUnit.Assertions.Assert
         (T.clef_56.Possede_Constructeur_48,
         "La clef devrait posseder un constructeur 48 bits, " &
         "mais n'en a pas."
         );
      T.clef_56.Constructeur := null;
      AUnit.Assertions.Assert
         (not T.clef_56.Possede_Constructeur_48,
         "La clef ne devrait pas posseder un " &
         "constructeur 48 bits, mais en a un."
         );
   end Test_Possede_Constructeur_48;

   ---------------------------------------------------------------------------
   procedure Test_Decaler_0_Bit_A_Gauche (T : in out Test_Fixt_T) is
      decalage_attendu : constant Decalage_T := 0;
   begin
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
   end Test_Decaler_0_Bit_A_Gauche;

   ---------------------------------------------------------------------------
   procedure Test_Decaler_1_Bit_A_Gauche (T : in out Test_Fixt_T) is
      decalage_attendu : constant Decalage_T := 1;
   begin
      T.clef_56.Decaler_Bits_A_Gauche (decalage_attendu);
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
   end Test_Decaler_1_Bit_A_Gauche;

   ---------------------------------------------------------------------------
   procedure Test_Decaler_2_Bit_A_Gauche (T : in out Test_Fixt_T) is
      decalage_attendu : constant Decalage_T := 2;
   begin
      T.clef_56.Decaler_Bits_A_Gauche (decalage_attendu);
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
   end Test_Decaler_2_Bit_A_Gauche;

   ---------------------------------------------------------------------------
   procedure Test_Decaler_3_Bit_A_Gauche (T : in out Test_Fixt_T) is
      decalage_attendu : constant Decalage_T := 3;
   begin
      T.clef_56.Decaler_Bits_A_Gauche (decalage_attendu);
      AUnit.Assertions.Assert
         (T.clef_56.Decalage = decalage_attendu,
         "Le decalage est de " & T.clef_56.Decalage'Img &
         " au lieu de " & decalage_attendu'Img
         );
   end Test_Decaler_3_Bit_A_Gauche;

   ---------------------------------------------------------------------------
   procedure Test_1_Decalage_Successif_A_Gauche (T : in out Test_Fixt_T) is
      decalage_attendu : Decalage_T := 0;
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
   procedure Test_2_Decalage_Successif_A_Gauche (T : in out Test_Fixt_T) is
      decalage_attendu : Decalage_T := 0;
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
   procedure Test_3_Decalage_Successif_A_Gauche (T : in out Test_Fixt_T) is
      decalage_attendu : Decalage_T := 0;
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
   procedure Test_Lire_Bit_Sans_Decalage (T : in out Test_Fixt_T) is
   begin
      for I in Intervalle_Clef_56_T'Range loop
         AUnit.Assertions.Assert
            (T.clef_56.Lire_Bit (I) = c56 (I),
            "Le bit " & I'Img &
            " vaut : " & T.clef_56.Lire_Bit (I)'Img &
            " au lieu de " & c56 (I)'Img
            );
      end loop;
   end Test_Lire_Bit_Sans_Decalage;

   ---------------------------------------------------------------------------
   procedure Test_Lire_Bit_1_Decalage (T : in out Test_Fixt_T) is
   begin
      T.clef_56.Decaler_Bits_A_Gauche (1);
      for I in Intervalle_Clef_56_T'Range loop
         AUnit.Assertions.Assert
            (T.clef_56.Lire_Bit (I) = c56_1_decalage (I),
            "Le bit " & I'Img &
            " vaut : " & T.clef_56.Lire_Bit (I)'Img &
            " au lieu de " & c56_1_decalage (I)'Img
            );
      end loop;
   end Test_Lire_Bit_1_Decalage;

   ---------------------------------------------------------------------------
   procedure Test_Lire_Bit_2_Decalage (T : in out Test_Fixt_T) is
   begin
      T.clef_56.Decaler_Bits_A_Gauche (2);
      for I in Intervalle_Clef_56_T'Range loop
         AUnit.Assertions.Assert
            (T.clef_56.Lire_Bit (I) = c56_2_decalage (I),
            "Le bit " & I'Img &
            " vaut : " & T.clef_56.Lire_Bit (I)'Img &
            " au lieu de " & c56_2_decalage (I)'Img
            );
      end loop;
   end Test_Lire_Bit_2_Decalage;

   ---------------------------------------------------------------------------
   procedure Test_Lire_Bit_3_Decalage (T : in out Test_Fixt_T) is
   begin
      T.clef_56.Decaler_Bits_A_Gauche (3);
      for I in Intervalle_Clef_56_T'Range loop
         AUnit.Assertions.Assert
            (T.clef_56.Lire_Bit (I) = c56_3_decalage (I),
            "Le bit " & I'Img &
            " vaut : " & T.clef_56.Lire_Bit (I)'Img &
            " au lieu de " & c56_3_decalage (I)'Img
            );
      end loop;
   end Test_Lire_Bit_3_Decalage;

   ---------------------------------------------------------------------------
   procedure Test_Lire_Bit_1_Decalage_Successif (T : in out Test_Fixt_T) is
   begin
      T.clef_56.Decaler_Bits_A_Gauche;
      for I in Intervalle_Clef_56_T'Range loop
         AUnit.Assertions.Assert
            (T.clef_56.Lire_Bit (I) = c56_1_decalage (I),
            "Le bit " & I'Img &
            " vaut : " & T.clef_56.Lire_Bit (I)'Img &
            " au lieu de " & c56_1_decalage (I)'Img
            );
      end loop;
   end Test_Lire_Bit_1_Decalage_Successif;

   ---------------------------------------------------------------------------
   procedure Test_Lire_Bit_2_Decalage_Successif (T : in out Test_Fixt_T) is
   begin
      T.clef_56.Decaler_Bits_A_Gauche;
      T.clef_56.Decaler_Bits_A_Gauche;
      for I in Intervalle_Clef_56_T'Range loop
         AUnit.Assertions.Assert
            (T.clef_56.Lire_Bit (I) = c56_2_decalage (I),
            "Le bit " & I'Img &
            " vaut : " & T.clef_56.Lire_Bit (I)'Img &
            " au lieu de " & c56_2_decalage (I)'Img
            );
      end loop;
   end Test_Lire_Bit_2_Decalage_Successif;

   ---------------------------------------------------------------------------
   procedure Test_Lire_Bit_3_Decalage_Successif (T : in out Test_Fixt_T) is
   begin
      T.clef_56.Decaler_Bits_A_Gauche;
      T.clef_56.Decaler_Bits_A_Gauche;
      T.clef_56.Decaler_Bits_A_Gauche;
      for I in Intervalle_Clef_56_T'Range loop
         AUnit.Assertions.Assert
            (T.clef_56.Lire_Bit (I) = c56_3_decalage (I),
            "Le bit " & I'Img &
            " vaut : " & T.clef_56.Lire_Bit (I)'Img &
            " au lieu de " & c56_3_decalage (I)'Img
            );
      end loop;
   end Test_Lire_Bit_3_Decalage_Successif;

   ---------------------------------------------------------------------------
   procedure Test_Construire_Clef_48_0_Decalages (T : in out Test_Fixt_T) is
      c : Clef_48_T;
   begin
      c := T.clef_56.Lire_Clef_48;
      for I in Intervalle_Clef_48_T'Range loop
         AUnit.Assertions.Assert
            (c.Lire_Bit (I) = c48_0_decalage (I),
            "Le bit " & I'Img &
            " vaut : " & c.Lire_Bit (I)'Img &
            " au lieu de " & c48_0_decalage (I)'Img
            );
      end loop;
   end Test_Construire_Clef_48_0_Decalages;

   ---------------------------------------------------------------------------
   procedure Test_Construire_Clef_48_1_Decalages (T : in out Test_Fixt_T) is
      c : Clef_48_T;
   begin
      T.clef_56.Decaler_Bits_A_Gauche;
      c := T.clef_56.Lire_Clef_48;
      for I in Intervalle_Clef_48_T'Range loop
         AUnit.Assertions.Assert
            (c.Lire_Bit (I) = c48_1_decalage (I),
            "Le bit " & I'Img &
            " vaut : " & c.Lire_Bit (I)'Img &
            " au lieu de " & c48_1_decalage (I)'Img
            );
      end loop;
   end Test_Construire_Clef_48_1_Decalages;

   ---------------------------------------------------------------------------
   procedure Test_Construire_Clef_48_2_Decalages (T : in out Test_Fixt_T) is
      c : Clef_48_T;
   begin
      T.clef_56.Decaler_Bits_A_Gauche (2);
      c := T.clef_56.Lire_Clef_48;
      for I in Intervalle_Clef_48_T'Range loop
         AUnit.Assertions.Assert
            (c.Lire_Bit (I) = c48_2_decalage (I),
            "Le bit " & I'Img &
            " vaut : " & c.Lire_Bit (I)'Img &
            " au lieu de " & c48_2_decalage (I)'Img
            );
      end loop;
   end Test_Construire_Clef_48_2_Decalages;

   ---------------------------------------------------------------------------
   procedure Test_Construire_Clef_48_3_Decalages (T : in out Test_Fixt_T) is
      c : Clef_48_T;
   begin
      T.clef_56.Decaler_Bits_A_Gauche (3);
      c := T.clef_56.Lire_Clef_48;
      for I in Intervalle_Clef_48_T'Range loop
         AUnit.Assertions.Assert
            (c.Lire_Bit (I) = c48_3_decalage (I),
            "Le bit " & I'Img &
            " vaut : " & c.Lire_Bit (I)'Img &
            " au lieu de " & c48_3_decalage (I)'Img
            );
      end loop;
   end Test_Construire_Clef_48_3_Decalages;

end Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Test_P;
