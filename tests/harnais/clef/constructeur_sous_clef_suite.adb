with AUnit.Test_Caller;

with Des_P.Sous_Clef_P.Constructeur_P.Test_P;

package body Constructeur_Sous_Clef_Suite is

   package Caller is new AUnit.Test_Caller
   (Des_P.Sous_Clef_P.Constructeur_P.Test_P.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Constructeur_Sous_Clef_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String := "(Test constructeur sous clef )";
   begin

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Preparation d'une sous clef vide",
            Des_P.Sous_Clef_P.Constructeur_P.Test_P.Test_Preparation'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Construction d'une sous clef",
            Des_P.Sous_Clef_P.Constructeur_P.Test_P.Test_Construire'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Recuperation de la sous clef construite",
            Des_P.Sous_Clef_P.Constructeur_P.Test_P.Test_Recuperation'Access
            )
         );

      return ptr_test_suite;

   end Fonc_Constructeur_Sous_Clef_Suite;

end Constructeur_Sous_Clef_Suite;
