with Entree_Cryptage_Suite_P;
with Sortie_Cryptage_Suite_P;
with Corps_Cryptage_Suite_P;

with Entree_Decryptage_Suite_P;
with Sortie_Decryptage_Suite_P;
with Corps_Decryptage_Suite_P;

with Fonction_F_Suite_P;

with Fabrique_Cryptage_Suite_P;
with Fabrique_Decryptage_Suite_P;

package body Suite_De_Tests_Filtre_P is

   function Fonc_Suite return AUnit.Test_Suites.Access_Test_Suite is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
   begin
      ptr_test_suite.all.Add_Test (Entree_Cryptage_Suite_P.Fonc_Suite);
      ptr_test_suite.all.Add_Test (Sortie_Cryptage_Suite_P.Fonc_Suite);
      ptr_test_suite.all.Add_Test (Corps_Cryptage_Suite_P.Fonc_Suite);

      ptr_test_suite.all.Add_Test (Entree_Decryptage_Suite_P.Fonc_Suite);
      ptr_test_suite.all.Add_Test (Sortie_Decryptage_Suite_P.Fonc_Suite);
      ptr_test_suite.all.Add_Test (Corps_Decryptage_Suite_P.Fonc_Suite);

      ptr_test_suite.all.Add_Test (Fonction_F_Suite_P.Fonc_Suite);

      ptr_test_suite.all.Add_Test (Fabrique_Cryptage_Suite_P.Fonc_Suite);
      ptr_test_suite.all.Add_Test (Fabrique_Decryptage_Suite_P.Fonc_Suite);

      return ptr_test_suite;
   end Fonc_Suite;

end Suite_De_Tests_Filtre_P;
