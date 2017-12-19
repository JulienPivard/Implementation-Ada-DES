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
      Bit : Bit_T;
      Masque : Bloc_32_Brut_T := 1;
   begin
      for I in reverse Intervalle_Bloc_32_T'Range loop
         if (Constructeur.Brut and Masque) > 0 then
            Bit := 1;
         else
            Bit := 0;
         end if;
         Constructeur.Bloc.Bits (I) := Bit;
         Masque := Masque * 2;
      end loop;
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
