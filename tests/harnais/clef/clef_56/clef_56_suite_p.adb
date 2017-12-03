with AUnit.Test_Caller;

with Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Test_P;

package body Clef_56_Suite_P is

   package Caller is new AUnit.Test_Caller
      (Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Test_P.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Clef_56_Suite return AUnit.Test_Suites.Access_Test_Suite is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String := "(Test clef 56 bits) ";
   begin

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Verifie la presence d'un constructeur de clef 48 bits",
         Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Test_P.
            Test_Possede_Constructeur_48'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Pas de decalage vers la gauche",
         Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Test_P.
            Test_Decaler_0_Bit_A_Gauche'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Decalage d'un bit vers la gauche",
         Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Test_P.
            Test_Decaler_1_Bit_A_Gauche'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Decalage de deux bits vers la gauche",
         Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Test_P.
            Test_Decaler_2_Bit_A_Gauche'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Decalage de trois bits vers la gauche",
         Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Test_P.
            Test_Decaler_3_Bit_A_Gauche'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Decalage de un bit successivement vers la gauche",
         Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Test_P.
            Test_1_Decalage_Successif_A_Gauche'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Decalage de deux bits successivement vers la gauche",
         Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Test_P.
            Test_2_Decalage_Successif_A_Gauche'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Decalage de trois bits successivement vers la gauche",
         Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Test_P.
            Test_3_Decalage_Successif_A_Gauche'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Lecture des bits sans decalage",
         Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Test_P.
            Test_Lire_Bit_Sans_Decalage'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Lecture des bits avec 1 decalage",
         Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Test_P.
            Test_Lire_Bit_1_Decalage'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Lecture des bits avec 2 decalage",
         Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Test_P.
            Test_Lire_Bit_2_Decalage'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Lecture des bits avec 3 decalage",
         Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Test_P.
            Test_Lire_Bit_3_Decalage'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Lecture des bits avec 1 decalage successif",
         Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Test_P.
            Test_Lire_Bit_1_Decalage_Successif'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Lecture des bits avec 2 decalages successif",
         Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Test_P.
            Test_Lire_Bit_2_Decalage_Successif'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Lecture des bits avec 3 decalages successif",
         Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Test_P.
            Test_Lire_Bit_3_Decalage_Successif'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Construction d'une clef de 48 bits avec 0 decalage",
         Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Test_P.
            Test_Construire_Clef_48_0_Decalages'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Construction d'une clef de 48 bits avec 1 decalage",
         Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Test_P.
            Test_Construire_Clef_48_1_Decalages'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Construction d'une clef de 48 bits avec 2 decalage",
         Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Test_P.
            Test_Construire_Clef_48_2_Decalages'Access
         )
      );

      ptr_test_suite.all.Add_Test
      (Caller.Create
         (nom_test & "Construction d'une clef de 48 bits avec 3 decalage",
         Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Test_P.
            Test_Construire_Clef_48_3_Decalages'Access
         )
      );

      return ptr_test_suite;

   end Fonc_Clef_56_Suite;

end Clef_56_Suite_P;
