with AUnit.Test_Caller;

with Des_P.Clef_P.Clef_56_P.Constructeur_P.Test_P;
use  Des_P.Clef_P.Clef_56_P.Constructeur_P.Test_P;

package body Constructeur_Clef_56_Suite_P is

   package Caller is new AUnit.Test_Caller (Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String := "(Test constructeur clef 56 bits) ";
   begin

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Preparation d'une clef de 56 vide",
         Test_Preparation'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Construction d'une clef de 56",
         Test_Construire'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Recuperation de la clef de 56 construite",
         Test_Recuperation'Access
         )
      );

      return ptr_test_suite;

   end Fonc_Suite;

end Constructeur_Clef_56_Suite_P;
