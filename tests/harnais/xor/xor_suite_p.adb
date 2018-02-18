with AUnit.Test_Caller;

with Des_P.Bloc_Xor_Clef_P.Test_P;

package body Xor_Suite_P is

   package Caller is new AUnit.Test_Caller
      (Des_P.Bloc_Xor_Clef_P.Test_P.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite return AUnit.Test_Suites.Access_Test_Suite is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String := "(Test xor entre bloc et clef de 48) ";
   begin

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Bloc XOR Clef",
            Des_P.Bloc_Xor_Clef_P.Test_P.Test_Xor_G_D'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Clef XOR Bloc",
            Des_P.Bloc_Xor_Clef_P.Test_P.Test_Xor_D_G'Access
            )
         );

      return ptr_test_suite;

   end Fonc_Suite;

end Xor_Suite_P;
