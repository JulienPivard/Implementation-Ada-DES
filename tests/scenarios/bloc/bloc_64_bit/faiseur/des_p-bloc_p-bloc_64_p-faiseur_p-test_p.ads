with AUnit;
with AUnit.Test_Fixtures;

package Des_P.Bloc_P.Bloc_64_P.Faiseur_P.Test_P is

   type Bit_IO_T is range 0 .. 1;

   brut_attendu : constant Bloc_64_Brut_T :=
   2#11110000_11110000_11110000_11110000_11110000_11110000_11110000_11110000#;
   --  valeur du brut
   --  64     56       48       40       32       24       16       8
   resultat_attendu : array (Intervalle_T) of Bit_T :=
      (1 .. 4  | 9 .. 12  | 17 .. 20 | 25 .. 28 | 33 .. 36 |
      41 .. 44 | 49 .. 52 | 57 .. 60 => False, others => True);

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         constructeur : Faiseur_Bloc_T;
      end record;

   overriding
   procedure Set_Up (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down (T : in out Test_Fixt_T);

   procedure Test_Preparation (T : in out Test_Fixt_T);

   procedure Test_Construction (T : in out Test_Fixt_T);

   procedure Test_Recuperation (T : in out Test_Fixt_T);

   procedure Test_Transformation_Brut (T : in out Test_Fixt_T);

end Des_P.Bloc_P.Bloc_64_P.Faiseur_P.Test_P;
