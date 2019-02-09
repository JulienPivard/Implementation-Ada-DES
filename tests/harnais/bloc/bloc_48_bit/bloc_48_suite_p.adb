with AUnit.Test_Caller;

with Des_P.Bloc_P.Bloc_48_P.Test_P;

package body Bloc_48_Suite_P is

   package Scenario_R renames Des_P.Bloc_P.Bloc_48_P.Test_P;

   package Caller is new AUnit.Test_Caller (Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      Nom_Test : constant String := "(Test bloc de 48 bits) ";
   begin

      Ptr_Test_Suite.all.Add_Test
         (Caller.Create
            (Nom_Test & "Initialisation bloc vide",
            Scenario_R.Test_Initialisation'Access
            )
         );

      Ptr_Test_Suite.all.Add_Test
         (Caller.Create
            (Nom_Test & "Modification 1 bit par 1 bit",
            Scenario_R.Test_Modification_Un_Bit_Par_Un_Bit'Access
            )
         );

      Ptr_Test_Suite.all.Add_Test
         (Caller.Create
            (Nom_Test & "Bits change aleatoirement",
            Scenario_R.Test_Change_Bits_Aleatoirement'Access
            )
         );

      return Ptr_Test_Suite;

   end Fonc_Suite;

end Bloc_48_Suite_P;
