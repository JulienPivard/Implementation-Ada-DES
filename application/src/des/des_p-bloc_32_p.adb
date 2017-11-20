package body Des_P.Bloc_32_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Initialize (B : in out Bloc_32_T) is
   begin
      B.Tableau_Bit := (others => 0);
   end Initialize;

   ---------------------------------------------------------------------------
   overriding
   procedure Finalize (B : in out Bloc_32_T) is
   begin
      null;
   end Finalize;

   ---------------------------------------------------------------------------
   overriding
   procedure Adjust (B : in out Bloc_32_T) is
   begin
      null;
   end Adjust;

   ---------------------------------------------------------------------------
   procedure Ecrire_Bit
      (B : in out Bloc_32_T; Position : Interval_Bloc_32_T; Bit : Bit_T)
   is
   begin
      B.Tableau_Bit (Position) := Bit;
   end Ecrire_Bit;

   ---------------------------------------------------------------------------
   function Lire_Bit
      (B : Bloc_32_T; Position : Interval_Bloc_32_T)
      return Bit_T
   is
   begin
      return B.Tableau_Bit (Position);
   end Lire_Bit;

end Des_P.Bloc_32_P;
