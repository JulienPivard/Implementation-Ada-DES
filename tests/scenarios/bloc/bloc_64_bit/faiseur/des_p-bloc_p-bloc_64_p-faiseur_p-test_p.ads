with AUnit;
with AUnit.Test_Fixtures;

package Des_P.Bloc_P.Bloc_64_P.Faiseur_P.Test_P is

   type Bit_IO_T is range 0 .. 1;

   brut_attendu : constant Bloc_64_Brut_T :=
   2#11110000_11110000_11110000_11110000_11110000_11110000_11110000_11110000#;

   subtype Intervalle_1_T is Intervalle_T range 1 .. 4;
   subtype Intervalle_2_T is Intervalle_T range 9 .. 12;
   subtype Intervalle_3_T is Intervalle_T range 17 .. 20;
   subtype Intervalle_4_T is Intervalle_T range 25 .. 28;
   subtype Intervalle_5_T is Intervalle_T range 33 .. 36;
   subtype Intervalle_6_T is Intervalle_T range 41 .. 44;
   subtype Intervalle_7_T is Intervalle_T range 49 .. 52;
   subtype Intervalle_8_T is Intervalle_T range 57 .. 60;

   --  valeur du brut
   --  64     56       48       40       32       24       16       8
   resultat_attendu : array (Intervalle_T) of Bit_T :=
      (
         Intervalle_1_T | Intervalle_2_T | Intervalle_3_T |
         Intervalle_4_T | Intervalle_5_T | Intervalle_6_T |
         Intervalle_7_T | Intervalle_8_T => False,
         others => True
      );

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
