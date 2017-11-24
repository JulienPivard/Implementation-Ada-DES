with AUnit;
with AUnit.Test_Fixtures;

package Des_P.Clef_P.Test_P is

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         clef : Clef_T;
      end record;

   overriding
   procedure Set_Up (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down (T : in out Test_Fixt_T);

   procedure Test_Decaler_0_Bit_A_Gauche (T : in out Test_Fixt_T);

   procedure Test_Decaler_1_Bit_A_Gauche (T : in out Test_Fixt_T);

   procedure Test_Decaler_2_Bit_A_Gauche (T : in out Test_Fixt_T);

   procedure Test_Decaler_3_Bit_A_Gauche (T : in out Test_Fixt_T);

   procedure Test_Lire_Bit_Sans_Decalage (T : in out Test_Fixt_T);

   procedure Test_Lire_Bit_1_Decalage (T : in out Test_Fixt_T);

   procedure Test_Lire_Bit_2_Decalage (T : in out Test_Fixt_T);

   procedure Test_Lire_Bit_3_Decalage (T : in out Test_Fixt_T);

end Des_P.Clef_P.Test_P;
