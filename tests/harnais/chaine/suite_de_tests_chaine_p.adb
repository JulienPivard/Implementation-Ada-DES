with Chaine_Sequentiel_Suite_P;

package body Suite_De_Tests_Chaine_P is

   function Fonc_Suite return AUnit.Test_Suites.Access_Test_Suite is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
   begin
      ptr_test_suite.all.Add_Test (Chaine_Sequentiel_Suite_P.Fonc_Suite);

      return ptr_test_suite;
   end Fonc_Suite;

end Suite_De_Tests_Chaine_P;
