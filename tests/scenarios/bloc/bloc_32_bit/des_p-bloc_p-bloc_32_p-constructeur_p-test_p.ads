with AUnit;
with AUnit.Test_Fixtures;

package Des_P.Bloc_P.Bloc_32_P.Constructeur_P.Test_P is

   type Bit_IO_T is range 0 .. 1;

   --  valeur du brut
   brut_attendu : constant Bloc_32_Brut_T :=
      2#0000_1111_0000_1111_0000_1111_0000_1111#;
   --   32   28   24   20   16   12   8    4

   --  11110000_11110000_11110000_11110000
   resultat_attendu : constant array (Intervalle_Bloc_32_T) of Bit_T :=
      (1 .. 4 | 9 .. 12 | 17 .. 20 | 25 .. 28 => True, others => False);

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         constructeur : Constructeur_Bloc_32_T;
      end record;

   overriding
   procedure Set_Up (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down (T : in out Test_Fixt_T);

   procedure Test_Preparation
      (T : in out Test_Fixt_T);

   procedure Test_Construction_Avec_Brut
      (T : in out Test_Fixt_T);

   procedure Test_Construction_Avec_Bloc_32
      (T : in out Test_Fixt_T);

   procedure Test_Construction_Avec_Bloc_48
      (T : in out Test_Fixt_T);

   procedure Test_Recuperation
      (T : in out Test_Fixt_T);

   procedure Test_Transformation_Brut
      (T : in out Test_Fixt_T);

end Des_P.Bloc_P.Bloc_32_P.Constructeur_P.Test_P;
