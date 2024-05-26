with AUnit.Test_Caller;

with Des_P.Bloc_P.Bloc_64_P.Permutations_P.Test_P;

package body Permutations_64_Suite_P is

   package Scenario_R renames Des_P.Bloc_P.Bloc_64_P.Permutations_P.Test_P;

   package Caller is new AUnit.Test_Caller (Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      Nom_Test : constant String := "(Test permutations bloc de 64 bits) ";
   begin

      Ptr_Test_Suite.all.Add_Test
         (Caller.Create
            (Nom_Test & "IP",
            Scenario_R.Test_Permutations_Entrantes'Access
            )
         );

      Ptr_Test_Suite.all.Add_Test
         (Caller.Create
            (Nom_Test & "IP-1",
            Scenario_R.Test_Permutations_Sortantes'Access
            )
         );

      return Ptr_Test_Suite;

   end Fonc_Suite;

end Permutations_64_Suite_P;
