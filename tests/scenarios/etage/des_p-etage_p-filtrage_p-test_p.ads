with AUnit;
with AUnit.Test_Fixtures;

package Des_P.Etage_P.Filtrage_P.Test_P is

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         Etage : Etage_T;
      end record;

   overriding
   procedure Set_Up (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down (T : in out Test_Fixt_T);

   ---------------------------------------------------------------------------

   procedure Test_Initialisation_Avec_Successeur
      (T : in out Test_Fixt_T);

   procedure Test_Initialisation_Sans_Successeur
      (T : in out Test_Fixt_T);

   procedure Test_Ajout_Filtre_Sans_Successeur
      (T : in out Test_Fixt_T);

   procedure Test_Ajout_Filtre_Avec_Successeur
      (T : in out Test_Fixt_T);

   procedure Test_Filtrer_Sans_Successeur
      (T : in out Test_Fixt_T);

   procedure Test_Filtrer_Avec_Successeur
      (T : in out Test_Fixt_T);

   procedure Test_Iterer_Sans_Successeur
      (T : in out Test_Fixt_T);

   procedure Test_Iterer_Avec_Successeur
      (T : in out Test_Fixt_T);

   procedure Test_Ajouter_1_Successeur
      (T : in out Test_Fixt_T);

   procedure Test_Ajouter_2_Successeur
      (T : in out Test_Fixt_T);

end Des_P.Etage_P.Filtrage_P.Test_P;
