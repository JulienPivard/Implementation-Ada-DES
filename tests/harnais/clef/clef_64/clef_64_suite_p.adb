with AUnit.Test_Caller;

with Des_P.Clef_P.Clef_64_P.Test_P;

package body Clef_64_Suite_P is

   package Scenario_R renames Des_P.Clef_P.Clef_64_P.Test_P;

   package Caller is new AUnit.Test_Caller (Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      Nom_Test : constant String := "(Test clef 64 bits) ";
   begin

      Ptr_Test_Suite.all.Add_Test
      (Caller.Create
         (Nom_Test & "Lecture de bits predefini.",
         Scenario_R.Test_Lecture_Bit'Access
         )
      );

      Ptr_Test_Suite.all.Add_Test
      (Caller.Create
         (Nom_Test & "Lecture de bits genere aleatoirement.",
         Scenario_R.Test_Bits_Aleatoire'Access
         )
      );

      return Ptr_Test_Suite;

   end Fonc_Suite;

end Clef_64_Suite_P;
