with AUnit.Test_Caller;

with Des_P.Bloc_P.Bloc_32_P.Constructeur_P.Test_P;
use Des_P.Bloc_P.Bloc_32_P.Constructeur_P.Test_P;

package body Constructeur_Bloc_32_Suite_P is

   package Caller is new AUnit.Test_Caller (Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String := "(Test Constructeur Bloc 32 bits) ";
   begin

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Preparation bloc vide",
         Test_Preparation'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Construction d'un bloc a partir d'un brut",
         Test_Construction_Avec_Brut'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Construction d'un bloc a partir d'un bloc de 32 bits",
         Test_Construction_Avec_Bloc_32'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Construction d'un bloc a partir d'un bloc de 48 bits",
         Test_Construction_Avec_Bloc_48'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Recuperation d'un bloc fini",
         Test_Recuperation'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Transformation d'un bloc en un brut",
         Test_Transformation_Brut'Access
         )
      );

      return ptr_test_suite;

   end Fonc_Suite;

end Constructeur_Bloc_32_Suite_P;
