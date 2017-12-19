with AUnit;
with AUnit.Test_Fixtures;

package Des_P.Bloc_P.Bloc_32_P.Test_P is

   type Bit_IO_T is range 0 .. 1;

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         bloc : Bloc_32_T;
      end record;

   overriding
   procedure Set_Up (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down (T : in out Test_Fixt_T);

   procedure Test_Initialisation
      (T : in out Test_Fixt_T);

   procedure Test_1er_Bit
      (T : in out Test_Fixt_T);

   procedure Test_2eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_3eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_4eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_5eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_6eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_7eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_8eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_9eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_10eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_11eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_12eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_13eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_14eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_15eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_16eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_17eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_18eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_19eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_20eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_21eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_22eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_23eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_24eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_25eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_26eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_27eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_28eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_29eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_30eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_31eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_32eme_Bit
      (T : in out Test_Fixt_T);

   procedure Test_Change_Bits_Aleatoirement
      (T : in out Test_Fixt_T);

end Des_P.Bloc_P.Bloc_32_P.Test_P;
