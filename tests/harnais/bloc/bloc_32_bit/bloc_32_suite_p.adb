with AUnit.Test_Caller;

with Des_P.Bloc_P.Bloc_32_P.Test_P;

package body Bloc_32_Suite_P is

   package Caller is new AUnit.Test_Caller
      (Des_P.Bloc_P.Bloc_32_P.Test_P.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Bloc_32_Suite return AUnit.Test_Suites.Access_Test_Suite is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String := "(Test bloc de 32 bits) ";
   begin

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Initialisation bloc vide",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_Initialisation'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 1er bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_1er_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 2e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_2eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 3e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_3eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 4e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_4eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 5e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_5eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 6e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_6eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 7e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_7eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 8e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_8eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 9e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_9eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 10e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_10eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 11e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_11eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 12e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_12eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 13e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_13eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 14e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_14eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 15e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_15eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 16e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_16eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 17e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_17eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 18e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_18eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 19e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_19eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 20e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_20eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 21e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_21eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 22e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_22eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 23e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_23eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 24e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_24eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 25e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_25eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 26e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_26eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 27e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_27eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 28e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_28eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 29e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_29eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 30e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_30eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 31e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_31eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 32e bit",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_32eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Bits change aleatoirement",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_Change_Bits_Aleatoirement'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Ou Exclusif",
            Des_P.Bloc_P.Bloc_32_P.Test_P.Test_Ou_Exclusif'Access
            )
         );

      return ptr_test_suite;

   end Fonc_Bloc_32_Suite;

end Bloc_32_Suite_P;
