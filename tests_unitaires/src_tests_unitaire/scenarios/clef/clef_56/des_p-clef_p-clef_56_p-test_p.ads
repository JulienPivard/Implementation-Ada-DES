with AUnit;
with AUnit.Test_Fixtures;

with Des_P.Clef_P.Clef_48_P.Faiseur_P;
with Des_P.Clef_P.Clef_48_I_P;

package Des_P.Clef_P.Clef_56_P.Test_P is

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         Clef_56 : Clef_T;
         Faiseur : Des_P.Clef_P.Clef_48_P.Faiseur_P.Faiseur_Clef_T;
      end record;

   package Clef_48_I_R renames Des_P.Clef_P.Clef_48_I_P;
   package Clef_56_I_R renames Des_P.Clef_P.Clef_56_I_P;

   --  Intervalles sans décalages.
   subtype Intervalle_01_T is Clef_56_I_R.Intervalle_T range 1 .. 4;
   subtype Intervalle_02_T is Clef_56_I_R.Intervalle_T range 9 .. 12;
   subtype Intervalle_03_T is Clef_56_I_R.Intervalle_T range 17 .. 20;
   subtype Intervalle_04_T is Clef_56_I_R.Intervalle_T range 25 .. 28;
   subtype Intervalle_05_T is Clef_56_I_R.Intervalle_T range 33 .. 36;
   subtype Intervalle_06_T is Clef_56_I_R.Intervalle_T range 41 .. 44;
   subtype Intervalle_07_T is Clef_56_I_R.Intervalle_T range 49 .. 52;

   --  Intervalles avec un décalage.
   subtype Intervalle_11_T is Clef_56_I_R.Intervalle_T range 1 .. 3;
   subtype Intervalle_12_T is Clef_56_I_R.Intervalle_T range 8 .. 11;
   subtype Intervalle_13_T is Clef_56_I_R.Intervalle_T range 16 .. 19;
   subtype Intervalle_14_T is Clef_56_I_R.Intervalle_T range 24 .. 28;
   subtype Intervalle_15_T is Clef_56_I_R.Intervalle_T range 32 .. 35;
   subtype Intervalle_16_T is Clef_56_I_R.Intervalle_T range 40 .. 43;
   subtype Intervalle_17_T is Clef_56_I_R.Intervalle_T range 48 .. 51;

   --  Intervalles avec deux décalage.
   subtype Intervalle_21_T is Clef_56_I_R.Intervalle_T range 1 .. 2;
   subtype Intervalle_22_T is Clef_56_I_R.Intervalle_T range 7 .. 10;
   subtype Intervalle_23_T is Clef_56_I_R.Intervalle_T range 15 .. 18;
   subtype Intervalle_24_T is Clef_56_I_R.Intervalle_T range 23 .. 28;
   subtype Intervalle_25_T is Clef_56_I_R.Intervalle_T range 31 .. 34;
   subtype Intervalle_26_T is Clef_56_I_R.Intervalle_T range 39 .. 42;
   subtype Intervalle_27_T is Clef_56_I_R.Intervalle_T range 47 .. 50;

   --  Intervalles avec trois décalage.
   subtype Intervalle_31_T is Clef_56_I_R.Intervalle_T range 1 .. 1;
   subtype Intervalle_32_T is Clef_56_I_R.Intervalle_T range 6 .. 9;
   subtype Intervalle_33_T is Clef_56_I_R.Intervalle_T range 14 .. 17;
   subtype Intervalle_34_T is Clef_56_I_R.Intervalle_T range 22 .. 28;
   subtype Intervalle_35_T is Clef_56_I_R.Intervalle_T range 30 .. 33;
   subtype Intervalle_36_T is Clef_56_I_R.Intervalle_T range 38 .. 41;
   subtype Intervalle_37_T is Clef_56_I_R.Intervalle_T range 46 .. 49;

   overriding
   procedure Set_Up
      (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down
      (T : in out Test_Fixt_T);

   procedure Test_Decaler_0_Bit_A_Gauche
      (T : in out Test_Fixt_T);

   procedure Test_Decaler_1_Bit_A_Gauche
      (T : in out Test_Fixt_T);

   procedure Test_Decaler_2_Bit_A_Gauche
      (T : in out Test_Fixt_T);

   procedure Test_Decaler_3_Bit_A_Gauche
      (T : in out Test_Fixt_T);

   procedure Test_1_Decalage_Successif_A_Gauche
      (T : in out Test_Fixt_T);

   procedure Test_1_Decalage_Successif_A_Droite
      (T : in out Test_Fixt_T);

   procedure Test_2_Decalage_Successif_A_Gauche
      (T : in out Test_Fixt_T);

   procedure Test_2_Decalage_Successif_A_Droite
      (T : in out Test_Fixt_T);

   procedure Test_3_Decalage_Successif_A_Gauche
      (T : in out Test_Fixt_T);

   procedure Test_3_Decalage_Successif_A_Droite
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Bit_Sans_Decalage
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Bit_1_Decalage
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Bit_2_Decalage
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Bit_3_Decalage
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Bit_1_Decalage_Successif
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Bit_2_Decalage_Successif
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Bit_3_Decalage_Successif
      (T : in out Test_Fixt_T);

   procedure Test_Construire_Clef_48_0_Decalages
      (T : in out Test_Fixt_T);

   procedure Test_Construire_Clef_48_1_Decalages
      (T : in out Test_Fixt_T);

   procedure Test_Construire_Clef_48_2_Decalages
      (T : in out Test_Fixt_T);

   procedure Test_Construire_Clef_48_3_Decalages
      (T : in out Test_Fixt_T);

end Des_P.Clef_P.Clef_56_P.Test_P;
