package body Des_P.Clef_P.Clef_64_Abs_P.Clef_Simple_P is

   ---------------------------------------------------------------------------
   procedure Init
      (
         Clef : out Clef_Simple_T;
         Champ : Champ_De_Bits_T;
         Constructeur_56 : Constructeur_Clef_56_Abs_T'Class;
         Constructeur_48 : Const_Clef_48_Abs_T'Class
      )
   is
   begin
      Clef.Champ := Champ;
      Clef.Constructeur_56 :=
         Des_P.Clef_P.Constructeur_56_Abs_P.Holder_P.To_Holder
            (Constructeur_56);
      Clef.Constructeur_48 :=
         Des_P.Clef_P.Constructeur_48_Abs_P.Holder_P.To_Holder
            (Constructeur_48);
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
      Const : Des_P.Clef_P.Constructeur_56_Abs_P.
         Constructeur_Clef_56_Abs_T'Class := Clef.Constructeur_56.Element;
   begin
      Const.Preparer_Nouvelle_Clef_56;
      Const.Construire_Clef_56 (Clef);
      Const.Construire_Ajouter_Constructeur_48 (Clef.Constructeur_48.Element);
      return Const.Recuperer_Clef_56;
   end Lire_Clef_56;

   ---------------------------------------------------------------------------
   overriding
   procedure Initialize (Clef : in out Clef_Simple_T) is
   begin
      Clef.Champ := (others => False);
      Clef.Constructeur_56 :=
         Des_P.Clef_P.Constructeur_56_Abs_P.Holder_P.Empty_Holder;
      Clef.Constructeur_48 :=
         Des_P.Clef_P.Constructeur_48_Abs_P.Holder_P.Empty_Holder;
   end Initialize;

   ---------------------------------------------------------------------------
   overriding
   procedure Finalize (Clef : in out Clef_Simple_T) is
   begin
      Clef.Champ := (others => False);
      Clef.Constructeur_56 :=
         Des_P.Clef_P.Constructeur_56_Abs_P.Holder_P.Empty_Holder;
      Clef.Constructeur_48 :=
         Des_P.Clef_P.Constructeur_48_Abs_P.Holder_P.Empty_Holder;
   end Finalize;

   ---------------------------------------------------------------------------
   overriding
   procedure Adjust (Clef : in out Clef_Simple_T) is
   begin
      null;
   end Adjust;

end Des_P.Clef_P.Clef_64_Abs_P.Clef_Simple_P;
