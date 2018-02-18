with AUnit;
with AUnit.Test_Fixtures;

with Des_P.Bloc_P.Bloc_48_P;

package Des_P.Bloc_Xor_Clef_P.Test_P is

   type Bit_IO_T is range 0 .. 1;

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         bloc : Des_P.Bloc_P.Bloc_48_P.Bloc_48_T;
      end record;

   overriding
   procedure Set_Up (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down (T : in out Test_Fixt_T);

   procedure Test_Xor_G_D (T : in out Test_Fixt_T);

   procedure Test_Xor_D_G (T : in out Test_Fixt_T);

end Des_P.Bloc_Xor_Clef_P.Test_P;
