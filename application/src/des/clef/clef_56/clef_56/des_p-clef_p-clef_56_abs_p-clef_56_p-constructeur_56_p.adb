package body Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Constructeur_56_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Preparer_Nouvelle_Clef_56
      (Constructeur : in out Constructeur_Clef_56_T)
   is
      C : Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Clef_56_T;
   begin
      Constructeur.Clef_56 := C;
   end Preparer_Nouvelle_Clef_56;

   ---------------------------------------------------------------------------
   overriding
   procedure Construire_Clef_56
      (
         Constructeur : in out Constructeur_Clef_56_T;
         Clef : Des_P.Clef_P.Clef_64_Abs_P.Clef_64_Abs_T'Class
      )
   is
      --  Tiré du tableau de correspondance PC-1 de DES.
      T1 : constant array
      (Intervalle_Demi_Clef_T range Intervalle_Demi_Clef_T'Range)
      of Des_P.Clef_P.Clef_64_Abs_P.Intervalle_Clef_64_T :=
         (
            57, 49, 41, 33, 25, 17,  9,
             1, 58, 50, 42, 34, 26, 18,
            10,  2, 59, 51, 43, 35, 27,
            19, 11,  3, 60, 52, 44, 36
         );
      T2 : constant array
      (Intervalle_Demi_Clef_T range Intervalle_Demi_Clef_T'Range)
      of Des_P.Clef_P.Clef_64_Abs_P.Intervalle_Clef_64_T :=
         (
            63, 55, 47, 39, 31, 23, 15,
             7, 62, 54, 46, 38, 30, 22,
            14,  6, 61, 53, 45, 37, 29,
            21, 13,  5, 28, 20, 12,  4
         );
   begin
      for I in Intervalle_Demi_Clef_T'Range loop
         Constructeur.Clef_56.C1 (I) := Clef.Lire_Bit (T1 (I));
         Constructeur.Clef_56.C2 (I) := Clef.Lire_Bit (T2 (I));
      end loop;
   end Construire_Clef_56;

   ---------------------------------------------------------------------------
   overriding
   procedure Construire_Ajouter_Constructeur_48
   (
      Constructeur : in out Constructeur_Clef_56_T;
      Constructeur_48 : access Constructeur_Clef_48_Abs_T'Class
   )
   is
   begin
      Constructeur.Clef_56.Constructeur := Constructeur_48;
   end Construire_Ajouter_Constructeur_48;

   ---------------------------------------------------------------------------
   overriding
   function Recuperer_Clef_56 (Constructeur : Constructeur_Clef_56_T)
      return Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Clef_56_T
   is
   begin
      return Constructeur.Clef_56;
   end Recuperer_Clef_56;

end Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Constructeur_56_P;
