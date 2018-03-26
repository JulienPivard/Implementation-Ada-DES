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
            (nom_test & "Cryptage a partir de 1 bloc d'un generateur",
            Test_Filtre_Crypt_1'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Decryptage a partir de 1 bloc d'un generateur",
            Test_Filtre_Decrypt_1'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Cryptage a partir de 2048 blocs d'un generateur",
            Test_Filtre_Crypt_2048'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Decryptage a partir de 2048 blocs d'un generateur",
            Test_Filtre_Decrypt_2048'Access
            )
         );

      return ptr_test_suite;

   end Fonc_Suite;

end Chaine_Ravenscar_Suite_P;
