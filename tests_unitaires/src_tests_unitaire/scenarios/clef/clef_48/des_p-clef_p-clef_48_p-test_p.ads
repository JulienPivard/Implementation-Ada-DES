with AUnit;
with AUnit.Test_Fixtures;

package Des_P.Clef_P.Clef_48_P.Test_P is

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         Clef : Clef_T;
      end record;

   package Clef_48_I_R renames Des_P.Clef_P.Clef_48_I_P;

   subtype Intervalle_1_T is Clef_48_I_R.Intervalle_T range 1 .. 4;
   subtype Intervalle_2_T is Clef_48_I_R.Intervalle_T range 9 .. 12;
   subtype Intervalle_3_T is Clef_48_I_R.Intervalle_T range 17 .. 20;
   subtype Intervalle_4_T is Clef_48_I_R.Intervalle_T range 25 .. 28;
   subtype Intervalle_5_T is Clef_48_I_R.Intervalle_T range 33 .. 36;
   subtype Intervalle_6_T is Clef_48_I_R.Intervalle_T range 41 .. 44;

   overriding
   procedure Set_Up (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down (T : in out Test_Fixt_T);

   procedure Test_Lecture_Bit (T : in out Test_Fixt_T);

   procedure Test_Bits_Aleatoire (T : in out Test_Fixt_T);

end Des_P.Clef_P.Clef_48_P.Test_P;
