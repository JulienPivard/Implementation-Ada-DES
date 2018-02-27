with Des_P.Bloc_P.Bloc_32_P.Constructeur_P;

package body Des_P.Bloc_P.Bloc_64_P.Constructeur_P is

   ---------------------------------------------------------------------------
   procedure Preparer_Nouveau_Bloc
      (Constructeur : in out Constructeur_Bloc_64_T)
   is
      B : Bloc_64_T;
   begin
      Constructeur.Bloc := B;
   end Preparer_Nouveau_Bloc;

   ---------------------------------------------------------------------------
   procedure Construire_Bloc
      (
         Constructeur : in out Constructeur_Bloc_64_T;
         Brut : Bloc_64_Brut_T
      )
   is
      package Faiseur_32 renames Des_P.Bloc_P.Bloc_32_P.Constructeur_P;
      type Bloc_Intermediaire is
         record
            Bloc_1 : Faiseur_32.Bloc_32_Brut_T;
            Bloc_2 : Faiseur_32.Bloc_32_Brut_T;
         end record
      with Size => 64;

      for Bloc_Intermediaire use
         record
            Bloc_1 at 0 range 0 .. 31;
            Bloc_2 at 4 range 0 .. 31;
         end record;

      Resultat : Bloc_Intermediaire with Address => Brut'Address;

      C_32 : Faiseur_32.Constructeur_Bloc_32_T;
   begin
      C_32.Preparer_Nouveau_Bloc;
      C_32.Construire_Bloc (Resultat.Bloc_1);
      Constructeur.Bloc.Blocs_32 (Gauche) := C_32.Recuperer_Bloc;

      C_32.Preparer_Nouveau_Bloc;
      C_32.Construire_Bloc (Resultat.Bloc_2);
      Constructeur.Bloc.Blocs_32 (Droite) := C_32.Recuperer_Bloc;
   end Construire_Bloc;

   ---------------------------------------------------------------------------
   function Recuperer_Bloc
      (Constructeur : Constructeur_Bloc_64_T)
      return Bloc_64_T
   is
   begin
      return Constructeur.Bloc;
   end Recuperer_Bloc;

   ---------------------------------------------------------------------------
   function Transformer_En_Brut
      (
         Constructeur : in out Constructeur_Bloc_64_T;
         Bloc : Bloc_64_T
      )
      return Bloc_64_Brut_T
   is
      pragma Unreferenced (Constructeur);
      package Faiseur_32 renames Des_P.Bloc_P.Bloc_32_P.Constructeur_P;
      type Bloc_Intermediaire is
         record
            Bloc_1 : Faiseur_32.Bloc_32_Brut_T;
            Bloc_2 : Faiseur_32.Bloc_32_Brut_T;
         end record
      with Size => 64;

      for Bloc_Intermediaire use
         record
            Bloc_1 at 0 range 0 .. 31;
            Bloc_2 at 4 range 0 .. 31;
         end record;

      C_32 : Faiseur_32.Constructeur_Bloc_32_T;
      Resultat : Bloc_Intermediaire :=
         (
            C_32.Transformer_En_Brut (Bloc.Lire_Bloc (Gauche)),
            C_32.Transformer_En_Brut (Bloc.Lire_Bloc (Droite))
         );
         Brut : Bloc_64_Brut_T with Address => Resultat'Address;
   begin
      return Brut;
   end Transformer_En_Brut;

end Des_P.Bloc_P.Bloc_64_P.Constructeur_P;
