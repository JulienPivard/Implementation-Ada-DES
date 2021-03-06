with Ada.Unchecked_Conversion;

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
         Brut         :        Bloc_64_Brut_T
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

      function Bloc_Brut_Vers_Bloc_Intermed is new Ada.Unchecked_Conversion
         (
            Source => Bloc_64_Brut_T,
            Target => Bloc_Intermediaire_T
         );

      --  Transformation du bloc de 64 bits.
      Resultat : constant Bloc_Intermediaire_T :=
         Bloc_Brut_Vers_Bloc_Intermed (S => Brut);

      C_32     : Faiseur_32_R.Faiseur_Bloc_T;
   begin
      --  Construction du premier bloc de 32
      C_32.Preparer_Nouveau_Bloc;
      C_32.Construire_Bloc (Brut => Resultat.Bloc_1);
      Constructeur.Bloc.Blocs_32 (A_Gauche) := C_32.Recuperer_Bloc;

      --  Construction du deuxième bloc de 32
      C_32.Preparer_Nouveau_Bloc;
      C_32.Construire_Bloc (Brut => Resultat.Bloc_2);
      Constructeur.Bloc.Blocs_32 (A_Droite) := C_32.Recuperer_Bloc;
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

      function Bloc_Intermed_Vers_Bloc_Brut is new Ada.Unchecked_Conversion
         (
            Source => Bloc_Intermediaire_T,
            Target => Bloc_64_Brut_T
         );

      C_32 : Faiseur_32_R.Faiseur_Bloc_T;
      --  Rassemblement des deux blocs de 32 bits brut.
      Bloc_Intermediaire : constant Bloc_Intermediaire_T :=
         Bloc_Intermediaire_T'
         (
            Bloc_1 => C_32.Transformer_En_Brut
               (Bloc => Bloc.Lire_Bloc (Bloc_G_Ou_D => A_Gauche)),
            Bloc_2 => C_32.Transformer_En_Brut
               (Bloc => Bloc.Lire_Bloc (Bloc_G_Ou_D => A_Droite))
         );
      --  Transformation du bloc de deux fois 32 en un seul de 64.
      Brut : constant Bloc_64_Brut_T :=
         Bloc_Intermed_Vers_Bloc_Brut (S => Bloc_Intermediaire);
   begin
      return Brut;
   end Transformer_En_Brut;

end Des_P.Bloc_P.Bloc_64_P.Faiseur_P;
