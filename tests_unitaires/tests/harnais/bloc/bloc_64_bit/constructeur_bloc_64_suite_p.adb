with AUnit.Test_Caller;

with Des_P.Bloc_P.Bloc_64_P.Faiseur_P.Test_P;

package body Constructeur_Bloc_64_Suite_P is

   package Scenario_R renames Des_P.Bloc_P.Bloc_64_P.Faiseur_P.Test_P;

   package Caller is new AUnit.Test_Caller (Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      Nom_Test : constant String := "(Test Constructeur Bloc 64 bits) ";
   begin

      Ptr_Test_Suite.all.Add_Test
      (Caller.Create
         (Nom_Test & "Preparation bloc vide",
         Scenario_R.Test_Preparation'Access
         )
      );

      Ptr_Test_Suite.all.Add_Test
      (Caller.Create
         (Nom_Test & "Construction d'un bloc",
         Scenario_R.Test_Construction'Access
         )
      );

      Ptr_Test_Suite.all.Add_Test
      (Caller.Create
         (Nom_Test & "Recuperation d'un bloc fini",
         Scenario_R.Test_Recuperation'Access
         )
      );

      Ptr_Test_Suite.all.Add_Test
      (Caller.Create
         (Nom_Test & "Transformation d'un bloc en un brut",
         Scenario_R.Test_Transformation_Brut'Access
         )
      );

      return Ptr_Test_Suite;

   end Fonc_Suite;

end Constructeur_Bloc_64_Suite_P;
