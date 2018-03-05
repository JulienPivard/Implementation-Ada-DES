package body Des_P.Chaine_P.Taches_P.Constructeur_Decryptage_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Initialiser
      (
         Constructeur : in out Constructeur_Decryptage_T;
         Faiseur_56 : Faiseur_56_I_P.Constructeur_Interface_T'Class;
         Faiseur_48 : Faiseur_48_I_P.Constructeur_Interface_T'Class
      )
   is
      C : Chaine_T;
   begin
      Constructeur.Chaine := C;
      Constructeur.Faiseur_56 :=
         Faiseur_56_I_P.Holder_P.To_Holder (Faiseur_56);
      Constructeur.Faiseur_48 :=
         Faiseur_48_I_P.Holder_P.To_Holder (Faiseur_48);
   end Initialiser;

   ---------------------------------------------------------------------------
   overriding
   procedure Construire
      (
         Constructeur : in out Constructeur_Decryptage_T;
         Clef : Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T'Class
      )
   is
      pragma Unreferenced (Constructeur);
      pragma Unreferenced (Clef);
   begin
      null;
   end Construire;

   ---------------------------------------------------------------------------
   overriding
   function Recuperer_Chaine
      (Constructeur : Constructeur_Decryptage_T)
      return Chaine_Interface_T'Class
   is
   begin
      return Constructeur.Chaine;
   end Recuperer_Chaine;

end Des_P.Chaine_P.Taches_P.Constructeur_Decryptage_P;
