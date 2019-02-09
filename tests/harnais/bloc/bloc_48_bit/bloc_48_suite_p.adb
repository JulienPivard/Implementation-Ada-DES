with AUnit.Test_Caller;

with Des_P.Bloc_P.Bloc_48_P.Test_P;

package body Bloc_48_Suite_P is

   package Scenario_R renames Des_P.Bloc_P.Bloc_48_P.Test_P;

   package Caller is new AUnit.Test_Caller (Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String := "(Test bloc de 48 bits) ";
   begin

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Initialisation bloc vide",
            Scenario_R.Test_Initialisation'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 1 bit par 1 bit",
            Scenario_R.Test_Modification_Un_Bit_Par_Un_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Bits change aleatoirement",
            Scenario_R.Test_Change_Bits_Aleatoirement'Access
            )
         );

      return ptr_test_suite;

   end Fonc_Suite;

end Bloc_48_Suite_P;
