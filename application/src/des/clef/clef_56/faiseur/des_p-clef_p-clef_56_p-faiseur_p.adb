package body Des_P.Clef_P.Clef_56_P.Faiseur_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Preparer_Nouvelle_Clef
      (Constructeur : in out Faiseur_Clef_T)
   is
      C : Clef_T;
   begin
      Constructeur.Clef := C;
   end Preparer_Nouvelle_Clef;

   ---------------------------------------------------------------------------
   overriding
   procedure Construire_Clef
      (
         Constructeur   : in out Faiseur_Clef_T;
         Clef           : Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T'Class
      )
   is
      type Table_Pc_1_T is
         array (Intervalle_Demi_Clef_T)
         of Des_P.Clef_P.Clef_64_I_P.Intervalle_T;
      --  Tiré du tableau de correspondance PC-1 de DES.
      T1 : constant Table_Pc_1_T :=
         Table_Pc_1_T'
         (
            57, 49, 41, 33, 25, 17,  9,
             1, 58, 50, 42, 34, 26, 18,
            10,  2, 59, 51, 43, 35, 27,
            19, 11,  3, 60, 52, 44, 36
         );
      T2 : constant Table_Pc_1_T :=
         Table_Pc_1_T'
         (
            63, 55, 47, 39, 31, 23, 15,
             7, 62, 54, 46, 38, 30, 22,
            14,  6, 61, 53, 45, 37, 29,
            21, 13,  5, 28, 20, 12,  4
         );
   begin
      --  Rempli la clef de 56 à partir de la clef de 64 en
      --  suivant les tableaux de correspondance.
      for I in Intervalle_Demi_Clef_T loop
         Constructeur.Clef.C1 (I) := Clef.Lire_Bit (T1 (I));
         Constructeur.Clef.C2 (I) := Clef.Lire_Bit (T2 (I));
      end loop;
   end Construire_Clef;

   ---------------------------------------------------------------------------
   overriding
   function Recuperer_Clef
      (Constructeur : Faiseur_Clef_T)
      return Des_P.Clef_P.Clef_56_I_P.Clef_Interface_T'Class
   is
   begin
      return Constructeur.Clef;
   end Recuperer_Clef;

   ---------------------------------------------------------------------------
   function Recuperer_Clef
      (Constructeur : Faiseur_Clef_T)
      return Clef_T
   is
   begin
      return Constructeur.Clef;
   end Recuperer_Clef;

end Des_P.Clef_P.Clef_56_P.Faiseur_P;
