with AUnit;
with AUnit.Test_Fixtures;

package Des_P.Filtre_P.Fabrique_P.Fabrique_Cryptage_P.Test_P is

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         Fab : Fabrique_T;
      end record;

   overriding
   procedure Set_Up (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down (T : in out Test_Fixt_T);

   procedure Test_Fabrication_Entree
      (T : in out Test_Fixt_T);

   procedure Test_Fabrication_Corps
      (T : in out Test_Fixt_T);

   procedure Test_Fabrication_Sortie
      (T : in out Test_Fixt_T);

end Des_P.Filtre_P.Fabrique_P.Fabrique_Cryptage_P.Test_P;
