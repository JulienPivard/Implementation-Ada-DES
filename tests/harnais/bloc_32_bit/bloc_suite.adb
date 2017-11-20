with AUnit.Test_Caller;

with Des_P.Bloc_32_P.Test_P;

package body Bloc_Suite is

   package Caller is new AUnit.Test_Caller (Des_P.Bloc_32_P.Test_P.Test_Fix_T);

   ---------------------------------------------------------------------------
   function Fonc_Bloc_Suite return AUnit.Test_Suites.Access_Test_Suite is
      ptr_test_suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
      nom_test : constant String := "(Test bloc de 32 bits) ";
   begin

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Initialisation bloc vide",
            Des_P.Bloc_32_P.Test_P.Test_Initialisation'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification premier bit",
            Des_P.Bloc_32_P.Test_P.Test_1er_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification deuxieme bit",
            Des_P.Bloc_32_P.Test_P.Test_2eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification troisieme bit",
            Des_P.Bloc_32_P.Test_P.Test_3eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification quatrieme bit",
            Des_P.Bloc_32_P.Test_P.Test_4eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification cinquieme bit",
            Des_P.Bloc_32_P.Test_P.Test_5eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification sixieme bit",
            Des_P.Bloc_32_P.Test_P.Test_6eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification septieme bit",
            Des_P.Bloc_32_P.Test_P.Test_7eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification huitieme bit",
            Des_P.Bloc_32_P.Test_P.Test_8eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification neuvieme bit",
            Des_P.Bloc_32_P.Test_P.Test_9eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification dixieme bit",
            Des_P.Bloc_32_P.Test_P.Test_10eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification onzieme bit",
            Des_P.Bloc_32_P.Test_P.Test_11eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification douzieme bit",
            Des_P.Bloc_32_P.Test_P.Test_12eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification treizieme bit",
            Des_P.Bloc_32_P.Test_P.Test_13eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification quatorzieme bit",
            Des_P.Bloc_32_P.Test_P.Test_14eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification quinzieme bit",
            Des_P.Bloc_32_P.Test_P.Test_15eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification seizieme bit",
            Des_P.Bloc_32_P.Test_P.Test_16eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification dixseptieme bit",
            Des_P.Bloc_32_P.Test_P.Test_17eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification dixhuitieme bit",
            Des_P.Bloc_32_P.Test_P.Test_18eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification dixneuvieme bit",
            Des_P.Bloc_32_P.Test_P.Test_19eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification vingtieme bit",
            Des_P.Bloc_32_P.Test_P.Test_20eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification vingtetunieme bit",
            Des_P.Bloc_32_P.Test_P.Test_21eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification vingtdeuxieme bit",
            Des_P.Bloc_32_P.Test_P.Test_22eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification vingttroisieme bit",
            Des_P.Bloc_32_P.Test_P.Test_23eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification vingtquatrieme bit",
            Des_P.Bloc_32_P.Test_P.Test_24eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification vingtcinquieme bit",
            Des_P.Bloc_32_P.Test_P.Test_25eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification vingtsixieme bit",
            Des_P.Bloc_32_P.Test_P.Test_26eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification vingtseptieme bit",
            Des_P.Bloc_32_P.Test_P.Test_27eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification vingthuitieme bit",
            Des_P.Bloc_32_P.Test_P.Test_28eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification vingtneuvieme bit",
            Des_P.Bloc_32_P.Test_P.Test_29eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification trentieme bit",
            Des_P.Bloc_32_P.Test_P.Test_30eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification trentetunieme bit",
            Des_P.Bloc_32_P.Test_P.Test_31eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Modification trentdeuxieme bit",
            Des_P.Bloc_32_P.Test_P.Test_32eme_Bit'Access
            )
         );

      ptr_test_suite.all.Add_Test
         (Caller.Create
            (nom_test & "Bits change aleatoirement",
            Des_P.Bloc_32_P.Test_P.Test_Change_Bits_Aleatoirement'Access
            )
         );

      return ptr_test_suite;

   end Fonc_Bloc_Suite;

end Bloc_Suite;
