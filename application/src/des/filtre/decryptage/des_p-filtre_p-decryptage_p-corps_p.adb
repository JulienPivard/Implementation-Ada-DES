with Des_P.Bloc_Xor_Clef_P;
with Des_P.Bloc_P.Bloc_32_P;
with Des_P.Bloc_P.Bloc_48_P;
with Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P;
with Des_P.Bloc_P.Bloc_48_P.Constructeur_P;
with Des_P.Bloc_P.Bloc_32_P.Constructeur_P;

package body Des_P.Filtre_P.Decryptage_P.Corps_P is

   function Fonction_F
      (
         Bloc : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;
         Clef : Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Clef_48_T'Class
      )
      return Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;

   ---------------------------------------------------------------------------
   function Fonction_F
      (
         Bloc : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;
         Clef : Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Clef_48_T'Class
      )
      return Des_P.Bloc_P.Bloc_32_P.Bloc_32_T
   is
      B : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;
      B_48 : Des_P.Bloc_P.Bloc_48_P.Bloc_48_T;
      C_48 : Des_P.Bloc_P.Bloc_48_P.Constructeur_P.Constructeur_Bloc_48_T;
      C_32 : Des_P.Bloc_P.Bloc_32_P.Constructeur_P.Constructeur_Bloc_32_T;
      use Des_P.Bloc_Xor_Clef_P;
   begin
      --  Extension du bloc de 32 en bloc de 48.
      C_48.Preparer_Nouveau_Bloc;
      C_48.Construire_Bloc (Bloc);
      B_48 := C_48.Recuperer_Bloc;

      --  Bloc de 48 xor Clef de 48.
      B_48 := B_48 xor Clef;

      --  Réduction de clef de 48 à clef de 32.
      C_32.Preparer_Nouveau_Bloc;
      C_32.Construire_Bloc (B_48);
      B := C_32.Recuperer_Bloc;

      --  Permutation du bloc de 32 par la table P.
      C_32.Preparer_Nouveau_Bloc;
      C_32.Construire_Bloc (B);
      B := C_32.Recuperer_Bloc;

      return B;
   end Fonction_F;

   ---------------------------------------------------------------------------
   overriding
   procedure Filtrer
      (
         Filtre : Corps_T;
         Bloc : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
         Clef : in out Des_P.Clef_P.Clef_56_Abs_P.Clef_56_Abs_T'Class
      )
   is
      Gauche : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T := Bloc.Lire_Bloc
         (Des_P.Bloc_P.Bloc_64_P.Gauche);
      Droite : constant Des_P.Bloc_P.Bloc_32_P.Bloc_32_T := Bloc.Lire_Bloc
         (Des_P.Bloc_P.Bloc_64_P.Droite);
      Resultat_F : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;
      use type Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;
   begin
      --  Décalage à gauche de la clef.
      Clef.Decaler_Bits_A_Gauche (Table_Decalage (Filtre.Numero));
      --  Passage du bloc de gauche dans la fonction f
      Resultat_F := Fonction_F (Droite, Clef.Lire_Clef_48);

      Gauche := Gauche xor Resultat_F;

      --  On remet les blocs à leur place.
      Bloc.Ecrire_Bloc (Des_P.Bloc_P.Bloc_64_P.Gauche, Gauche);

      --  On échange les blocs gauche et droite.
      Bloc.Intervertir_Blocs;
   end Filtrer;

   ---------------------------------------------------------------------------
   overriding
   procedure Modifier_Numero
      (
         Filtre : in out Corps_T;
         Numero : Numero_Filtre_T
      )
   is
   begin
      Filtre.Numero := Numero;
   end Modifier_Numero;

end Des_P.Filtre_P.Decryptage_P.Corps_P;
