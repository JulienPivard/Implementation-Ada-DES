package body Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Constructeur_48_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Preparer_Nouvelle_Clef_48
      (Constructeur : in out Constructeur_Clef_48_T)
   is
      Clef_48 : Clef_48_T;
   begin
      Constructeur.Clef_48 := Clef_48;
   end Preparer_Nouvelle_Clef_48;

   ---------------------------------------------------------------------------
   overriding
   procedure Construire_Clef_48
      (
         Constructeur : in out Constructeur_Clef_48_T;
         Clef : Des_P.Clef_P.Clef_56_Abs_P.Clef_56_Abs_T'Class
      )
   is
      --  Correspond au tableau de correspondance pour l'opération PC-2 de DES
      T : constant array
         (Intervalle_Clef_48_T range Intervalle_Clef_48_T'Range)
         of Des_P.Clef_P.Clef_56_Abs_P.Intervalle_Clef_56_T :=
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
      for I in Intervalle_Clef_48_T'Range loop
         Constructeur.Clef_48.Bits (I) := Clef.Lire_Bit (T (I));
      end loop;
   end Construire_Clef_48;

   ---------------------------------------------------------------------------
   overriding
   function Recuperer_Clef_48
      (Constructeur : Constructeur_Clef_48_T)
      return Clef_48_T
   is
   begin
      return Constructeur.Clef_48;
   end Recuperer_Clef_48;

end Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Constructeur_48_P;
