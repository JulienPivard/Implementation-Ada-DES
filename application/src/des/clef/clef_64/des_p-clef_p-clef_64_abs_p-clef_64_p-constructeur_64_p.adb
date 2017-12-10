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
      Bit : Bit_T;
      Masque : constant Clef_64_Brut_T := 1;

      subtype Puissance_T is Natural range 0 .. 64;
      Puissance : Puissance_T := Puissance_T'First;
   begin
      for I in reverse Intervalle_Clef_64_T'Range loop
         Bit := (if (Brut and Masque * (2**Puissance)) > 0 then 1 else 0);
         Constructeur.Clef_64.Bits (I) := Bit;
         Puissance := Puissance_T'Succ (Puissance);
      end loop;
   end Construire_Clef_64;

   ---------------------------------------------------------------------------
   overriding
   procedure Construire_Ajouter_Constructeur_56
      (
         Constructeur : in out Constructeur_Clef_64_T;
         Constructeur_56 : access Des_P.Clef_P.Constructeur_56_Abs_P.
            Constructeur_Clef_56_Abs_T'Class
      )
   is
   begin
      Constructeur.Clef_64.Constructeur_56 := Constructeur_56;
   end Construire_Ajouter_Constructeur_56;

   ---------------------------------------------------------------------------
   overriding
   procedure Construire_Ajouter_Constructeur_48
      (
         Constructeur : in out Constructeur_Clef_64_T;
         Constructeur_48 : access Des_P.Clef_P.Constructeur_48_Abs_P.
            Constructeur_Clef_48_Abs_T'Class
      )
   is
   begin
      Constructeur.Clef_64.Constructeur_48 := Constructeur_48;
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
