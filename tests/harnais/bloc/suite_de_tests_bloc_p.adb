with Bloc_32_Suite_P;
with Constructeur_Bloc_32_Suite_P;
with Bloc_64_Suite_P;
with Constructeur_Bloc_64_Suite_P;
with Permutations_64_Suite_P;

package body Suite_De_Tests_Bloc_P is

   ---------------------------------------------------------------------------
   function Fonc_Suite return AUnit.Test_Suites.Access_Test_Suite is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
   begin
      ptr_test_suite.all.Add_Test
         (Bloc_32_Suite_P.Fonc_Bloc_32_Suite);
      ptr_test_suite.all.Add_Test
         (Constructeur_Bloc_32_Suite_P.Fonc_Constructeur_Bloc_32_Suite);
      ptr_test_suite.all.Add_Test
         (Bloc_64_Suite_P.Fonc_Bloc_64_Suite);
      ptr_test_suite.all.Add_Test
         (Constructeur_Bloc_64_Suite_P.Fonc_Constructeur_Bloc_64_Suite);
      ptr_test_suite.all.Add_Test
         (Permutations_64_Suite_P.Fonc_Permutations_64_Suite);

      return ptr_test_suite;
   end Fonc_Suite;

end Suite_De_Tests_Bloc_P;
