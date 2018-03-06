with AUnit;
with AUnit.Test_Fixtures;

with Des_P.Clef_P.Clef_56_Simplifie_P;

package Des_P.Clef_P.Clef_48_P.Constructeur_P.Test_P is

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         constructeur : Constructeur_Clef_T;
         clef_56 : Des_P.Clef_P.Clef_56_Simplifie_P.Clef_S_T;
      end record;

   overriding
   procedure Set_Up (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down (T : in out Test_Fixt_T);

   procedure Test_Preparation (T : in out Test_Fixt_T);

   procedure Test_Construire (T : in out Test_Fixt_T);

   procedure Test_Recuperation (T : in out Test_Fixt_T);

end Des_P.Clef_P.Clef_48_P.Constructeur_P.Test_P;
