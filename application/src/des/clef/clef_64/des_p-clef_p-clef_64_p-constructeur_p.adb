package body Des_P.Clef_P.Clef_64_P.Constructeur_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Preparer_Nouvelle_Clef
      (Constructeur : in out Constructeur_Clef_T)
   is
      C : Clef_T;
   begin
      Constructeur.Clef := C;
   end Preparer_Nouvelle_Clef;

   ---------------------------------------------------------------------------
   overriding
   procedure Construire_Clef
      (
         Constructeur : in out Constructeur_Clef_T;
         Brut : Interface_P.Clef_64_Brut_T
      )
   is
      Resultat : Tableau_Bits_T with Address => Brut'Address;
   begin
      Constructeur.Clef.Bits := Resultat;
   end Construire_Clef;

   ---------------------------------------------------------------------------
   overriding
   function Recuperer_Clef
      (Constructeur : Constructeur_Clef_T)
      return Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T'Class
   is
   begin
      return Constructeur.Clef;
   end Recuperer_Clef;

   ---------------------------------------------------------------------------
   function Recuperer_Clef
      (Constructeur : Constructeur_Clef_T)
      return Clef_T
   is
   begin
      return Constructeur.Clef;
   end Recuperer_Clef;

end Des_P.Clef_P.Clef_64_P.Constructeur_P;