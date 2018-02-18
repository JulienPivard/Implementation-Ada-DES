with AUnit;
with AUnit.Test_Fixtures;

with Des_P.Clef_P.Clef_64_Abs_P.Clef_Simple_P;

package Des_P.Filtre_P.Corps_P.Corps_Cryptage_P.Test_P is

   type Bit_IO_T is range 0 .. 1;

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         Filtre : Corps_T;
         Bloc : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
         Clef : Des_P.Clef_P.Clef_64_Abs_P.Clef_Simple_P.Clef_Simple_T;
      end record;

   overriding
   procedure Set_Up (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down (T : in out Test_Fixt_T);

   procedure Test_Cryptage_Niveau_1
      (T : in out Test_Fixt_T);

end Des_P.Filtre_P.Corps_P.Corps_Cryptage_P.Test_P;
