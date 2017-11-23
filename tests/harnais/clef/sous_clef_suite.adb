with AUnit.Test_Caller;

with Des_P.Sous_Clef_P.Test_P;

package body Sous_Clef_Suite is

   package Caller is new AUnit.Test_Caller
      (Des_P.Sous_Clef_P.Test_P.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Sous_Clef_Suite return AUnit.Test_Suites.Access_Test_Suite is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String := "(Test sous clef )";
   begin

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Lecture de bit d'une clef predefinie",
            Des_P.Sous_Clef_P.Test_P.Test_Lecture_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Lecture de bit d'une clef aleatoire",
            Des_P.Sous_Clef_P.Test_P.Test_Bits_Aleatoire'Access
            )
         );

      return ptr_test_suite;

   end Fonc_Sous_Clef_Suite;

end Sous_Clef_Suite;
