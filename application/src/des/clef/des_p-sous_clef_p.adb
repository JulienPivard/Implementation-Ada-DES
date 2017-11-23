package body Des_P.Sous_Clef_P is

   ---------------------------------------------------------------------------
   function Lire_Bit (Clef : Sous_Clef_T; Position : Interval_Sous_Clef_T)
      return Bit_T
   is
   begin
      return Clef.Bits (Position);
   end Lire_Bit;

end Des_P.Sous_Clef_P;
