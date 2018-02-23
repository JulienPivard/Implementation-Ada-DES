package body Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P is

   ---------------------------------------------------------------------------
   procedure Ecrire_Constructeur
      (
         Clef : out Clef_56_T;
         Constructeur_Clef_48 : Const_Clef_48_Abs_T'Class
      )
   is
   begin
      Clef.Constructeur :=
         Des_P.Clef_P.Constructeur_48_Abs_P.Holder_P.To_Holder
            (Constructeur_Clef_48);
   end Ecrire_Constructeur;

   ---------------------------------------------------------------------------
   overriding
   function Possede_Constructeur_48 (Clef : Clef_56_T) return Boolean is
   begin
      return not Clef.Constructeur.Is_Empty;
   end Possede_Constructeur_48;

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
      if Clef.Constructeur.Is_Empty then
         raise Erreur_Constructeur_48_Absent with
         "La clef de 56 n'a pas de constructeur de clef de 48";
      end if;
      declare
         Const : Des_P.Clef_P.Constructeur_48_Abs_P.Const_Clef_48_Abs_T'Class
         := Clef.Constructeur.Element;
      begin
         Const.Preparer_Nouvelle_Clef_48;
         Const.Construire_Clef_48 (Clef);
         return Const.Recuperer_Clef_48;
      end;
   end Lire_Clef_48;

   ---------------------------------------------------------------------------
   overriding
   procedure Initialize (Clef : in out Clef_56_T) is
   begin
      Clef.Decalage := 0;
      Clef.C1 := (others => False);
      Clef.C2 := (others => False);
      Clef.Constructeur :=
         Des_P.Clef_P.Constructeur_48_Abs_P.Holder_P.Empty_Holder;
   end Initialize;

   ---------------------------------------------------------------------------
   overriding
   procedure Finalize (Clef : in out Clef_56_T) is
   begin
      Clef.C1 := (others => False);
      Clef.C2 := (others => False);
      Clef.Constructeur :=
         Des_P.Clef_P.Constructeur_48_Abs_P.Holder_P.Empty_Holder;
   end Finalize;

   ---------------------------------------------------------------------------
   overriding
   procedure Adjust (Clef : in out Clef_56_T) is
   begin
      null;
   end Adjust;

end Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P;
