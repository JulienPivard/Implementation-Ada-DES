with AUnit.Test_Caller;

with Des_P.Etage_P.Test_P;

package body Etage_Suite_P is

   package Caller is new AUnit.Test_Caller
      (Des_P.Etage_P.Test_P.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite return AUnit.Test_Suites.Access_Test_Suite is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String := "(Test etage) ";
   begin

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Creation d'un etage sans successeur",
            Des_P.Etage_P.Test_P.Test_Initialisation_Sans_Successeur'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Creation d'un etage avec un successeur",
            Des_P.Etage_P.Test_P.Test_Initialisation_Avec_Successeur'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Ajout d'un filtre a un etage sans successeur",
            Des_P.Etage_P.Test_P.Test_Ajout_Filtre_Sans_Successeur'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Ajout d'un filtre a un etage avec successeur",
            Des_P.Etage_P.Test_P.Test_Ajout_Filtre_Avec_Successeur'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Filtrage d'un etage sans successeur",
            Des_P.Etage_P.Test_P.Test_Filtrer_Sans_Successeur'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Filtrage d'un etage avec successeur",
            Des_P.Etage_P.Test_P.Test_Filtrer_Avec_Successeur'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Lance l'iteration sur un etage sans successeur",
            Des_P.Etage_P.Test_P.Test_Iterer_Sans_Successeur'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Lance l'iteration sur un etage avec successeur",
            Des_P.Etage_P.Test_P.Test_Iterer_Avec_Successeur'Access
            )
         );

      return ptr_test_suite;

   end Fonc_Suite;

end Etage_Suite_P;
