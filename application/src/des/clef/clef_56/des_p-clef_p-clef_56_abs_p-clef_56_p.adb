package body Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P is

   ---------------------------------------------------------------------------
   function Initialiser
      (Constructeur_Clef_48 : access Constructeur_Clef_48_Abs_T'Class)
      return Clef_56_T
   is
      Clef : Clef_56_T;
   begin
      Clef.Initialiser (Constructeur_Clef_48);
      return Clef;
   end Initialiser;

   ---------------------------------------------------------------------------
   procedure Initialiser
      (
         Clef : out Clef_56_T;
         Constructeur_Clef_48 : access Constructeur_Clef_48_Abs_T'Class
      )
   is
   begin
      Clef.Decalage := 0;
      Clef.C1 := (others => 0);
      Clef.C2 := (others => 0);
      Clef.Constructeur := Constructeur_Clef_48;
   end Initialiser;

   ---------------------------------------------------------------------------
   overriding
   procedure Decaler_Bits_A_Gauche
      (Clef : in out Clef_56_T; Nb_Decalage : Decalage_T := 1)
   is
   begin
      Clef.Decalage := Clef.Decalage + Nb_Decalage;
   end Decaler_Bits_A_Gauche;

   ---------------------------------------------------------------------------
   overriding
   function Lire_Bit (Clef : Clef_56_T; Position : Intervalle_Clef_56_T)
      return Bit_T
   is
      Pos : Intervalle_Demi_Clef_T;
   begin
      if Position <= 28 then
         Pos := Intervalle_Demi_Clef_T (Position - 1);
         return Clef.C1 (Pos + Clef.Decalage);
      else
         --  Position 28 case en arrière -1 pour compenser l'intervalle
         Pos := Intervalle_Demi_Clef_T (Position - 29);
         return Clef.C2 (Pos + Clef.Decalage);
      end if;
   end Lire_Bit;

   ---------------------------------------------------------------------------
   overriding
   function Lire_Clef_48 (Clef : Clef_56_T)
      return Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Clef_48_T
   is
   begin
      Clef.Constructeur.all.Preparer_Nouvelle_Clef_48;
      Clef.Constructeur.all.Construire_Clef_48 (Clef);
      return Clef.Constructeur.all.Recuperer_Clef_48;
   end Lire_Clef_48;

end Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P;