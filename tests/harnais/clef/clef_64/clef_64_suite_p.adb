with AUnit.Test_Caller;

with Des_P.Clef_P.Clef_64_P.Test_P;
use  Des_P.Clef_P.Clef_64_P.Test_P;

package body Clef_64_Suite_P is

   package Caller is new AUnit.Test_Caller (Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String := "(Test clef 64 bits) ";
   begin

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Lecture de bits predefini.",
         Test_Lecture_Bit'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Lecture de bits genere aleatoirement.",
         Test_Bits_Aleatoire'Access
         )
      );

      return ptr_test_suite;

   end Fonc_Suite;

end Clef_64_Suite_P;
