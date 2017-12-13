with AUnit.Test_Caller;

with Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Test_P;

package body Constructeur_Bloc_64_Suite_P is

   package Caller is new AUnit.Test_Caller
      (Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Test_P.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Constructeur_Bloc_64_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String := "(Test Constructeur Bloc 64 bits) ";
   begin

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Preparation bloc vide",
         Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Test_P.Test_Preparation'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Construction d'un bloc",
         Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Test_P.Test_Construction'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Recuperation d'un bloc fini",
         Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Test_P.Test_Recuperation'Access
         )
      );
      return ptr_test_suite;

   end Fonc_Constructeur_Bloc_64_Suite;

end Constructeur_Bloc_64_Suite_P;
