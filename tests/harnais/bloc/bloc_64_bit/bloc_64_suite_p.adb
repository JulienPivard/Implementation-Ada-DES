with AUnit.Test_Caller;

with Des_P.Bloc_P.Bloc_64_P.Test_P;
use  Des_P.Bloc_P.Bloc_64_P.Test_P;

package body Bloc_64_Suite_P is

   package Caller is new AUnit.Test_Caller
      (Des_P.Bloc_P.Bloc_64_P.Test_P.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Bloc_64_Suite return AUnit.Test_Suites.Access_Test_Suite is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String := "(Test bloc de 64 bits) ";
   begin

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Initialisation bloc vide",
            Test_Initialisation'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 1 bit par 1 bit",
            Test_Modification_Un_Bit_Par_Un_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Bits change aleatoirement",
            Test_Bits_Aleatoire'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Bits change aleatoirement acces par bloc",
            Test_Bits_Aleatoire_Par_Bloc'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Bits change aleatoirement " &
            "avec 1 eschange gauche droite",
            Test_Bits_Aleatoire_1_Echange'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Bits change aleatoirement acces par bloc " &
            "avec 1 eschange gauche droite",
            Test_Bits_Aleatoire_Par_Bloc_1_Echange'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Bits change aleatoirement " &
            "avec 2 eschanges gauche droite",
            Test_Bits_Aleatoire_2_Echanges'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Bits change aleatoirement acces par bloc " &
            "avec 2 eschanges gauche droite",
            Test_Bits_Aleatoire_Par_Bloc_2_Echanges'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Bloc de 32 bits aleatoire accede par la " &
            "fonction Lire_Bloc",
            Test_Lecture_Bloc_32_Aleatoire'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Bloc de 32 bits aleatoire ecrit par la " &
            "fonction Ecrire_Bloc",
            Test_Ecriture_Bloc_32_Aleatoire'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Bloc de 32 bits aleatoire accede par la " &
            "fonction Lire_Bloc apres 1 eschange",
            Test_Lecture_Bloc_32_Aleatoire_1_Echange'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Bloc de 32 bits aleatoire ecrit par la " &
            "fonction Ecrire_Bloc apres 1 eschange",
            Test_Ecriture_Bloc_32_Aleatoire_1_Echange'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Bloc de 32 bits aleatoire accede par la " &
            "fonction Lire_Bloc apres 1 eschange",
            Test_Lecture_Bloc_32_Aleatoire_2_Echange'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Bloc de 32 bits aleatoire ecrit par la " &
            "fonction Ecrire_Bloc apres 1 eschange",
            Test_Ecriture_Bloc_32_Aleatoire_2_Echange'Access
            )
         );

      return ptr_test_suite;

   end Fonc_Bloc_64_Suite;

end Bloc_64_Suite_P;
