with AUnit.Test_Caller;

with Des_P.Bloc_P.Bloc_32_P.Test_P;
use  Des_P.Bloc_P.Bloc_32_P.Test_P;

package body Bloc_32_Suite_P is

   package Caller is new AUnit.Test_Caller (Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String := "(Test bloc de 32 bits) ";
   begin

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Initialisation bloc vide",
            Test_Initialisation'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 1 bit par 1 bit",
            Test_Modification_Un_Bit_Par_Un_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Bits change aleatoirement",
            Test_Change_Bits_Aleatoirement'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Ou Exclusif",
            Test_Ou_Exclusif'Access
            )
         );

      return ptr_test_suite;

   end Fonc_Suite;

end Bloc_32_Suite_P;
