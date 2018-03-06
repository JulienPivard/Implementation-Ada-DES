with Des_P.Clef_P.Clef_48_I_P;

package Des_P.Clef_P.Clef_48_Simple_P is

   pragma Pure;

   type Clef_S_T is new Clef_Abstrait_T and
      Des_P.Clef_P.Clef_48_I_P.Clef_Interface_T with private;

   overriding
   function Lire_Bit
      (
         Clef : Clef_S_T;
         Position : Des_P.Clef_P.Clef_48_I_P.Intervalle_T
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
      Des_P.Clef_P.Clef_48_I_P.Clef_Interface_T with null record;

end Des_P.Clef_P.Clef_48_Simple_P;
