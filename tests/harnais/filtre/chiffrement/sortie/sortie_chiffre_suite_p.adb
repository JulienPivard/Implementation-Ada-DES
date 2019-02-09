with AUnit.Test_Caller;

with Des_P.Filtre_P.Sortie_P.Chiffre_P.Test_P;

package body Sortie_Chiffre_Suite_P is

   package Scenario_R renames Des_P.Filtre_P.Sortie_P.Chiffre_P.Test_P;

   package Caller is new AUnit.Test_Caller (Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String := "(Tests filtre chiffrement final) ";
   begin

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Permutation final",
            Scenario_R.Test_Permutation_Sortante'Access
            )
         );

      return ptr_test_suite;

   end Fonc_Suite;

end Sortie_Chiffre_Suite_P;
