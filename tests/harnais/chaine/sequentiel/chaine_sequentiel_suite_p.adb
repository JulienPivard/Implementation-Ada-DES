with AUnit.Test_Caller;

with Des_P.Chaine_P.Sequentiel_P.Test_P;
use  Des_P.Chaine_P.Sequentiel_P.Test_P;

package body Chaine_Sequentiel_Suite_P is

   package Caller is new AUnit.Test_Caller
      (Test_Fixt_T);

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
            (nom_test & "Execution du filtrage",
            Test_Execution'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Filtrage",
            Test_Filtre'Access
            )
         );

      return ptr_test_suite;

   end Fonc_Suite;

end Chaine_Sequentiel_Suite_P;