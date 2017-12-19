with Des_P.Bloc_P.Bloc_32_P.Constructeur_P;

package body Des_P.Bloc_P.Bloc_64_P.Constructeur_P is

   ---------------------------------------------------------------------------
   procedure Preparer_Nouveau_Bloc_64
      (
         Constructeur : in out Constructeur_Bloc_64_T;
         Brut : Bloc_64_Brut_T
      )
   is
      B : Bloc_64_T;
   begin
      Constructeur.Brut := Brut;
      Constructeur.Bloc := B;
   end Preparer_Nouveau_Bloc_64;

   ---------------------------------------------------------------------------
   procedure Construire_Bloc
      (Constructeur : in out Constructeur_Bloc_64_T)
   is
      use Des_P.Bloc_P.Bloc_32_P.Constructeur_P;
      type Bloc_Intermediaire is
         record
            Bloc_1 : Bloc_32_Brut_T;
            Bloc_2 : Bloc_32_Brut_T;
         end record
      with Size => 64;

      for Bloc_Intermediaire use
         record
            Bloc_1 at 0 range 0 .. 31;
            Bloc_2 at 4 range 0 .. 31;
         end record;

      Resultat : Bloc_Intermediaire with Address => Constructeur.Brut'Address;

      C_32 : Constructeur_Bloc_32_T;
   begin
      C_32.Preparer_Nouveau_Bloc_32 (Resultat.Bloc_1);
      C_32.Construire_Bloc;
      Constructeur.Bloc.Blocs_32 (0) := C_32.Recuperer_Bloc_32;

      C_32.Preparer_Nouveau_Bloc_32 (Resultat.Bloc_2);
      C_32.Construire_Bloc;
      Constructeur.Bloc.Blocs_32 (1) := C_32.Recuperer_Bloc_32;
   end Construire_Bloc;

   ---------------------------------------------------------------------------
   function Recuperer_Bloc_64
      (Constructeur : Constructeur_Bloc_64_T)
      return Bloc_64_T
   is
   begin
      return Constructeur.Bloc;
   end Recuperer_Bloc_64;

end Des_P.Bloc_P.Bloc_64_P.Constructeur_P;
