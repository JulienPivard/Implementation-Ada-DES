with AUnit.Test_Caller;

with Des_P.Filtre_P.Corps_P.Test_P;

package body Fonction_F_Suite_P is

   package Scenario_R renames Des_P.Filtre_P.Corps_P.Test_P;

   package Caller is new AUnit.Test_Caller (Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String := "(Tests fonction F) ";
   begin

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Premiere configuration de test",
            Scenario_R.Test_Fonction_F'Access
            )
         );

      return ptr_test_suite;

   end Fonc_Suite;

end Fonction_F_Suite_P;
