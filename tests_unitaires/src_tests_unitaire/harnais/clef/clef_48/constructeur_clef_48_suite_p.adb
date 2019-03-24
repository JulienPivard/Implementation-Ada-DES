with AUnit.Test_Caller;

with Des_P.Clef_P.Clef_48_P.Faiseur_P.Test_P;

package body Constructeur_Clef_48_Suite_P is

   package Scenario_R renames Des_P.Clef_P.Clef_48_P.Faiseur_P.Test_P;

   package Caller is new AUnit.Test_Caller (Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      Nom_Test : constant String := "(Test constructeur clef 48 bits) ";
   begin

      Ptr_Test_Suite.all.Add_Test
      (Caller.Create
         (Nom_Test & "Preparation d'une clef de 48 vide",
         Scenario_R.Test_Preparation'Access
         )
      );

      Ptr_Test_Suite.all.Add_Test
      (Caller.Create
         (Nom_Test & "Construction d'une clef de 48",
         Scenario_R.Test_Construire'Access
         )
      );

      Ptr_Test_Suite.all.Add_Test
      (Caller.Create
         (Nom_Test & "Recuperation de la clef de 48 construite",
         Scenario_R.Test_Recuperation'Access
         )
      );

      return Ptr_Test_Suite;

   end Fonc_Suite;

end Constructeur_Clef_48_Suite_P;
