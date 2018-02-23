package body Des_P.Clef_P.Clef_64_Abs_P.Clef_Simple_P is

   ---------------------------------------------------------------------------
   procedure Init
      (
         Clef : out Clef_Simple_T;
         Champ : Champ_De_Bits_T;
         Constructeur_56 : access Constructeur_Clef_56_Abs_T'Class;
         Constructeur_48 : access Const_Clef_48_Abs_T'Class
      )
   is
   begin
      Clef.Champ := Champ;
      Clef.Constructeur_56 := Constructeur_56;
      Clef.Constructeur_48 := Constructeur_48;
   end Init;

   ---------------------------------------------------------------------------
   overriding
   function Possede_Constructeur_56 (Clef : Clef_Simple_T) return Boolean is
      pragma Unreferenced (Clef);
   begin
      return True;
   end Possede_Constructeur_56;

   ---------------------------------------------------------------------------
   overriding
   function Possede_Constructeur_48 (Clef : Clef_Simple_T) return Boolean is
      pragma Unreferenced (Clef);
   begin
      return True;
   end Possede_Constructeur_48;

   ---------------------------------------------------------------------------
   overriding
   function Lire_Bit (Clef : Clef_Simple_T; Position : Intervalle_Clef_64_T)
      return Bit_T
   is
   begin
      return Clef.Champ (Position);
   end Lire_Bit;

   ---------------------------------------------------------------------------
   overriding
   function Lire_Clef_56 (Clef : Clef_Simple_T)
      return Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Clef_56_T
   is
   begin
      Clef.Constructeur_56.all.Preparer_Nouvelle_Clef_56;
      Clef.Constructeur_56.all.Construire_Clef_56 (Clef);
      Clef.Constructeur_56.all.Construire_Ajouter_Constructeur_48
         (Clef.Constructeur_48);
      return Clef.Constructeur_56.all.Recuperer_Clef_56;
   end Lire_Clef_56;

   ---------------------------------------------------------------------------
   overriding
   procedure Initialize (Clef : in out Clef_Simple_T) is
   begin
      Clef.Champ := (others => False);
      Clef.Constructeur_56 := null;
      Clef.Constructeur_48 := null;
   end Initialize;

   ---------------------------------------------------------------------------
   overriding
   procedure Finalize (Clef : in out Clef_Simple_T) is
   begin
      Clef.Champ := (others => False);
      Clef.Constructeur_56 := null;
      Clef.Constructeur_48 := null;
   end Finalize;

   ---------------------------------------------------------------------------
   overriding
   procedure Adjust (Clef : in out Clef_Simple_T) is
   begin
      null;
   end Adjust;

end Des_P.Clef_P.Clef_64_Abs_P.Clef_Simple_P;
