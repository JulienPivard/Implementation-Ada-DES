package body Des_P.Faiseur_P is

   ---------------------------------------------------------------------------
   function Faire_Clef
      (
         Faiseur : in out Faiseur_64_I_P.Constructeur_Interface_T'Class;
         Clef : Faiseur_64_I_P.Clef_64_Brut_T
      )
      return Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T'Class
   is
   begin
      Faiseur.Preparer_Nouvelle_Clef;
      Faiseur.Construire_Clef (Clef);
      return Faiseur.Recuperer_Clef;
   end Faire_Clef;

   ---------------------------------------------------------------------------
   function Faire_Clef
      (
         Faiseur : in out Faiseur_56_I_P.Constructeur_Interface_T'Class;
         Clef : Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T'Class
      )
      return Des_P.Clef_P.Clef_56_I_P.Clef_Interface_T'Class
   is
   begin
      Faiseur.Preparer_Nouvelle_Clef;
      Faiseur.Construire_Clef (Clef);
      return Faiseur.Recuperer_Clef;
   end Faire_Clef;

   ---------------------------------------------------------------------------
   function Faire_Clef
      (
         Faiseur : in out Faiseur_48_I_P.Constructeur_Interface_T'Class;
         Clef : Des_P.Clef_P.Clef_56_I_P.Clef_Interface_T'Class
      )
      return Des_P.Clef_P.Clef_48_I_P.Clef_Interface_T'Class
   is
   begin
      Faiseur.Preparer_Nouvelle_Clef;
      Faiseur.Construire_Clef (Clef);
      return Faiseur.Recuperer_Clef;
   end Faire_Clef;

end Des_P.Faiseur_P;
