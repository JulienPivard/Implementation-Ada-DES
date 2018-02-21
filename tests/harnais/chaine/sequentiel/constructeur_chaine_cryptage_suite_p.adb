with AUnit.Test_Caller;

with Des_P.Chaine_P.Sequentiel_P.Constructeur_Cryptage_P.Test_P;
use  Des_P.Chaine_P.Sequentiel_P.Constructeur_Cryptage_P.Test_P;

package body Constructeur_Chaine_Cryptage_Suite_P is

   package Caller is new AUnit.Test_Caller
      (Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String := "(Tests constructeur chaine cryptage) ";
   begin

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Initialisation chaine vide",
            Test_Initialisation'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Construction chaine",
            Test_Construction'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Recuperation chaine construite",
            Test_Recuperation'Access
            )
         );

      return ptr_test_suite;

   end Fonc_Suite;

end Constructeur_Chaine_Cryptage_Suite_P;
