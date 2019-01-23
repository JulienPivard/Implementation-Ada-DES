with AUnit;
with AUnit.Test_Fixtures;

package Des_P.Chaine_P.Sequentiel_P.Faiseur_Chiffre_P.Test_P is

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         C : Faiseur_Chiffrement_T;
      end record;

   overriding
   procedure Set_Up (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down (T : in out Test_Fixt_T);

   procedure Test_Initialisation
      (T : in out Test_Fixt_T);

   procedure Test_Construction
      (T : in out Test_Fixt_T);

   procedure Test_Recuperation
      (T : in out Test_Fixt_T);

end Des_P.Chaine_P.Sequentiel_P.Faiseur_Chiffre_P.Test_P;
