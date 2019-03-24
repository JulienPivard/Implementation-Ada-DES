package body Des_P.Clef_P.Clef_64_P is

   ---------------------------------------------------------------------------
   overriding
   function Lire_Bit
      (
         Clef     : Clef_T;
         Position : Des_P.Clef_P.Clef_64_I_P.Intervalle_T
      )
      return Bit_T
   is
   begin
      return Clef.Bits (Position);
   end Lire_Bit;

   ---------------------------------------------------------------------------
   overriding
   procedure Initialize
      (Clef : in out Clef_T)
   is
   begin
      Clef.Bits := Tableau_Bits_T'(others => False);
   end Initialize;

   ---------------------------------------------------------------------------
   overriding
   procedure Finalize
      (Clef : in out Clef_T)
   is
   begin
      Clef.Bits := Tableau_Bits_T'(others => False);
   end Finalize;

   ---------------------------------------------------------------------------
   overriding
   procedure Adjust
      (Clef : in out Clef_T)
   is
   begin
      null;
   end Adjust;

end Des_P.Clef_P.Clef_64_P;
