with Des_P.Clef_P.Clef_56_I_P;

package Des_P.Clef_P.Clef_56_Simple_P is

   type Clef_S_T is new Clef_Abstrait_T and
      Des_P.Clef_P.Clef_56_I_P.Clef_Interface_T with private;

   overriding
   procedure Decaler_Bits_A_Gauche
      (
         Clef : in out Clef_S_T;
         Nb_Decalage : Des_P.Clef_P.Clef_56_I_P.Decalage_T := 1
      );

   overriding
   function Lire_Bit
      (
         Clef : Clef_S_T;
         Position : Des_P.Clef_P.Clef_56_I_P.Intervalle_Clef_56_T
      )
      return Bit_T;

   overriding
   procedure Initialize (Clef : in out Clef_S_T);

   overriding
   procedure Finalize (Clef : in out Clef_S_T);

   overriding
   procedure Adjust (Clef : in out Clef_S_T);

private

   type Clef_S_T is new Clef_Abstrait_T and
      Des_P.Clef_P.Clef_56_I_P.Clef_Interface_T with null record;

end Des_P.Clef_P.Clef_56_Simple_P;
