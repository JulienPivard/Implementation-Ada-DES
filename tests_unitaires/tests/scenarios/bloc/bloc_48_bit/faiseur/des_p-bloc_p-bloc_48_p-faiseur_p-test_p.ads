with AUnit;
with AUnit.Test_Fixtures;

package Des_P.Bloc_P.Bloc_48_P.Faiseur_P.Test_P is

   package Bloc_I_R renames Des_P.Bloc_P.Bloc_48_I_P;

   type Bit_IO_T is range 0 .. 1;

   type Intervalle_1_T is range 1 .. 3;
   type Intervalle_2_T is range 1 .. 7;
   type Intervalle_3_T is range 1 .. 2;

   type Tableau_Bits_Resultat_T is array (Bloc_I_R.Intervalle_T) of Bit_T;

   --  Les valeurs attendues
   --  0 1110 0
   --  0 0111 1
   --  1 1111 0
   --  1 0110 1
   --
   --  0 1110 0
   --  0 0111 1
   --  1 1111 0
   --  1 0110 1
   Resultat_Attendu : constant Tableau_Bits_Resultat_T :=
      Tableau_Bits_Resultat_T'
      (
         False, True, True, True, False, False,
         False, False, True, True, True, True,
         True, True, True, True, True, False,
         True, False, True, True, False, True,
         False, True, True, True, False, False,
         False, False, True, True, True, True,
         True, True, True, True, True, False,
         True, False, True, True, False, True
      );

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         Constructeur : Faiseur_Bloc_T;
         Brut         : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;
      end record;

   overriding
   procedure Set_Up (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down (T : in out Test_Fixt_T);

   procedure Test_Preparation (T : in out Test_Fixt_T);

   procedure Test_Construction (T : in out Test_Fixt_T);

   procedure Test_Recuperation (T : in out Test_Fixt_T);

end Des_P.Bloc_P.Bloc_48_P.Faiseur_P.Test_P;
