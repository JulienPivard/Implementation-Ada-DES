with AUnit.Test_Caller;

with Des_P.Bloc_P.Bloc_48_P.Test_P;

package body Bloc_48_Suite_P is

   package Caller is new AUnit.Test_Caller
      (Des_P.Bloc_P.Bloc_48_P.Test_P.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Bloc_48_Suite return AUnit.Test_Suites.Access_Test_Suite is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String := "(Test bloc de 48 bits) ";
   begin

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Initialisation bloc vide",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_Initialisation'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 1ier bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_1er_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 2ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_2eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 3ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_3eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 4ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_4eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 5ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_5eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 6ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_6eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 7ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_7eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 8ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_8eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 9ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_9eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 10ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_10eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 11ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_11eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 12ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_12eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 13ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_13eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 14ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_14eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 15ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_15eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 16ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_16eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 17ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_17eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 18ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_18eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 19ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_19eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 20ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_20eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 21ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_21eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 22ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_22eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 23ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_23eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 24ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_24eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 25ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_25eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 26ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_26eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 27ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_27eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 28ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_28eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 29ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_29eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 30ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_30eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 31ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_31eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 32ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_32eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 33ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_33eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 34ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_34eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 35ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_35eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 36ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_36eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 37ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_37eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 38ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_38eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 39ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_39eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 40ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_40eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 41ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_41eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 42ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_42eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 43ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_43eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 44ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_44eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 45ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_45eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 46ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_46eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 47ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_47eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification 48ieme bit",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_48eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Bits change aleatoirement",
            Des_P.Bloc_P.Bloc_48_P.Test_P.Test_Change_Bits_Aleatoirement'Access
            )
         );

      return ptr_test_suite;

   end Fonc_Bloc_48_Suite;

end Bloc_48_Suite_P;
