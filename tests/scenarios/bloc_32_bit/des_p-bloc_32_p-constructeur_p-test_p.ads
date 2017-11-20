with AUnit;
with AUnit.Test_Fixtures;

package Des_P.Bloc_32_P.Constructeur_P.Test_P is

   brut_attendu : constant Bloc_32_Brut_T :=
      2#1111_0000_1111_0000_1111_0000_1111_0000#;
   --   32   28   24   20   16   12   8    4
   resultat_attendu : array (Interval_Bloc_32_T range Interval_Bloc_32_T'Range)
   of Bit_T := (1 .. 4 | 9 .. 12 | 17 .. 20 | 25 .. 28 => 0, others => 1);

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         constructeur : Constructeur_Bloc_32_T;
      end record;

   overriding
   procedure Set_Up (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down (T : in out Test_Fixt_T);

   procedure Test_Preparation (T : in out Test_Fixt_T);

   procedure Test_Construction (T : in out Test_Fixt_T);

   procedure Test_Recuperation (T : in out Test_Fixt_T);

end Des_P.Bloc_32_P.Constructeur_P.Test_P;
