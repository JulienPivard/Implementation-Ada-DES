with AUnit.Test_Caller;

with Des_P.Bloc_P.Bloc_64_P.Test_P;
use  Des_P.Bloc_P.Bloc_64_P.Test_P;

package body Bloc_64_Suite_P is

   package Caller is new AUnit.Test_Caller
      (Des_P.Bloc_P.Bloc_64_P.Test_P.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Bloc_64_Suite return AUnit.Test_Suites.Access_Test_Suite is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String := "(Test bloc de 64 bits) ";
   begin

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Initialisation bloc vide",
            Test_Initialisation'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Bits change aleatoirement",
            Test_Bits_Aleatoire'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Bits change aleatoirement acces par bloc",
            Test_Bits_Aleatoire_Par_Bloc'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Bits change aleatoirement " &
            "avec 1 echange gauche droite",
            Test_Bits_Aleatoire_1_Echange'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Bits change aleatoirement acces par bloc " &
            "avec 1 echange gauche droite",
            Test_Bits_Aleatoire_Par_Bloc_1_Echange'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Bits change aleatoirement " &
            "avec 2 echanges gauche droite",
            Test_Bits_Aleatoire_2_Echanges'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Bits change aleatoirement acces par bloc " &
            "avec 2 echanges gauche droite",
            Test_Bits_Aleatoire_Par_Bloc_2_Echanges'Access
            )
         );

      return ptr_test_suite;

   end Fonc_Bloc_64_Suite;

end Bloc_64_Suite_P;