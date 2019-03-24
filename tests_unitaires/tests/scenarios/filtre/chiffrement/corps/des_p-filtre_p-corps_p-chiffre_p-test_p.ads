with AUnit;
with AUnit.Test_Fixtures;

with Des_P.Clef_P.Clef_64_Simplifie_P;

package Des_P.Filtre_P.Corps_P.Chiffre_P.Test_P is

   type Bit_IO_T is range 0 .. 1;

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         Filtre : Corps_T;
         Bloc : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
         Clef : Des_P.Clef_P.Clef_64_Simplifie_P.Clef_S_T;
      end record;

   type Tableau_Bits_64_T is array
      (Des_P.Bloc_P.Bloc_64_P.Intervalle_T)
      of Des_P.Bloc_P.Bit_T;

   overriding
   procedure Set_Up (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down (T : in out Test_Fixt_T);

   procedure Test_Chiffrement_Niveau_1
      (T : in out Test_Fixt_T);

   procedure Test_Modifier_Clef_48
      (T : in out Test_Fixt_T);

end Des_P.Filtre_P.Corps_P.Chiffre_P.Test_P;
