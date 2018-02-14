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
      Gauche : constant Des_P.Bloc_P.Bloc_32_P.Bloc_32_T := Bloc.Lire_Bloc
         (Des_P.Bloc_P.Bloc_64_P.Gauche);
      Droite : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T := Bloc.Lire_Bloc
         (Des_P.Bloc_P.Bloc_64_P.Droite);
      Resultat_F : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;
      use type Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;
      use type Des_P.Clef_P.Clef_56_Abs_P.Decalage_T;
   begin
      --  Passage du bloc de gauche dans la fonction f
      Resultat_F := Fonction_F (Gauche, Clef.Lire_Clef_48);
      --  Décalage à gauche de la clef.
      Clef.Decaler_Bits_A_Gauche (-1 * Table_Decalage (Filtre.Numero));

      Droite := Droite xor Resultat_F;

      --  On remet les blocs à leur place.
      Bloc.Ecrire_Bloc (Des_P.Bloc_P.Bloc_64_P.Droite, Droite);

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
