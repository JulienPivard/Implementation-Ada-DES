with AUnit.Test_Caller;

with Des_P.Etage_P.Filtrage_P.Test_P;

package body Etage_Suite_P is

   package Caller is new AUnit.Test_Caller
      (Des_P.Etage_P.Filtrage_P.Test_P.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite return AUnit.Test_Suites.Access_Test_Suite is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String := "(Test etage sequentiel) ";
      use Des_P.Etage_P.Filtrage_P.Test_P;
   begin

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Creation d'un etage sans successeur",
            Test_Initialisation_Sans_Successeur'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Creation d'un etage avec un successeur",
            Test_Initialisation_Avec_Successeur'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Ajout d'un filtre a un etage sans successeur",
            Test_Ajout_Filtre_Sans_Successeur'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Ajout d'un filtre a un etage avec successeur",
            Test_Ajout_Filtre_Avec_Successeur'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Filtrage d'un etage sans successeur",
            Test_Filtrer_Sans_Successeur'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Filtrage d'un etage avec successeur",
            Test_Filtrer_Avec_Successeur'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Lance l'iteration sur un etage sans successeur",
            Test_Iterer_Sans_Successeur'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Lance l'iteration sur un etage avec successeur",
            Test_Iterer_Avec_Successeur'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Test l'ajout d'un successeur a l'estage actuel",
            Test_Ajouter_1_Successeur'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Test l'ajout de deux successeurs a l'estage actuel",
            Test_Ajouter_2_Successeur'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification de la clef de 48 stocke",
            Test_Modifier_Clef_48'Access
            )
         );

      return ptr_test_suite;

   end Fonc_Suite;

end Etage_Suite_P;
