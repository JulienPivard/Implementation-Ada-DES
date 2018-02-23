package body Des_P.Clef_P.Clef_64_Abs_P.Clef_Simplifie_P is

   ---------------------------------------------------------------------------
   procedure Init
      (
         Clef : out Clef_Simplifie_T;
         Champ : Tableau_Bits_T;
         Constructeur : Constructeur_Clef_56_Abs_T'Class
      )
   is
   begin
      Clef.Champ := Champ;
      Clef.Constructeur :=
         Des_P.Clef_P.Constructeur_56_Abs_P.Holder_P.To_Holder
            (Constructeur);
   end Init;

   ---------------------------------------------------------------------------
   overriding
   function Possede_Constructeur_56 (Clef : Clef_Simplifie_T)
      return Boolean
   is
      pragma Unreferenced (Clef);
   begin
      return True;
   end Possede_Constructeur_56;

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
      Const : Des_P.Clef_P.Constructeur_56_Abs_P.
         Constructeur_Clef_56_Abs_T'Class := Clef.Constructeur.Element;
   begin
      Const.Preparer_Nouvelle_Clef_56;
      Const.Construire_Clef_56 (Clef);
      return Const.Recuperer_Clef_56;
   end Lire_Clef_56;

   ---------------------------------------------------------------------------
   overriding
   procedure Initialize (Clef : in out Clef_Simplifie_T) is
   begin
      Clef.Champ := (others => False);
      Clef.Constructeur :=
         Des_P.Clef_P.Constructeur_56_Abs_P.Holder_P.Empty_Holder;
   end Initialize;

   ---------------------------------------------------------------------------
   overriding
   procedure Finalize (Clef : in out Clef_Simplifie_T) is
   begin
      Clef.Champ := (others => False);
      Clef.Constructeur :=
         Des_P.Clef_P.Constructeur_56_Abs_P.Holder_P.Empty_Holder;
   end Finalize;

   ---------------------------------------------------------------------------
   overriding
   procedure Adjust (Clef : in out Clef_Simplifie_T) is
   begin
      null;
   end Adjust;

end Des_P.Clef_P.Clef_64_Abs_P.Clef_Simplifie_P;
