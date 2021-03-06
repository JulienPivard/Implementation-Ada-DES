with AUnit.Test_Caller;

with Des_P.Clef_P.Clef_56_P.Test_P;

package body Clef_56_Suite_P is

   package Scenario_R renames Des_P.Clef_P.Clef_56_P.Test_P;

   package Caller is new AUnit.Test_Caller (Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      Nom_Test : constant String := "(Test clef 56 bits) ";
   begin

      Ptr_Test_Suite.all.Add_Test
      (Caller.Create
         (Nom_Test & "Pas de decalage vers la gauche",
            Scenario_R.Test_Decaler_0_Bit_A_Gauche'Access
         )
      );

      Ptr_Test_Suite.all.Add_Test
      (Caller.Create
         (Nom_Test & "Decalage d'un bit vers la gauche",
            Scenario_R.Test_Decaler_1_Bit_A_Gauche'Access
         )
      );

      Ptr_Test_Suite.all.Add_Test
      (Caller.Create
         (Nom_Test & "Decalage de deux bits vers la gauche",
            Scenario_R.Test_Decaler_2_Bit_A_Gauche'Access
         )
      );

      Ptr_Test_Suite.all.Add_Test
      (Caller.Create
         (Nom_Test & "Decalage de trois bits vers la gauche",
            Scenario_R.Test_Decaler_3_Bit_A_Gauche'Access
         )
      );

      Ptr_Test_Suite.all.Add_Test
      (Caller.Create
         (Nom_Test & "Decalage de un bit successivement vers la gauche",
            Scenario_R.Test_1_Decalage_Successif_A_Gauche'Access
         )
      );

      Ptr_Test_Suite.all.Add_Test
      (Caller.Create
         (Nom_Test & "Decalage de un bit successivement vers la droite",
            Scenario_R.Test_1_Decalage_Successif_A_Droite'Access
         )
      );

      Ptr_Test_Suite.all.Add_Test
      (Caller.Create
         (Nom_Test & "Decalage de deux bits successivement vers la gauche",
            Scenario_R.Test_2_Decalage_Successif_A_Gauche'Access
         )
      );

      Ptr_Test_Suite.all.Add_Test
      (Caller.Create
         (Nom_Test & "Decalage de deux bits successivement vers la droite",
            Scenario_R.Test_2_Decalage_Successif_A_Droite'Access
         )
      );

      Ptr_Test_Suite.all.Add_Test
      (Caller.Create
         (Nom_Test & "Decalage de trois bits successivement vers la gauche",
            Scenario_R.Test_3_Decalage_Successif_A_Gauche'Access
         )
      );

      Ptr_Test_Suite.all.Add_Test
      (Caller.Create
         (Nom_Test & "Decalage de trois bits successivement vers la droite",
            Scenario_R.Test_3_Decalage_Successif_A_Droite'Access
         )
      );

      Ptr_Test_Suite.all.Add_Test
      (Caller.Create
         (Nom_Test & "Lecture des bits sans decalage",
            Scenario_R.Test_Lire_Bit_Sans_Decalage'Access
         )
      );

      Ptr_Test_Suite.all.Add_Test
      (Caller.Create
         (Nom_Test & "Lecture des bits avec 1 decalage",
            Scenario_R.Test_Lire_Bit_1_Decalage'Access
         )
      );

      Ptr_Test_Suite.all.Add_Test
      (Caller.Create
         (Nom_Test & "Lecture des bits avec 2 decalage",
            Scenario_R.Test_Lire_Bit_2_Decalage'Access
         )
      );

      Ptr_Test_Suite.all.Add_Test
      (Caller.Create
         (Nom_Test & "Lecture des bits avec 3 decalage",
            Scenario_R.Test_Lire_Bit_3_Decalage'Access
         )
      );

      Ptr_Test_Suite.all.Add_Test
      (Caller.Create
         (Nom_Test & "Lecture des bits avec 1 decalage successif",
            Scenario_R.Test_Lire_Bit_1_Decalage_Successif'Access
         )
      );

      Ptr_Test_Suite.all.Add_Test
      (Caller.Create
         (Nom_Test & "Lecture des bits avec 2 decalages successif",
            Scenario_R.Test_Lire_Bit_2_Decalage_Successif'Access
         )
      );

      Ptr_Test_Suite.all.Add_Test
      (Caller.Create
         (Nom_Test & "Lecture des bits avec 3 decalages successif",
            Scenario_R.Test_Lire_Bit_3_Decalage_Successif'Access
         )
      );

      Ptr_Test_Suite.all.Add_Test
      (Caller.Create
         (Nom_Test & "Construction d'une clef de 48 bits avec 0 decalage",
            Scenario_R.Test_Construire_Clef_48_0_Decalages'Access
         )
      );

      Ptr_Test_Suite.all.Add_Test
      (Caller.Create
         (Nom_Test & "Construction d'une clef de 48 bits avec 1 decalage",
            Scenario_R.Test_Construire_Clef_48_1_Decalages'Access
         )
      );

      Ptr_Test_Suite.all.Add_Test
      (Caller.Create
         (Nom_Test & "Construction d'une clef de 48 bits avec 2 decalage",
            Scenario_R.Test_Construire_Clef_48_2_Decalages'Access
         )
      );

      Ptr_Test_Suite.all.Add_Test
      (Caller.Create
         (Nom_Test & "Construction d'une clef de 48 bits avec 3 decalage",
            Scenario_R.Test_Construire_Clef_48_3_Decalages'Access
         )
      );

      return Ptr_Test_Suite;

   end Fonc_Suite;

end Clef_56_Suite_P;
