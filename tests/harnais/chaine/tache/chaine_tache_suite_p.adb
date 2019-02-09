with AUnit.Test_Caller;

with Des_P.Chaine_P.Taches_P.Test_P;

package body Chaine_Tache_Suite_P is

   package Scenario_R renames Des_P.Chaine_P.Taches_P.Test_P;

   package Caller is new AUnit.Test_Caller (Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      Nom_Test : constant String := "(Tests chaine tache) ";
   begin

      Ptr_Test_Suite.all.Add_Test
         (Caller.Create
            (Nom_Test & "Chiffrement a partir de 1 bloc d'un generateur",
            Scenario_R.Test_Filtre_Chiffre_1'Access
            )
         );

      Ptr_Test_Suite.all.Add_Test
         (Caller.Create
            (Nom_Test & "Dechiffrement a partir de 1 bloc d'un generateur",
            Scenario_R.Test_Filtre_Dechiff_1'Access
            )
         );

      Ptr_Test_Suite.all.Add_Test
         (Caller.Create
            (Nom_Test & "Chiffrement a partir de 2048 blocs d'un generateur",
            Scenario_R.Test_Filtre_Chiffre_2048'Access
            )
         );

      Ptr_Test_Suite.all.Add_Test
         (Caller.Create
            (Nom_Test & "Dechiffrement a partir de 2048 blocs d'un generateur",
            Scenario_R.Test_Filtre_Dechiff_2048'Access
            )
         );

      Ptr_Test_Suite.all.Add_Test
         (Caller.Create
            (Nom_Test & "Chiffrement a partir de 8192 blocs d'un generateur",
            Scenario_R.Test_Filtre_Chiffre_8192'Access
            )
         );

      Ptr_Test_Suite.all.Add_Test
         (Caller.Create
            (Nom_Test & "Dechiffrement a partir de 8192 blocs d'un generateur",
            Scenario_R.Test_Filtre_Dechiff_8192'Access
            )
         );

      return Ptr_Test_Suite;

   end Fonc_Suite;

end Chaine_Tache_Suite_P;
