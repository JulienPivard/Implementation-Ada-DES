with AUnit.Test_Caller;

with Des_P.Filtre_P.Fabrique_P.Dechiffre_P.Test_P;

package body Fabrique_Dechiffre_Suite_P is

   package Scenario_R renames Des_P.Filtre_P.Fabrique_P.Dechiffre_P.Test_P;

   package Caller is new AUnit.Test_Caller (Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String :=
         "(Tests fabrique dechiffrement abstraite) ";
   begin

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Fabrication entree",
            Scenario_R.Test_Fabrication_Entree'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Fabrication corps",
            Scenario_R.Test_Fabrication_Corps'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Fabrication sortie",
            Scenario_R.Test_Fabrication_Sortie'Access
            )
         );

      return ptr_test_suite;

   end Fonc_Suite;

end Fabrique_Dechiffre_Suite_P;
