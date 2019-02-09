with AUnit;
with AUnit.Test_Fixtures;

package Des_P.Filtre_P.Corps_P.Test_P is

   type Bit_IO_T is range 0 .. 1;

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         Bloc : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;
      end record;

   type Tableau_Bits_32_T is array
      (Des_P.Bloc_P.Bloc_32_P.Intervalle_T)
      of Des_P.Bloc_P.Bit_T;

   overriding
   procedure Set_Up (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down (T : in out Test_Fixt_T);

   procedure Test_Fonction_F
      (T : in out Test_Fixt_T);

end Des_P.Filtre_P.Corps_P.Test_P;
