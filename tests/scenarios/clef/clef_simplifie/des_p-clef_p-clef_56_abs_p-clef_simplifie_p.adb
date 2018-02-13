package body Des_P.Clef_P.Clef_56_Abs_P.Clef_Simplifie_P is

   ---------------------------------------------------------------------------
   procedure Init
      (
         Clef : out Clef_Simplifie_T;
         Champ : Champ_De_Bits_T;
         Constructeur : access Constructeur_Clef_48_Abs_T'Class
      )
   is
   begin
      Clef.Champ := Champ;
      Clef.Constructeur := Constructeur;
   end Init;

   ---------------------------------------------------------------------------
   overriding
   function Possede_Constructeur_48 (Clef : Clef_Simplifie_T)
      return Boolean
   is
      pragma Unreferenced (Clef);
   begin
      return True;
   end Possede_Constructeur_48;

   ---------------------------------------------------------------------------
   overriding
   procedure Decaler_Bits_A_Gauche
      (Clef : in out Clef_Simplifie_T; Nb_Decalage : Decalage_T := 1)
   is
      pragma Unreferenced (Clef);
      pragma Unreferenced (Nb_Decalage);
   begin
      null;
   end Decaler_Bits_A_Gauche;

   ---------------------------------------------------------------------------
   overriding
   function Lire_Bit
      (Clef : Clef_Simplifie_T; Position : Intervalle_Clef_56_T)
      return Bit_T
   is
   begin
      return Clef.Champ (Position);
   end Lire_Bit;

   ---------------------------------------------------------------------------
   overriding
   function Lire_Clef_48
      (Clef : Clef_Simplifie_T)
      return Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Clef_48_T
   is
   begin
      Clef.Constructeur.all.Preparer_Nouvelle_Clef_48;
      Clef.Constructeur.all.Construire_Clef_48 (Clef);
      return Clef.Constructeur.all.Recuperer_Clef_48;
   end Lire_Clef_48;

   ---------------------------------------------------------------------------
   overriding
   procedure Initialize (Clef : in out Clef_Simplifie_T) is
   begin
      Clef.Champ := (others => False);
      Clef.Constructeur := null;
   end Initialize;

   ---------------------------------------------------------------------------
   overriding
   procedure Finalize (Clef : in out Clef_Simplifie_T) is
   begin
      Clef.Champ := (others => False);
      Clef.Constructeur := null;
   end Finalize;

   ---------------------------------------------------------------------------
   overriding
   procedure Adjust (Clef : in out Clef_Simplifie_T) is
   begin
      null;
   end Adjust;

end Des_P.Clef_P.Clef_56_Abs_P.Clef_Simplifie_P;
