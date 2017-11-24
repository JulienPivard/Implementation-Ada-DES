with AUnit.Assertions;

package body Des_P.Clef_P.Test_P is

   --  1111 0000 1111 0000 1111 0000 1111 0000 1111 0000 1111 0000 1111 0000
   --  1    5    9    13   17   21   25   29   33   37   41   45   49   53
   c56 : constant array
      (Intervalle_Clef_T range Intervalle_Clef_T'Range)
      of Bit_T := (1 .. 4 | 9 .. 12 | 17 .. 20 | 25 .. 28 |
         33 .. 36 | 41 .. 44 | 49 .. 52 => 1, others => 0);

   --  1110 0001 1110 0001 1110 0001 1111 0001 1110 0001 1110 0001 1110 0000
   --  1    5    9    13   17   21   25   29   33   37   41   45   49   53
   c56_1_decalage : constant array
      (Intervalle_Clef_T range Intervalle_Clef_T'Range)
      of Bit_T := (1 .. 3 | 8 .. 11 | 16 .. 19 | 24 .. 28 |
         32 .. 35 | 40 .. 43 | 48 .. 51 => 1, others => 0);

   --  1100 0011 1100 0011 1100 0011 1111 0011 1100 0011 1100 0011 1100 0000
   --  1    5    9    13   17   21   25   29   33   37   41   45   49   53
   c56_2_decalage : constant array
      (Intervalle_Clef_T range Intervalle_Clef_T'Range)
      of Bit_T := (1 .. 2 | 7 .. 10 | 15 .. 18 | 23 .. 28 |
         31 .. 34 | 39 .. 42 | 47 .. 50 => 1, others => 0);

   --  1000 0111 1000 0111 1000 0111 1111 0111 1000 0111 1000 0111 1000 0000
   --  1    5    9    13   17   21   25   29   33   37   41   45   49   53
   c56_3_decalage : constant array
      (Intervalle_Clef_T range Intervalle_Clef_T'Range)
      of Bit_T := (1 .. 1 | 6 .. 9 | 14 .. 17 | 22 .. 28 |
         30 .. 33 | 38 .. 41 | 46 .. 49 => 1, others => 0);

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      clef : Clef_T;
      --  1111 0000 1111 0000 1111 0000 1111
      --  0    4    8    12   16   20   24
      champ1 : constant Champ_De_Bits_T :=
         (0 .. 3 | 8 .. 11 | 16 .. 19 | 24 .. 27 => 1, others => 0);
      --  0000 1111 0000 1111 0000 1111 0000
      champ2 : constant Champ_De_Bits_T :=
         (0 .. 3 | 8 .. 11 | 16 .. 19 | 24 .. 27 => 0, others => 1);
   begin
      clef.C1 := champ1;
      clef.C2 := champ2;
      T.clef := clef;
   end Set_Up;

   ---------------------------------------------------------------------------
   overriding
   procedure Tear_Down (T : in out Test_Fixt_T) is
   begin
      null;
   end Tear_Down;

   ---------------------------------------------------------------------------
   procedure Test_Decaler_0_Bit_A_Gauche (T : in out Test_Fixt_T) is
      decalage_attendu : constant Decalage_T := 0;
   begin
      AUnit.Assertions.Assert
         (T.clef.Decalage = decalage_attendu,
         "Le decalage est de " & Decalage_T'Image (T.clef.Decalage) &
         " au lieu de " & Decalage_T'Image (decalage_attendu)
         );
   end Test_Decaler_0_Bit_A_Gauche;

   ---------------------------------------------------------------------------
   procedure Test_Decaler_1_Bit_A_Gauche (T : in out Test_Fixt_T) is
      decalage_attendu : constant Decalage_T := 1;
   begin
      T.clef.Decaler_Bits_A_Gauche;
      AUnit.Assertions.Assert
         (T.clef.Decalage = decalage_attendu,
         "Le decalage est de " & Decalage_T'Image (T.clef.Decalage) &
         " au lieu de " & Decalage_T'Image (decalage_attendu)
         );
   end Test_Decaler_1_Bit_A_Gauche;

   ---------------------------------------------------------------------------
   procedure Test_Decaler_2_Bit_A_Gauche (T : in out Test_Fixt_T) is
      decalage_attendu : constant Decalage_T := 2;
   begin
      T.clef.Decaler_Bits_A_Gauche (decalage_attendu);
      AUnit.Assertions.Assert
         (T.clef.Decalage = decalage_attendu,
         "Le decalage est de " & Decalage_T'Image (T.clef.Decalage) &
         " au lieu de " & Decalage_T'Image (decalage_attendu)
         );
   end Test_Decaler_2_Bit_A_Gauche;

   ---------------------------------------------------------------------------
   procedure Test_Decaler_3_Bit_A_Gauche (T : in out Test_Fixt_T) is
      decalage_attendu : constant Decalage_T := 3;
   begin
      T.clef.Decaler_Bits_A_Gauche (decalage_attendu);
      AUnit.Assertions.Assert
         (T.clef.Decalage = decalage_attendu,
         "Le decalage est de " & Decalage_T'Image (T.clef.Decalage) &
         " au lieu de " & Decalage_T'Image (decalage_attendu)
         );
   end Test_Decaler_3_Bit_A_Gauche;

   ---------------------------------------------------------------------------
   procedure Test_Lire_Bit_Sans_Decalage (T : in out Test_Fixt_T) is
   begin
      for I in Intervalle_Clef_T'Range loop
         AUnit.Assertions.Assert
            (T.clef.Lire_Bit (I) = c56 (I),
            "Le bit " & Intervalle_Clef_T'Image (I) &
            " vaut : " & Bit_T'Image (T.clef.Lire_Bit (I)) &
            " au lieu de " & Bit_T'Image (c56 (I))
            );
      end loop;
   end Test_Lire_Bit_Sans_Decalage;

   ---------------------------------------------------------------------------
   procedure Test_Lire_Bit_1_Decalage (T : in out Test_Fixt_T) is
   begin
      T.clef.Decaler_Bits_A_Gauche;
      for I in Intervalle_Clef_T'Range loop
         AUnit.Assertions.Assert
            (T.clef.Lire_Bit (I) = c56_1_decalage (I),
            "Le bit " & Intervalle_Clef_T'Image (I) &
            " vaut : " & Bit_T'Image (T.clef.Lire_Bit (I)) &
            " au lieu de " & Bit_T'Image (c56_1_decalage (I))
            );
      end loop;
   end Test_Lire_Bit_1_Decalage;

   ---------------------------------------------------------------------------
   procedure Test_Lire_Bit_2_Decalage (T : in out Test_Fixt_T) is
   begin
      T.clef.Decaler_Bits_A_Gauche (2);
      for I in Intervalle_Clef_T'Range loop
         AUnit.Assertions.Assert
            (T.clef.Lire_Bit (I) = c56_2_decalage (I),
            "Le bit " & Intervalle_Clef_T'Image (I) &
            " vaut : " & Bit_T'Image (T.clef.Lire_Bit (I)) &
            " au lieu de " & Bit_T'Image (c56_2_decalage (I))
            );
      end loop;
   end Test_Lire_Bit_2_Decalage;

   ---------------------------------------------------------------------------
   procedure Test_Lire_Bit_3_Decalage (T : in out Test_Fixt_T) is
   begin
      T.clef.Decaler_Bits_A_Gauche (3);
      for I in Intervalle_Clef_T'Range loop
         AUnit.Assertions.Assert
            (T.clef.Lire_Bit (I) = c56_3_decalage (I),
            "Le bit " & Intervalle_Clef_T'Image (I) &
            " vaut : " & Bit_T'Image (T.clef.Lire_Bit (I)) &
            " au lieu de " & Bit_T'Image (c56_3_decalage (I))
            );
      end loop;
   end Test_Lire_Bit_3_Decalage;

end Des_P.Clef_P.Test_P;
