with System;

with Des_P.Bloc_P.Bloc_32_P.Faiseur_P;

package body Des_P.Bloc_P.Bloc_64_P.Faiseur_P is

   ---------------------------------------------------------------------------
   procedure Preparer_Nouveau_Bloc
      (Constructeur : in out Faiseur_Bloc_T)
   is
      B : Bloc_64_T;
   begin
      Constructeur.Bloc := B;
   end Preparer_Nouveau_Bloc;

   ---------------------------------------------------------------------------
   procedure Construire_Bloc
      (
         Constructeur : in out Faiseur_Bloc_T;
         Brut         : Bloc_64_Brut_T
      )
   is
      package Faiseur_32_R renames Des_P.Bloc_P.Bloc_32_P.Faiseur_P;

      --  Découpage du bloc de 64 en 2 blocs brut de 32 bits.
      type Bloc_Intermediaire_T is
         record
            Bloc_1 : Faiseur_32_R.Bloc_32_Brut_T;
            Bloc_2 : Faiseur_32_R.Bloc_32_Brut_T;
         end record
         with Size => 64;

      --  Délimite les deux blocs de 32 en définissant
      --  l'octet de départ et le nombre de bits.
      for Bloc_Intermediaire_T use
         record
            Bloc_1 at 0 range 0 .. 31;
            Bloc_2 at 4 range 0 .. 31;
         end record;

      for Bloc_Intermediaire_T'Bit_Order            use System.Low_Order_First;
      for Bloc_Intermediaire_T'Scalar_Storage_Order use System.Low_Order_First;

      --  Transformation du bloc de 64 bits.
      Resultat : Bloc_Intermediaire_T with Address => Brut'Address;

      C_32     : Faiseur_32_R.Faiseur_Bloc_T;
   begin
      --  Construction du premier bloc de 32
      C_32.Preparer_Nouveau_Bloc;
      C_32.Construire_Bloc (Resultat.Bloc_1);
      Constructeur.Bloc.Blocs_32 (Gauche) := C_32.Recuperer_Bloc;

      --  Construction du deuxième bloc de 32
      C_32.Preparer_Nouveau_Bloc;
      C_32.Construire_Bloc (Resultat.Bloc_2);
      Constructeur.Bloc.Blocs_32 (Droite) := C_32.Recuperer_Bloc;
   end Construire_Bloc;

   ---------------------------------------------------------------------------
   function Recuperer_Bloc
      (Constructeur : Faiseur_Bloc_T)
      return Bloc_64_T
   is
   begin
      return Constructeur.Bloc;
   end Recuperer_Bloc;

   ---------------------------------------------------------------------------
   function Transformer_En_Brut
      (
         Constructeur : Faiseur_Bloc_T;
         Bloc         : Bloc_64_T
      )
      return Bloc_64_Brut_T
   is
      pragma Unreferenced (Constructeur);
      package Faiseur_32_R renames Des_P.Bloc_P.Bloc_32_P.Faiseur_P;

      --  Rassemblement des deux blocs brut de 32 bits en un de 64.
      type Bloc_Intermediaire_T is
         record
            Bloc_1 : Faiseur_32_R.Bloc_32_Brut_T;
            Bloc_2 : Faiseur_32_R.Bloc_32_Brut_T;
         end record
         with Size => 64;

      --  Défini les placements des 32 bits de chaque bloc
      --  en donnant leur octet de départ.
      for Bloc_Intermediaire_T use
         record
            Bloc_1 at 0 range 0 .. 31;
            Bloc_2 at 4 range 0 .. 31;
         end record;

      for Bloc_Intermediaire_T'Bit_Order            use System.Low_Order_First;
      for Bloc_Intermediaire_T'Scalar_Storage_Order use System.Low_Order_First;

      C_32 : Faiseur_32_R.Faiseur_Bloc_T;
      --  Rassemblement des deux blocs de 32 bits brut.
      Resultat : Bloc_Intermediaire_T :=
         Bloc_Intermediaire_T'
         (
            Bloc_1 => C_32.Transformer_En_Brut (Bloc.Lire_Bloc (Gauche)),
            Bloc_2 => C_32.Transformer_En_Brut (Bloc.Lire_Bloc (Droite))
         );
      --  Transformation du bloc de deux fois 32 en un seul de 64.
      Brut : Bloc_64_Brut_T with Address => Resultat'Address;
   begin
      return Brut;
   end Transformer_En_Brut;

end Des_P.Bloc_P.Bloc_64_P.Faiseur_P;
