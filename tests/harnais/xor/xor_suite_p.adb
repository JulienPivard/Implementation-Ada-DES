with AUnit.Test_Caller;

with Des_P.Bloc_Xor_Clef_P.Test_P;

package body Xor_Suite_P is

   package Scenario_R renames Des_P.Bloc_Xor_Clef_P.Test_P;

   package Caller is new AUnit.Test_Caller (Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      Nom_Test : constant String := "(Test xor entre bloc et clef de 48) ";
   begin

      Ptr_Test_Suite.all.Add_Test
         (Caller.Create
            (Nom_Test & "Bloc XOR Clef",
            Scenario_R.Test_Xor_G_D'Access
            )
         );

      Ptr_Test_Suite.all.Add_Test
         (Caller.Create
            (Nom_Test & "Clef XOR Bloc",
            Scenario_R.Test_Xor_D_G'Access
            )
         );

      return Ptr_Test_Suite;

   end Fonc_Suite;

end Xor_Suite_P;
