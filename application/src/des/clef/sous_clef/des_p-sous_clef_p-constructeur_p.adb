package body Des_P.Sous_Clef_P.Constructeur_P is

   ---------------------------------------------------------------------------
   procedure Preparer_Nouvelle_Sous_Clef
      (Constructeur : in out Constructeur_Sous_Clef_T)
   is
      Sous_Clef : Sous_Clef_T;
   begin
      Sous_Clef.Bits := (others => 0);
      Constructeur.Sous_Clef := Sous_Clef;
   end Preparer_Nouvelle_Sous_Clef;

   ---------------------------------------------------------------------------
   procedure Construire_Sous_Clef
      (
         Constructeur : in out Constructeur_Sous_Clef_T;
         Clef : Des_P.Clef_P.Clef_T
      )
   is
      --  Correspond au tableau de correspondance pour l'opération PC-2 de DES
      T : constant array
         (Interval_Sous_Clef_T range Interval_Sous_Clef_T'Range)
         of Des_P.Clef_P.Intervalle_Clef_T :=
            (
               14, 17, 11, 24,  1,  5,
               3, 28, 15,  6, 21, 10,
               23, 19, 12,  4, 26,  8,
               16,  7, 27, 20, 13, 12,
               41, 52, 31, 37, 47, 55,
               30, 40, 51, 45, 33, 48,
               44, 49, 39, 56, 34, 53,
               46, 42, 50, 36, 29, 32
            );
   begin
      for I in Interval_Sous_Clef_T'Range loop
         Constructeur.Sous_Clef.Bits (I) := Bit_T
            (Clef.Lire_Bit (T (I)));
      end loop;
   end Construire_Sous_Clef;

   ---------------------------------------------------------------------------
   function Recuperer_Sous_Clef
      (Constructeur : Constructeur_Sous_Clef_T)
      return Sous_Clef_T
   is
   begin
      return Constructeur.Sous_Clef;
   end Recuperer_Sous_Clef;

end Des_P.Sous_Clef_P.Constructeur_P;
