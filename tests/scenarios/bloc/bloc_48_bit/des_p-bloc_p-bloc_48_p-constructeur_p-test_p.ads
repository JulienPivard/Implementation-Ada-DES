with AUnit;
with AUnit.Test_Fixtures;

package Des_P.Bloc_P.Bloc_48_P.Constructeur_P.Test_P is

   type Bit_IO_T is range 0 .. 1;

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
   resultat_attendu : constant array
      (Intervalle_T) of Bit_T :=
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
         constructeur : Constructeur_Bloc_48_T;
         brut : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;
      end record;

   overriding
   procedure Set_Up (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down (T : in out Test_Fixt_T);

   procedure Test_Preparation (T : in out Test_Fixt_T);

   procedure Test_Construction (T : in out Test_Fixt_T);

   procedure Test_Recuperation (T : in out Test_Fixt_T);

end Des_P.Bloc_P.Bloc_48_P.Constructeur_P.Test_P;
