package body Des_P.Bloc_P.Bloc_32_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Initialize (B : in out Bloc_32_T) is
   begin
      B.Bits := (others => False);
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
      (
         B : in out Bloc_32_T;
         Position : Intervalle_Bloc_32_T;
         Bit : Bit_T
      )
   is
   begin
      B.Bits (Position) := Bit;
   end Ecrire_Bit;

   ---------------------------------------------------------------------------
   function Lire_Bit
      (
         B : Bloc_32_T;
         Position : Intervalle_Bloc_32_T
      )
      return Bit_T
   is
   begin
      return B.Bits (Position);
   end Lire_Bit;

   ---------------------------------------------------------------------------
   function "xor" (Bloc, Autre : Bloc_32_T) return Bloc_32_T is
      Resultat : Bloc_32_T;
   begin
      Resultat.Bits := Bloc.Bits xor Autre.Bits;
      return Resultat;
   end "xor";

end Des_P.Bloc_P.Bloc_32_P;
