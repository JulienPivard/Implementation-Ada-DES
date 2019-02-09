with AUnit.Test_Caller;

with Des_P.Chaine_P.Ravenscar_P.Faiseur_Dechiffre_P.Test_P;

package body Constructeur_Ravenscar_Dechiffre_Suite_P is

   package Scenario_R renames
      Des_P.Chaine_P.Ravenscar_P.Faiseur_Dechiffre_P.Test_P;

   package Caller is new AUnit.Test_Caller (Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String :=
         "(Tests constructeur ravenscar dechiffrement) ";
   begin

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Initialisation chaine vide",
            Scenario_R.Test_Initialisation'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Construction chaine",
            Scenario_R.Test_Construction'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Recuperation chaine construite",
            Scenario_R.Test_Recuperation'Access
            )
         );

      return ptr_test_suite;

   end Fonc_Suite;

end Constructeur_Ravenscar_Dechiffre_Suite_P;
