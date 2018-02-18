package Des_P.Clef_P.Clef_48_Abs_P.Clef_48_Simple_P is

   pragma Pure;

   type Clef_48_Simplifie_T is new Clef_48_Abs_T with private;

   overriding
   function Lire_Bit
      (
         Clef : Clef_48_Simplifie_T;
         Position : Intervalle_Clef_48_T
      )
      return Bit_T;

   overriding
   procedure Initialize (Clef : in out Clef_48_Simplifie_T);

   overriding
   procedure Finalize (Clef : in out Clef_48_Simplifie_T);

   overriding
   procedure Adjust (Clef : in out Clef_48_Simplifie_T);

private

   type Clef_48_Simplifie_T is new Clef_48_Abs_T with null record;

end Des_P.Clef_P.Clef_48_Abs_P.Clef_48_Simple_P;
