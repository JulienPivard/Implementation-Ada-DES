with AUnit;
with AUnit.Test_Fixtures;

package Des_P.Filtre_P.Cryptage_P.Op_P.Test_P is

   type Bit_IO_T is range 0 .. 1;

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         Filtre : Sortie_T;
      end record;

   overriding
   procedure Set_Up (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down (T : in out Test_Fixt_T);

   procedure Test_Permutation_Sortante
      (T : in out Test_Fixt_T);

end Des_P.Filtre_P.Cryptage_P.Op_P.Test_P;
