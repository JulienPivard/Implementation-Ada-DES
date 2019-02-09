with AUnit.Test_Caller;

with Des_P.Chaine_P.Sequentiel_P.Test_P;

package body Chaine_Sequentiel_Suite_P is

   package Scenario_R renames Des_P.Chaine_P.Sequentiel_P.Test_P;

   package Caller is new AUnit.Test_Caller (Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      Nom_Test : constant String := "(Tests chaine sequentiel) ";
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
            Scenario_R.Test_Filtre_Dechiffre_1'Access
            )
         );

      Ptr_Test_Suite.all.Add_Test
         (Caller.Create
            (Nom_Test & "Chiffrement a partir de 2048 bloc d'un generateur",
            Scenario_R.Test_Filtre_Chiffre_2048'Access
            )
         );

      Ptr_Test_Suite.all.Add_Test
         (Caller.Create
            (Nom_Test & "Dechiffrement a partir de 2048 bloc d'un generateur",
            Scenario_R.Test_Filtre_Dechiffre_2048'Access
            )
         );

      Ptr_Test_Suite.all.Add_Test
         (Caller.Create
            (Nom_Test & "Chiffrement a partir de 8192 bloc d'un generateur",
            Scenario_R.Test_Filtre_Chiffre_8192'Access
            )
         );

      Ptr_Test_Suite.all.Add_Test
         (Caller.Create
            (Nom_Test & "Dechiffrement a partir de 8192 bloc d'un generateur",
            Scenario_R.Test_Filtre_Dechiffre_8192'Access
            )
         );

      Ptr_Test_Suite.all.Add_Test
         (Caller.Create
            (Nom_Test & "Execution avec 2 filtres",
            Scenario_R.Test_Execution_2_Filtres'Access
            )
         );

      Ptr_Test_Suite.all.Add_Test
         (Caller.Create
            (Nom_Test & "Execution avec tous les filtres",
            Scenario_R.Test_Execution_18_Filtres'Access
            )
         );

      return Ptr_Test_Suite;

   end Fonc_Suite;

end Chaine_Sequentiel_Suite_P;
