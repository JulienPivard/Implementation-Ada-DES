with Des_P.Bloc_P.Bloc_32_P;

package body Des_P.Filtre_P.Corps_P.Corps_Decryptage_P is

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

end Des_P.Filtre_P.Corps_P.Corps_Decryptage_P;
