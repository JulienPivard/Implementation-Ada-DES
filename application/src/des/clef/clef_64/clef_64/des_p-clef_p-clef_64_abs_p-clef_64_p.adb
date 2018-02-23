package body Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P is

   ---------------------------------------------------------------------------
   overriding
   function Possede_Constructeur_56 (Clef : Clef_64_T) return Boolean is
   begin
      return not Clef.Constructeur_56.Is_Empty;
   end Possede_Constructeur_56;

   ---------------------------------------------------------------------------
   overriding
   function Possede_Constructeur_48 (Clef : Clef_64_T) return Boolean is
   begin
      return not Clef.Constructeur_48.Is_Empty;
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
      if Clef.Constructeur_56.Is_Empty then
         raise Erreur_Constructeur_56_Absent with
         "La clef de 64 n'a pas de constructeur de clef 56";
      end if;
      declare
         Const : Des_P.Clef_P.Constructeur_56_Abs_P.
            Constructeur_Clef_56_Abs_T'Class := Clef.Constructeur_56.Element;
      begin
         Const.Preparer_Nouvelle_Clef_56;
         Const.Construire_Clef_56 (Clef);
         if Clef.Possede_Constructeur_48 then
            Const.Construire_Ajouter_Constructeur_48
               (Clef.Constructeur_48.Element);
         end if;
         return Const.Recuperer_Clef_56;
      end;
   end Lire_Clef_56;

   ---------------------------------------------------------------------------
   overriding
   procedure Initialize (Clef : in out Clef_64_T) is
   begin
      Clef.Bits := (others => False);
      Clef.Constructeur_56 :=
         Des_P.Clef_P.Constructeur_56_Abs_P.Holder_P.Empty_Holder;
      Clef.Constructeur_48 :=
         Des_P.Clef_P.Constructeur_48_Abs_P.Holder_P.Empty_Holder;
   end Initialize;

   ---------------------------------------------------------------------------
   overriding
   procedure Finalize (Clef : in out Clef_64_T) is
   begin
      Clef.Bits := (others => False);
      Clef.Constructeur_56 :=
         Des_P.Clef_P.Constructeur_56_Abs_P.Holder_P.Empty_Holder;
      Clef.Constructeur_48 :=
         Des_P.Clef_P.Constructeur_48_Abs_P.Holder_P.Empty_Holder;
   end Finalize;

   ---------------------------------------------------------------------------
   overriding
   procedure Adjust (Clef : in out Clef_64_T) is
   begin
      null;
   end Adjust;

end Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P;
