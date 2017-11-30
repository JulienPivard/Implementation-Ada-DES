with AUnit.Test_Caller;

with Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Test_P;

package body Clef_48_Suite_P is

   package Caller is new AUnit.Test_Caller
      (Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Test_P.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Clef_48_Suite return AUnit.Test_Suites.Access_Test_Suite is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String := "(Test clef 48 bits )";
   begin

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Lecture de bit d'une clef predefinie",
         Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Test_P.Test_Lecture_Bit'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Lecture de bit d'une clef aleatoire",
         Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Test_P.Test_Bits_Aleatoire'Access
         )
      );

      return ptr_test_suite;

   end Fonc_Clef_48_Suite;

end Clef_48_Suite_P;
