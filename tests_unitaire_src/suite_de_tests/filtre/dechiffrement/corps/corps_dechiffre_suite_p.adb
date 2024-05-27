with AUnit.Test_Caller;

with Des_P.Filtre_P.Corps_P.Dechiffre_P.Test_P;

package body Corps_Dechiffre_Suite_P is

   package Scenario_R renames Des_P.Filtre_P.Corps_P.Dechiffre_P.Test_P;

   package Caller is new AUnit.Test_Caller (Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      Nom_Test : constant String := "(Tests filtre dechiffrement principal) ";
   begin

      Ptr_Test_Suite.all.Add_Test
         (Caller.Create
            (Nom_Test & "1er niveau de filtre",
            Scenario_R.Test_Dechiffrement_Niveau_1'Access
            )
         );

      return Ptr_Test_Suite;

   end Fonc_Suite;

end Corps_Dechiffre_Suite_P;
