package body Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P is

   ---------------------------------------------------------------------------
   overriding
   function Lire_Bit
      (Clef : Clef_48_T; Position : Intervalle_Clef_48_T)
      return Bit_T
   is
   begin
      return Clef.Bits (Position);
   end Lire_Bit;

end Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P;
