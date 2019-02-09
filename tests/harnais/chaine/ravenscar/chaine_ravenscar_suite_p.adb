with AUnit.Test_Caller;

with Des_P.Chaine_P.Ravenscar_P.Test_P;

package body Chaine_Ravenscar_Suite_P is

   package Scenario_R renames Des_P.Chaine_P.Ravenscar_P.Test_P;

   package Caller is new AUnit.Test_Caller (Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String := "(Tests chaine ravenscar) ";
   begin

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Chiffrement a partir de 1 bloc d'un generateur",
            Scenario_R.Test_Filtre_Chiffre_1'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Dechiffrement a partir de 1 bloc d'un generateur",
            Scenario_R.Test_Filtre_Dechiff_1'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Chiffrement a partir de 2048 blocs d'un generateur",
            Scenario_R.Test_Filtre_Chiffre_2048'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Dechiffrement a partir de 2048 blocs d'un generateur",
            Scenario_R.Test_Filtre_Dechiff_2048'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Chiffrement a partir de 8192 blocs d'un generateur",
            Scenario_R.Test_Filtre_Chiffre_8192'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Dechiffrement a partir de 8192 blocs d'un generateur",
            Scenario_R.Test_Filtre_Dechiff_8192'Access
            )
         );

      return ptr_test_suite;

   end Fonc_Suite;

end Chaine_Ravenscar_Suite_P;
