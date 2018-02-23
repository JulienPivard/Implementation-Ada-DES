package body Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P.Constructeur_64_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Preparer_Nouvelle_Clef_64
      (Constructeur : in out Constructeur_Clef_64_T)
   is
      C : Clef_64_T;
   begin
      Constructeur.Clef_64 := C;
   end Preparer_Nouvelle_Clef_64;

   ---------------------------------------------------------------------------
   overriding
   procedure Construire_Clef_64
      (
         Constructeur : in out Constructeur_Clef_64_T;
         Brut : Clef_64_Brut_T
      )
   is
      Resultat : Tableau_Bits_T with Address => Brut'Address;
   begin
      Constructeur.Clef_64.Bits := Resultat;
   end Construire_Clef_64;

   ---------------------------------------------------------------------------
   overriding
   procedure Construire_Ajouter_Constructeur_56
      (
         Constructeur : in out Constructeur_Clef_64_T;
         Constructeur_56 : Des_P.Clef_P.Constructeur_56_Abs_P.
            Const_Clef_56_Abs_T'Class
      )
   is
   begin
      Constructeur.Clef_64.Constructeur_56 :=
         Des_P.Clef_P.Constructeur_56_Abs_P.Holder_P.To_Holder
            (Constructeur_56);
   end Construire_Ajouter_Constructeur_56;

   ---------------------------------------------------------------------------
   overriding
   procedure Construire_Ajouter_Constructeur_48
      (
         Constructeur : in out Constructeur_Clef_64_T;
         Constructeur_48 : Des_P.Clef_P.Constructeur_48_Abs_P.
            Const_Clef_48_Abs_T'Class
      )
   is
   begin
      Constructeur.Clef_64.Constructeur_48 :=
         Des_P.Clef_P.Constructeur_48_Abs_P.Holder_P.To_Holder
            (Constructeur_48);
   end Construire_Ajouter_Constructeur_48;

   ---------------------------------------------------------------------------
   overriding
   function Recuperer_Clef_64
      (Constructeur : in out Constructeur_Clef_64_T)
      return Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P.Clef_64_T
   is
   begin
      return Constructeur.Clef_64;
   end Recuperer_Clef_64;

end Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P.Constructeur_64_P;
