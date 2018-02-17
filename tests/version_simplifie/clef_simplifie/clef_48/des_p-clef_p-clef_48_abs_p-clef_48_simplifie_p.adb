package body Des_P.Clef_P.Clef_48_Abs_P.Clef_48_Simplifie_P is

   ---------------------------------------------------------------------------
   procedure Init
      (
         Clef : out Clef_48_Simplifie_T;
         Champ : Champ_De_Bits_T
      )
   is
   begin
      Clef.Bits := Champ;
   end Init;

   ---------------------------------------------------------------------------
   overriding
   function Lire_Bit
      (
         Clef : Clef_48_Simplifie_T;
         Position : Intervalle_Clef_48_T
      )
      return Bit_T
   is
   begin
      return Clef.Bits (Position);
   end Lire_Bit;

   ---------------------------------------------------------------------------
   overriding
   procedure Initialize (Clef : in out Clef_48_Simplifie_T) is
   begin
      null;
   end Initialize;

   ---------------------------------------------------------------------------
   overriding
   procedure Finalize (Clef : in out Clef_48_Simplifie_T) is
   begin
      null;
   end Finalize;

   ---------------------------------------------------------------------------
   overriding
   procedure Adjust (Clef : in out Clef_48_Simplifie_T) is
   begin
      null;
   end Adjust;

end Des_P.Clef_P.Clef_48_Abs_P.Clef_48_Simplifie_P;
