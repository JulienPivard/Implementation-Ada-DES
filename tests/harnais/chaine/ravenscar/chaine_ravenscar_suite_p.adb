with AUnit.Test_Caller;

with Des_P.Chaine_P.Ravenscar_P.Test_P;
use  Des_P.Chaine_P.Ravenscar_P.Test_P;

package body Chaine_Ravenscar_Suite_P is

   package Caller is new AUnit.Test_Caller
      (Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String := "(Tests chaine ravenscar) ";
   begin

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Cryptage à partir des blocs d'un générateur",
            Test_Filtre_Crypt'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Decryptage a partir des blocs d'un générateur",
            Test_Filtre_Decrypt'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Comparaison cryptage avec la methode sequentiel",
            Test_Comparaison_Sequentiel_Crypt'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Comparaison decryptage avec la methode sequentiel",
            Test_Comparaison_Sequentiel_Decrypt'Access
            )
         );

      return ptr_test_suite;

   end Fonc_Suite;

end Chaine_Ravenscar_Suite_P;
