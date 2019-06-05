package body Des_P.Clef_P.Clef_56_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Decaler_Bits_A_Gauche
      (
         Clef        : in out Clef_T;
         Nb_Decalage :        Des_P.Clef_P.Clef_56_I_P.Decalage_T := 1
      )
   is
      use type Des_P.Clef_P.Clef_56_I_P.Decalage_T;
   begin
      --  Décale la clef de la valeur demandé.
      Clef.Decalage := Clef.Decalage + Nb_Decalage;
   end Decaler_Bits_A_Gauche;

   ---------------------------------------------------------------------------
   overriding
   procedure Decaler_Bits_A_Droite
      (
         Clef        : in out Clef_T;
         Nb_Decalage :        Des_P.Clef_P.Clef_56_I_P.Decalage_T := 1
      )
   is
      use type Des_P.Clef_P.Clef_56_I_P.Decalage_T;
   begin
      --  Décale la clef de la valeur demandé.
      Clef.Decalage := Clef.Decalage - Nb_Decalage;
   end Decaler_Bits_A_Droite;

   ---------------------------------------------------------------------------
   overriding
   function Lire_Bit
      (
         Clef     : Clef_T;
         Position : Des_P.Clef_P.Clef_56_I_P.Intervalle_T
      )
      return Bit_T
   is
      Pos : Intervalle_Demi_Clef_T;
      use type Des_P.Clef_P.Clef_56_I_P.Intervalle_T;
      use type Des_P.Clef_P.Clef_56_I_P.Decalage_T;
   begin
      return Bit : Bit_T do
         --  La clef de 56 est coupé en 2. La position va de 1 à 56.
         --  Les indices des tableaux vont de 0 à 28.
         if Position <= 28 then
            Pos := Intervalle_Demi_Clef_T (Position - 1);
            Bit := Clef.C1 (Pos + Clef.Decalage);
         else
            --  Position 28 case en arrière -1 pour compenser l'intervalle
            Pos := Intervalle_Demi_Clef_T (Position - 29);
            Bit := Clef.C2 (Pos + Clef.Decalage);
         end if;
      end return;
   end Lire_Bit;

   ---------------------------------------------------------------------------
   overriding
   procedure Initialize
      (Clef : in out Clef_T)
   is
   begin
      Clef.Decalage  := 0;
      Clef.C1        := Champ_De_Bits_T'(others => False);
      Clef.C2        := Champ_De_Bits_T'(others => False);
   end Initialize;

   ---------------------------------------------------------------------------
   overriding
   procedure Finalize
      (Clef : in out Clef_T)
   is
   begin
      Clef.C1 := Champ_De_Bits_T'(others => False);
      Clef.C2 := Champ_De_Bits_T'(others => False);
   end Finalize;

   ---------------------------------------------------------------------------
   overriding
   procedure Adjust
      (Clef : in out Clef_T)
   is
   begin
      null;
   end Adjust;

end Des_P.Clef_P.Clef_56_P;
