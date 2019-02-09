with AUnit.Test_Caller;

with Des_P.Chaine_P.Sequentiel_P.Test_P;

package body Chaine_Sequentiel_Suite_P is

   package Scenario_R renames Des_P.Chaine_P.Sequentiel_P.Test_P;

   package Caller is new AUnit.Test_Caller (Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String := "(Tests chaine sequentiel) ";
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
            Scenario_R.Test_Filtre_Dechiffre_1'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Chiffrement a partir de 2048 bloc d'un generateur",
            Scenario_R.Test_Filtre_Chiffre_2048'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Dechiffrement a partir de 2048 bloc d'un generateur",
            Scenario_R.Test_Filtre_Dechiffre_2048'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Chiffrement a partir de 8192 bloc d'un generateur",
            Scenario_R.Test_Filtre_Chiffre_8192'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Dechiffrement a partir de 8192 bloc d'un generateur",
            Scenario_R.Test_Filtre_Dechiffre_8192'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Execution avec 2 filtres",
            Scenario_R.Test_Execution_2_Filtres'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Execution avec tous les filtres",
            Scenario_R.Test_Execution_18_Filtres'Access
            )
         );

      return ptr_test_suite;

   end Fonc_Suite;

end Chaine_Sequentiel_Suite_P;
