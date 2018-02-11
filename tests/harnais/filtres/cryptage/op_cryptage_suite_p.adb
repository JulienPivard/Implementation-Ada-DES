with AUnit.Test_Caller;

with Des_P.Filtre_P.Cryptage_P.Op_P.Test_P;
use  Des_P.Filtre_P.Cryptage_P.Op_P.Test_P;

package body Op_Cryptage_Suite_P is

   package Caller is new AUnit.Test_Caller
      (Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String := "(Tests filtre permutation final) ";
   begin

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Permutation final",
            Test_Permutation_Sortante'Access
            )
         );

      return ptr_test_suite;

   end Fonc_Suite;

end Op_Cryptage_Suite_P;
