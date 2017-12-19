package body Des_P.Bloc_P.Bloc_32_P.Constructeur_P is

   ---------------------------------------------------------------------------
   procedure Preparer_Nouveau_Bloc_32
      (
         Constructeur : in out Constructeur_Bloc_32_T;
         Brut : Bloc_32_Brut_T
      )
   is
      B : Bloc_32_T;
   begin
      Constructeur.Brut := Brut;
      Constructeur.Bloc := B;
   end Preparer_Nouveau_Bloc_32;

   ---------------------------------------------------------------------------
   procedure Construire_Bloc
      (Constructeur : in out Constructeur_Bloc_32_T)
   is
      Resultat : Tableau_Bits_T with Address => Constructeur.Brut'Address;
   begin
      Constructeur.Bloc.Bits := Resultat;
   end Construire_Bloc;

   ---------------------------------------------------------------------------
   function Recuperer_Bloc_32
      (Constructeur : Constructeur_Bloc_32_T)
      return Bloc_32_T
   is
   begin
      return Constructeur.Bloc;
   end Recuperer_Bloc_32;

end Des_P.Bloc_P.Bloc_32_P.Constructeur_P;
