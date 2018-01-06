with Clef_48_Suite_P;
with Constructeur_Clef_48_Suite_P;
with Clef_56_Suite_P;
with Constructeur_Clef_56_Suite_P;
with Clef_64_Suite_P;
with Constructeur_Clef_64_Suite_P;

package body Suite_De_Tests_Clef_P is

   ---------------------------------------------------------------------------
   function Fonc_Suite return AUnit.Test_Suites.Access_Test_Suite is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
   begin
      ptr_test_suite.all.Add_Test
         (Clef_48_Suite_P.Fonc_Clef_48_Suite);
      ptr_test_suite.all.Add_Test
         (Constructeur_Clef_48_Suite_P.Fonc_Constructeur_Clef_48_Suite);
      ptr_test_suite.all.Add_Test
         (Clef_56_Suite_P.Fonc_Clef_56_Suite);
      ptr_test_suite.all.Add_Test
         (Constructeur_Clef_56_Suite_P.Fonc_Constructeur_Clef_56_Suite);
      ptr_test_suite.all.Add_Test
         (Clef_64_Suite_P.Fonc_Clef_64_Suite);
      ptr_test_suite.all.Add_Test
         (Constructeur_Clef_64_Suite_P.Fonc_Constructeur_Clef_64_Suite);

      return ptr_test_suite;
   end Fonc_Suite;

end Suite_De_Tests_Clef_P;
