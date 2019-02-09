with AUnit.Test_Caller;

with Des_P.Bloc_P.Bloc_64_P.Permutations_P.Test_P;

package body Permutations_64_Suite_P is

   package Scenario_R renames Des_P.Bloc_P.Bloc_64_P.Permutations_P.Test_P;

   package Caller is new AUnit.Test_Caller (Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String := "(Test permutations bloc de 64 bits) ";
   begin

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "IP",
            Scenario_R.Test_Permutations_Entrantes'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "IP-1",
            Scenario_R.Test_Permutations_Sortantes'Access
            )
         );

      return ptr_test_suite;

   end Fonc_Suite;

end Permutations_64_Suite_P;
