with AUnit.Test_Caller;

with Des_P.Etage_P.Filtrage_P.Test_P;

package body Etage_Suite_P is

   package Scenario_R renames Des_P.Etage_P.Filtrage_P.Test_P;

   package Caller is new AUnit.Test_Caller (Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String := "(Test estage sequentiel) ";
   begin

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Creation d'un estage sans successeur",
            Scenario_R.Test_Initialisation_Sans_Successeur'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Creation d'un estage avec un successeur",
            Scenario_R.Test_Initialisation_Avec_Successeur'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Ajout d'un filtre a un estage sans successeur",
            Scenario_R.Test_Ajout_Filtre_Sans_Successeur'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Ajout d'un filtre a un estage avec successeur",
            Scenario_R.Test_Ajout_Filtre_Avec_Successeur'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Filtrage d'un estage sans successeur",
            Scenario_R.Test_Filtrer_Sans_Successeur'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Filtrage d'un estage avec successeur",
            Scenario_R.Test_Filtrer_Avec_Successeur'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Lance l'iteration sur un estage sans successeur",
            Scenario_R.Test_Iterer_Sans_Successeur'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Lance l'iteration sur un estage avec successeur",
            Scenario_R.Test_Iterer_Avec_Successeur'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Test l'ajout d'un successeur a l'estage actuel",
            Scenario_R.Test_Ajouter_1_Successeur'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Test l'ajout de deux successeurs a l'estage actuel",
            Scenario_R.Test_Ajouter_2_Successeur'Access
            )
         );

      return ptr_test_suite;

   end Fonc_Suite;

end Etage_Suite_P;
