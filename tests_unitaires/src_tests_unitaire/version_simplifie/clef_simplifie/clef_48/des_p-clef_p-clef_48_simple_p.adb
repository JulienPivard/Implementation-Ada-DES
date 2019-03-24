package body Des_P.Clef_P.Clef_48_Simple_P is

   ---------------------------------------------------------------------------
   overriding
   function Lire_Bit
      (
         Clef : Clef_S_T;
         Position : Des_P.Clef_P.Clef_48_I_P.Intervalle_T
      )
      return Bit_T
   is
      pragma Unreferenced (Clef);
      pragma Unreferenced (Position);
   begin
      return True;
   end Lire_Bit;

   ---------------------------------------------------------------------------
   overriding
   procedure Initialize (Clef : in out Clef_S_T) is
   begin
      null;
   end Initialize;

   ---------------------------------------------------------------------------
   overriding
   procedure Finalize (Clef : in out Clef_S_T) is
   begin
      null;
   end Finalize;

   ---------------------------------------------------------------------------
   overriding
   procedure Adjust (Clef : in out Clef_S_T) is
   begin
      null;
   end Adjust;

end Des_P.Clef_P.Clef_48_Simple_P;
