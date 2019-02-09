with AUnit;
with AUnit.Test_Fixtures;

with Des_P.Clef_P.Clef_56_I_P;
with Des_P.Clef_P.Clef_56_Simplifie_P;

package Des_P.Clef_P.Clef_48_P.Faiseur_P.Test_P is

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         Constructeur : Faiseur_Clef_T;
         Clef_56 : Des_P.Clef_P.Clef_56_Simplifie_P.Clef_S_T;
      end record;

   package Clef_56_I_R renames Des_P.Clef_P.Clef_56_I_P;

   subtype Intervalle_1_T is Clef_56_I_R.Intervalle_T range 1 .. 4;
   subtype Intervalle_2_T is Clef_56_I_R.Intervalle_T range 9 .. 12;
   subtype Intervalle_3_T is Clef_56_I_R.Intervalle_T range 17 .. 20;
   subtype Intervalle_4_T is Clef_56_I_R.Intervalle_T range 25 .. 28;
   subtype Intervalle_5_T is Clef_56_I_R.Intervalle_T range 33 .. 36;
   subtype Intervalle_6_T is Clef_56_I_R.Intervalle_T range 41 .. 44;
   subtype Intervalle_7_T is Clef_56_I_R.Intervalle_T range 49 .. 52;

   overriding
   procedure Set_Up (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down (T : in out Test_Fixt_T);

   procedure Test_Preparation (T : in out Test_Fixt_T);

   procedure Test_Construire (T : in out Test_Fixt_T);

   procedure Test_Recuperation (T : in out Test_Fixt_T);

end Des_P.Clef_P.Clef_48_P.Faiseur_P.Test_P;
