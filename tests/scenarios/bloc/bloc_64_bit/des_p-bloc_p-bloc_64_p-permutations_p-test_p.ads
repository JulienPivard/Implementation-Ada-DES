with AUnit;
with AUnit.Test_Fixtures;

package Des_P.Bloc_P.Bloc_64_P.Permutations_P.Test_P is

   type Bit_IO_T is range 0 .. 1;

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         bloc : Bloc_64_T;
      end record;

   overriding
   procedure Set_Up (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down (T : in out Test_Fixt_T);

   procedure Test_Permutations_Entrantes
      (T : in out Test_Fixt_T);

   procedure Test_Permutations_Sortantes
      (T : in out Test_Fixt_T);

end Des_P.Bloc_P.Bloc_64_P.Permutations_P.Test_P;
