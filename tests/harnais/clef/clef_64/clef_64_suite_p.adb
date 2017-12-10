with AUnit.Test_Caller;

with Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P.Test_P;

package body Clef_64_Suite_P is

   package Caller is new AUnit.Test_Caller
      (Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P.Test_P.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Clef_64_Suite return AUnit.Test_Suites.Access_Test_Suite is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String := "(Test clef 64 bits) ";
      use Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P.Test_P;
   begin

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Verifie la presence d'un constructeur de clef 56",
         Test_Possede_Constructeur_56'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Verifie la presence d'un constructeur de clef 48",
         Test_Possede_Constructeur_48'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Verifie la levee d'exception absence de constructeur 56",
         Test_Construire_Clef_56_Exception'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Construction d'une clef de 56 bits",
         Test_Construire_Clef_56'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Construction d'une clef de 48 bits " &
         "a partir de la clef de 56.",
         Test_Construire_Clef_48_Via_56'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Lecture de bits predefini.",
         Test_Lecture_Bit'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Lecture de bits genere aleatoirement.",
         Test_Bits_Aleatoire'Access
         )
      );

      return ptr_test_suite;
   end Fonc_Clef_64_Suite;

end Clef_64_Suite_P;
