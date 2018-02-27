package body Des_P.Clef_P.Clef_48_P.Constructeur_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Preparer_Nouvelle_Clef
      (Constructeur : in out Constructeur_Clef_T)
   is
      Clef : Clef_T;
   begin
      Constructeur.Clef := Clef;
   end Preparer_Nouvelle_Clef;

   ---------------------------------------------------------------------------
   overriding
   procedure Construire_Clef
      (
         Constructeur : in out Constructeur_Clef_T;
         Clef : Des_P.Clef_P.Clef_56_I_P.Clef_Interface_T'Class
      )
   is
      --  Tiré au tableau de correspondance PC-2 de DES.
      T : constant array (Des_P.Clef_P.Clef_48_I_P.Intervalle_T)
         of Des_P.Clef_P.Clef_56_I_P.Intervalle_T :=
            (
               14, 17, 11, 24,  1,  5,
               3,  28, 15,  6, 21, 10,
               23, 19, 12,  4, 26,  8,
               16,  7, 27, 20, 13, 12,
               41, 52, 31, 37, 47, 55,
               30, 40, 51, 45, 33, 48,
               44, 49, 39, 56, 34, 53,
               46, 42, 50, 36, 29, 32
            );
   begin
      for I in Des_P.Clef_P.Clef_48_I_P.Intervalle_T'Range loop
         Constructeur.Clef.Bits (I) := Clef.Lire_Bit (T (I));
      end loop;
   end Construire_Clef;

   ---------------------------------------------------------------------------
   overriding
   function Recuperer_Clef
      (Constructeur : Constructeur_Clef_T)
      return Des_P.Clef_P.Clef_48_I_P.Clef_Interface_T'Class
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

end Des_P.Clef_P.Clef_48_P.Constructeur_P;