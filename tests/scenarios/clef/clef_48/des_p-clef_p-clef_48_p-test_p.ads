with AUnit;
with AUnit.Test_Fixtures;

package Des_P.Clef_P.Clef_48_P.Test_P is

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         clef_48 : Clef_T;
      end record;

   overriding
   procedure Set_Up (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down (T : in out Test_Fixt_T);

   procedure Test_Lecture_Bit (T : in out Test_Fixt_T);

   procedure Test_Bits_Aleatoire (T : in out Test_Fixt_T);

end Des_P.Clef_P.Clef_48_P.Test_P;
