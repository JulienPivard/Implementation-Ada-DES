package body Des_P.Clef_P.Clef_64_Abs_P.Clef_Simplifie_P is

   ---------------------------------------------------------------------------
   procedure Init
      (
         Clef : out Clef_Simplifie_T;
         Champ : Champ_De_Bits_T;
         Constructeur : access Constructeur_Clef_56_Abs_T'Class
      )
   is
   begin
      Clef.Champ := Champ;
      Clef.Constructeur := Constructeur;
   end Init;

   ---------------------------------------------------------------------------
   overriding
   function Lire_Bit
      (Clef : Clef_Simplifie_T; Position : Intervalle_Clef_64_T)
      return Bit_T
   is
   begin
      return Clef.Champ (Position);
   end Lire_Bit;

   ---------------------------------------------------------------------------
   overriding
   function Lire_Clef_56
      (Clef : Clef_Simplifie_T)
      return Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Clef_56_T
   is
   begin
      Clef.Constructeur.all.Preparer_Nouvelle_Clef_56;
      Clef.Constructeur.all.Construire_Clef_56 (Clef);
      return Clef.Constructeur.all.Recuperer_Clef_56;
   end Lire_Clef_56;

   ---------------------------------------------------------------------------
   overriding
   procedure Initialize (Clef : in out Clef_Simplifie_T) is
   begin
      Clef.Champ := (others => 0);
      Clef.Constructeur := null;
   end Initialize;

   ---------------------------------------------------------------------------
   overriding
   procedure Finalize (Clef : in out Clef_Simplifie_T) is
   begin
      Clef.Champ := (others => 0);
      Clef.Constructeur := null;
   end Finalize;

   ---------------------------------------------------------------------------
   overriding
   procedure Adjust (Clef : in out Clef_Simplifie_T) is
   begin
      null;
   end Adjust;

end Des_P.Clef_P.Clef_64_Abs_P.Clef_Simplifie_P;
