with AUnit.Test_Caller;

with Des_P.Filtre_P.Corps_P.Corps_Decryptage_P.Test_P;
use  Des_P.Filtre_P.Corps_P.Corps_Decryptage_P.Test_P;

package body Corps_Decryptage_Suite_P is

   package Caller is new AUnit.Test_Caller
      (Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String := "(Tests filtre decryptage principal) ";
   begin

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "1er niveau de filtre",
            Test_Decryptage_Niveau_1'Access
            )
         );

      return ptr_test_suite;

   end Fonc_Suite;

end Corps_Decryptage_Suite_P;
