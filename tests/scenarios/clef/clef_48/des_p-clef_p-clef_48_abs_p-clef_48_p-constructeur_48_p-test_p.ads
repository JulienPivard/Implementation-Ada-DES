with AUnit;
with AUnit.Test_Fixtures;

with Des_P.Clef_P.Clef_56_Abs_P.Clef_Simplifie_P;

package Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Constructeur_48_P.Test_P is

   use Des_P.Clef_P.Clef_56_Abs_P.Clef_Simplifie_P;

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         constructeur : access Constructeur_Clef_48_T;
         clef_56 : Clef_Simplifie_T;
      end record;

   overriding
   procedure Set_Up (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down (T : in out Test_Fixt_T);

   procedure Test_Preparation (T : in out Test_Fixt_T);

   procedure Test_Construire (T : in out Test_Fixt_T);

   procedure Test_Recuperation (T : in out Test_Fixt_T);

end Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Constructeur_48_P.Test_P;
