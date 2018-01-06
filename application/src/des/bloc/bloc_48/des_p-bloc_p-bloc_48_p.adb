package body Des_P.Bloc_P.Bloc_48_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Initialize (B : in out Bloc_48_T) is
   begin
      B.Bits := (others => False);
   end Initialize;

   ---------------------------------------------------------------------------
   overriding
   procedure Finalize (B : in out Bloc_48_T) is
   begin
      null;
   end Finalize;

   ---------------------------------------------------------------------------
   overriding
   procedure Adjust (B : in out Bloc_48_T) is
   begin
      null;
   end Adjust;

   ---------------------------------------------------------------------------
   procedure Ecrire_Bit
      (
         B : in out Bloc_48_T;
         Position : Intervalle_Bloc_48_T;
         Bit : Bit_T
      )
   is
   begin
      B.Bits (Position) := Bit;
   end Ecrire_Bit;

   ---------------------------------------------------------------------------
   function Lire_Bit
      (
         B : Bloc_48_T;
         Position : Intervalle_Bloc_48_T
      )
      return Bit_T
   is
   begin
      return B.Bits (Position);
   end Lire_Bit;

end Des_P.Bloc_P.Bloc_48_P;
