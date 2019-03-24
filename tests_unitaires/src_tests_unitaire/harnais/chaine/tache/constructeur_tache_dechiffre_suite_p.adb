with AUnit.Test_Caller;

with Des_P.Chaine_P.Taches_P.Faiseur_Dechiffre_P.Test_P;

package body Constructeur_Tache_Dechiffre_Suite_P is

   package Scenario_R renames
      Des_P.Chaine_P.Taches_P.Faiseur_Dechiffre_P.Test_P;

   package Caller is new AUnit.Test_Caller (Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      Nom_Test : constant String :=
         "(Tests constructeur tache dechiffrement) ";
   begin

      Ptr_Test_Suite.all.Add_Test
         (Caller.Create
            (Nom_Test & "Initialisation chaine vide",
            Scenario_R.Test_Initialisation'Access
            )
         );

      Ptr_Test_Suite.all.Add_Test
         (Caller.Create
            (Nom_Test & "Construction chaine",
            Scenario_R.Test_Construction'Access
            )
         );

      Ptr_Test_Suite.all.Add_Test
         (Caller.Create
            (Nom_Test & "Recuperation chaine construite",
            Scenario_R.Test_Recuperation'Access
            )
         );

      return Ptr_Test_Suite;

   end Fonc_Suite;

end Constructeur_Tache_Dechiffre_Suite_P;
