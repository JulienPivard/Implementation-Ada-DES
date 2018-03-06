package body Des_P.Clef_P.Clef_56_Simplifie_P is

   ---------------------------------------------------------------------------
   procedure Init
      (
         Clef : out Clef_S_T;
         Champ : Champ_De_Bits_T
      )
   is
   begin
      Clef.Champ := Champ;
   end Init;

   ---------------------------------------------------------------------------
   overriding
   procedure Decaler_Bits_A_Gauche
      (
         Clef : in out Clef_S_T;
         Nb_Decalage : Des_P.Clef_P.Clef_56_I_P.Decalage_T := 1
      )
   is
      pragma Unreferenced (Clef);
      pragma Unreferenced (Nb_Decalage);
   begin
      null;
   end Decaler_Bits_A_Gauche;

   ---------------------------------------------------------------------------
   overriding
   function Lire_Bit
      (
         Clef : Clef_S_T;
         Position : Des_P.Clef_P.Clef_56_I_P.Intervalle_T
      )
      return Bit_T
   is
   begin
      return Clef.Champ (Position);
   end Lire_Bit;

   ---------------------------------------------------------------------------
   overriding
   procedure Initialize (Clef : in out Clef_S_T) is
   begin
      Clef.Champ := (others => False);
   end Initialize;

   ---------------------------------------------------------------------------
   overriding
   procedure Finalize (Clef : in out Clef_S_T) is
   begin
      Clef.Champ := (others => False);
   end Finalize;

   ---------------------------------------------------------------------------
   overriding
   procedure Adjust (Clef : in out Clef_S_T) is
   begin
      null;
   end Adjust;

end Des_P.Clef_P.Clef_56_Simplifie_P;
