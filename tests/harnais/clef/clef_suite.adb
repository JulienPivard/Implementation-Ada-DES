with AUnit.Test_Caller;

with Des_P.Clef_P.Test_P;

package body Clef_Suite is

   package Caller is new AUnit.Test_Caller
      (Des_P.Clef_P.Test_P.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Clef_Suite return AUnit.Test_Suites.Access_Test_Suite is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String := "(Test clef )";
   begin

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Pas de decalage vers la gauche",
            Des_P.Clef_P.Test_P.Test_Decaler_0_Bit_A_Gauche'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Decalage d'un bit vers la gauche",
            Des_P.Clef_P.Test_P.Test_Decaler_1_Bit_A_Gauche'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Decalage de deux bits vers la gauche",
            Des_P.Clef_P.Test_P.Test_Decaler_2_Bit_A_Gauche'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Decalage de trois bits vers la gauche",
            Des_P.Clef_P.Test_P.Test_Decaler_3_Bit_A_Gauche'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Lecture des bits sans decalage",
            Des_P.Clef_P.Test_P.Test_Lire_Bit_Sans_Decalage'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Lecture des bits avec 1 decalage",
            Des_P.Clef_P.Test_P.Test_Lire_Bit_1_Decalage'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Lecture des bits avec 2 decalage",
            Des_P.Clef_P.Test_P.Test_Lire_Bit_2_Decalage'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Lecture des bits avec 3 decalage",
            Des_P.Clef_P.Test_P.Test_Lire_Bit_3_Decalage'Access
            )
         );

      return ptr_test_suite;

   end Fonc_Clef_Suite;

end Clef_Suite;
