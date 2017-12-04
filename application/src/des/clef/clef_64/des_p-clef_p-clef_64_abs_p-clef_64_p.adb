package body Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P is

   ---------------------------------------------------------------------------
   procedure Ecrire_Constructeur
      (
         Clef : out Clef_64_T;
         Constructeur_Clef_56 : access Constructeur_Clef_56_Abs_T'Class;
         Constructeur_Clef_48 : access Constructeur_Clef_48_Abs_T'Class := null
      )
   is
   begin
      Clef.Constructeur_56 := Constructeur_Clef_56;
      Clef.Constructeur_48 := Constructeur_Clef_48;
   end Ecrire_Constructeur;

   ---------------------------------------------------------------------------
   overriding
   function Possede_Constructeur_56 (Clef : Clef_64_T) return Boolean is
   begin
      return Clef.Constructeur_56 /= null;
   end Possede_Constructeur_56;

   ---------------------------------------------------------------------------
   overriding
   function Possede_Constructeur_48 (Clef : Clef_64_T) return Boolean is
   begin
      return Clef.Constructeur_48 /= null;
   end Possede_Constructeur_48;

   ---------------------------------------------------------------------------
   overriding
   function Lire_Bit (Clef : Clef_64_T; Position : Intervalle_Clef_64_T)
      return Bit_T
   is
   begin
      return Clef.Bits (Position);
   end Lire_Bit;

   ---------------------------------------------------------------------------
   overriding
   function Lire_Clef_56 (Clef : Clef_64_T)
      return Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Clef_56_T
   is
   begin
      if Clef.Constructeur_56 = null then
         raise Constructeur_56_Absent_E;
      end if;
      Clef.Constructeur_56.all.Preparer_Nouvelle_Clef_56;
      Clef.Constructeur_56.all.Construire_Clef_56 (Clef);
      if Clef.Constructeur_48 /= null then
         Clef.Constructeur_56.all.Construire_Ajouter_Constructeur_48
            (Clef.Constructeur_48);
      end if;
      return Clef.Constructeur_56.all.Recuperer_Clef_56;
   end Lire_Clef_56;

   ---------------------------------------------------------------------------
   overriding
   procedure Initialize (Clef : in out Clef_64_T) is
   begin
      Clef.Bits := (others => 0);
      Clef.Constructeur_56 := null;
      Clef.Constructeur_48 := null;
   end Initialize;

   ---------------------------------------------------------------------------
   overriding
   procedure Finalize (Clef : in out Clef_64_T) is
   begin
      Clef.Bits := (others => 0);
      Clef.Constructeur_56 := null;
      Clef.Constructeur_48 := null;
   end Finalize;

   ---------------------------------------------------------------------------
   overriding
   procedure Adjust (Clef : in out Clef_64_T) is
   begin
      null;
   end Adjust;

end Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P;
