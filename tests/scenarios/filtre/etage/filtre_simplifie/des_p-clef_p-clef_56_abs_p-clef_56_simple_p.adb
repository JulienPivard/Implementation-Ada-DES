package body Des_P.Clef_P.Clef_56_Abs_P.Clef_56_Simple_P is

   ---------------------------------------------------------------------------
   overriding
   function Possede_Constructeur_48 (Clef : Clef_56_T) return Boolean is
      pragma Unreferenced (Clef);
   begin
      return False;
   end Possede_Constructeur_48;

   ---------------------------------------------------------------------------
   overriding
   procedure Decaler_Bits_A_Gauche
      (
         Clef : in out Clef_56_T;
         Nb_Decalage : Decalage_T := 1
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
      (Clef : Clef_56_T; Position : Intervalle_Clef_56_T)
      return Bit_T
   is
      pragma Unreferenced (Clef);
      pragma Unreferenced (Position);
   begin
      return True;
   end Lire_Bit;

   ---------------------------------------------------------------------------
   overriding
   function Lire_Clef_48
      (Clef : Clef_56_T)
      return Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Clef_48_T
   is
      pragma Unreferenced (Clef);
      C : Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Clef_48_T;
   begin
      return C;
   end Lire_Clef_48;

   ---------------------------------------------------------------------------
   overriding
   procedure Initialize (Clef : in out Clef_56_T) is
      pragma Unreferenced (Clef);
   begin
      null;
   end Initialize;

   ---------------------------------------------------------------------------
   overriding
   procedure Finalize (Clef : in out Clef_56_T) is
      pragma Unreferenced (Clef);
   begin
      null;
   end Finalize;

   ---------------------------------------------------------------------------
   overriding
   procedure Adjust (Clef : in out Clef_56_T) is
      pragma Unreferenced (Clef);
   begin
      null;
   end Adjust;

end Des_P.Clef_P.Clef_56_Abs_P.Clef_56_Simple_P;
