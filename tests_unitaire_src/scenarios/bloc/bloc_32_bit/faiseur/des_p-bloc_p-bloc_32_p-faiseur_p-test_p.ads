with AUnit;
with AUnit.Test_Fixtures;

package Des_P.Bloc_P.Bloc_32_P.Faiseur_P.Test_P is

   type Bit_IO_T is range 0 .. 1;

   --  valeur du brut
   Brut_Attendu : constant Bloc_32_Brut_T :=
      2#0000_1111_0000_1111_0000_1111_0000_1111#;
   --   32   28   24   20   16   12   8    4

   subtype Intervalle_1_T is Intervalle_T range 1 .. 4;
   subtype Intervalle_2_T is Intervalle_T range 9 .. 12;
   subtype Intervalle_3_T is Intervalle_T range 17 .. 20;
   subtype Intervalle_4_T is Intervalle_T range 25 .. 28;

   type Tableau_Bits_Resultat_T is array (Intervalle_T) of Bit_T;

   --  11110000_11110000_11110000_11110000
   Resultat_Attendu : constant Tableau_Bits_Resultat_T :=
      Tableau_Bits_Resultat_T'
      (
         Intervalle_1_T | Intervalle_2_T |
         Intervalle_3_T | Intervalle_4_T => True,
         others => False
      );

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         Constructeur : Faiseur_Bloc_T;
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

end Des_P.Bloc_P.Bloc_32_P.Faiseur_P.Test_P;
