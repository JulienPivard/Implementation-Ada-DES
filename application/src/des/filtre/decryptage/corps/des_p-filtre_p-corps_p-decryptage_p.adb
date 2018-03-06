with Des_P.Bloc_P.Bloc_32_P;

package body Des_P.Filtre_P.Corps_P.Decryptage_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Filtrer
      (
         Filtre : Corps_T;
         Bloc : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T
      )
   is
      Gauche : constant Des_P.Bloc_P.Bloc_32_P.Bloc_32_T := Bloc.Lire_Bloc
         (Des_P.Bloc_P.Bloc_64_P.Gauche);
      Droite : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T := Bloc.Lire_Bloc
         (Des_P.Bloc_P.Bloc_64_P.Droite);
      Resultat_F : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;
      use type Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;
   begin
      --  Passage du bloc de gauche dans la fonction f
      Resultat_F := Fonction_F (Gauche, Filtre.Clef.Element);

      Droite := Droite xor Resultat_F;

      --  On remet les blocs à leur place.
      Bloc.Ecrire_Bloc (Des_P.Bloc_P.Bloc_64_P.Droite, Droite);

      --  On échange les blocs gauche et droite.
      Bloc.Intervertir_Blocs;
   end Filtrer;

   ---------------------------------------------------------------------------
   overriding
   procedure Modifier_Clef
      (
         Filtre : in out Corps_T;
         Clef : Des_P.Clef_P.Clef_48_I_P.Clef_Interface_T'Class
      )
   is
   begin
      Filtre.Clef := Des_P.Clef_P.Clef_48_I_P.Holder_P.To_Holder (Clef);
   end Modifier_Clef;

end Des_P.Filtre_P.Corps_P.Decryptage_P;
