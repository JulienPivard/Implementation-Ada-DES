package body Des_P.Bloc_P.Bloc_48_P.Constructeur_P is

   ---------------------------------------------------------------------------
   procedure Preparer_Nouveau_Bloc
      (Constructeur : in out Constructeur_Bloc_48_T)
   is
      B : Bloc_48_T;
   begin
      Constructeur.Bloc := B;
   end Preparer_Nouveau_Bloc;

   ---------------------------------------------------------------------------
   procedure Construire_Bloc
      (
         Constructeur : in out Constructeur_Bloc_48_T;
         Brut : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T
      )
   is
      type Table_Selection_E_T is array (Intervalle_T)
         of Des_P.Bloc_P.Bloc_32_P.Intervalle_T;
      Table_E : constant Table_Selection_E_T :=
         (
            32,  1,  2,  3,  4,  5,
             4,  5,  6,  7,  8,  9,
             8,  9, 10, 11, 12, 13,
            12, 13, 14, 15, 16, 17,
            16, 17, 18, 19, 20, 21,
            20, 21, 22, 23, 24, 25,
            24, 25, 26, 27, 28, 29,
            28, 29, 30, 31, 32,  1
         );
   begin
      for I in Intervalle_T loop
         Constructeur.Bloc.Bits (I) := Brut.Lire_Bit (Table_E (I));
      end loop;
   end Construire_Bloc;

   ---------------------------------------------------------------------------
   function Recuperer_Bloc
      (Constructeur : Constructeur_Bloc_48_T)
      return Bloc_48_T
   is
   begin
      return Constructeur.Bloc;
   end Recuperer_Bloc;

end Des_P.Bloc_P.Bloc_48_P.Constructeur_P;
