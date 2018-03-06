with AUnit;
with AUnit.Test_Fixtures;

package Des_P.Bloc_P.Bloc_32_P.Test_P is

   type Bit_IO_T is range 0 .. 1;

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         bloc : Bloc_32_T;
      end record;

   overriding
   procedure Set_Up (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down (T : in out Test_Fixt_T);

   procedure Test_Initialisation
      (T : in out Test_Fixt_T);

   procedure Test_Modification_Un_Bit_Par_Un_Bit
      (T : in out Test_Fixt_T);

   procedure Test_Change_Bits_Aleatoirement
      (T : in out Test_Fixt_T);

   procedure Test_Ou_Exclusif
      (T : in out Test_Fixt_T);

end Des_P.Bloc_P.Bloc_32_P.Test_P;
