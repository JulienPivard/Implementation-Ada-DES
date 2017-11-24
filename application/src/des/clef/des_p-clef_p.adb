with Des_P.Sous_Clef_P.Constructeur_P;

package body Des_P.Clef_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Initialize (Clef : in out Clef_T) is
   begin
      Clef.Decalage := 0;
      Clef.C1 := (others => 0);
      Clef.C2 := (others => 0);
   end Initialize;

   ---------------------------------------------------------------------------
   overriding
   procedure Finalize (Clef : in out Clef_T) is
   begin
      Clef.C1 := (others => 0);
      Clef.C2 := (others => 0);
   end Finalize;

   ---------------------------------------------------------------------------
   overriding
   procedure Adjust (Clef : in out Clef_T) is
   begin
      null;
   end Adjust;

   ---------------------------------------------------------------------------
   procedure Decaler_Bits_A_Gauche
      (Clef : in out Clef_T; Nb_Decalage : Natural := 1)
   is
   begin
      Clef.Decalage := Clef.Decalage + Nb_Decalage;
   end Decaler_Bits_A_Gauche;

   ---------------------------------------------------------------------------
   function Lire_Bit (Clef : Clef_T; Position : Intervalle_Clef_T)
      return Bit_T
   is
      Pos : Intervalle_Demi_Clef_T;
      decal : constant Intervalle_Demi_Clef_T :=
         Intervalle_Demi_Clef_T (Clef.Decalage mod 28);
   begin
      if Position <= 28 then
         Pos := Intervalle_Demi_Clef_T (Position - 1);
         return Clef.C1 (Pos + decal);
      else
         --  Position 28 case en arrière -1 pour compenser l'intervalle
         Pos := Intervalle_Demi_Clef_T (Position - 29);
         return Clef.C2 (Pos + decal);
      end if;
   end Lire_Bit;

   ---------------------------------------------------------------------------
   function Lire_Clef (Clef : Clef_T) return Des_P.Sous_Clef_P.Sous_Clef_T is
      Construct : Des_P.Sous_Clef_P.Constructeur_P.Constructeur_Sous_Clef_T;
   begin
      Construct.Preparer_Nouvelle_Sous_Clef;
      Construct.Construire_Sous_Clef (Clef);
      return Construct.Recuperer_Sous_Clef;
   end Lire_Clef;

end Des_P.Clef_P;
