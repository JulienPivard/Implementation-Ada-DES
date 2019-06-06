with Des_P.Bloc_P.Bloc_32_P;

package body Des_P.Filtre_P.Corps_P.Chiffre_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Filtrer
      (
         Filtre   :        Corps_T;
         Bloc     : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T
      )
   is
      Gauche : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T          :=
         Bloc.Lire_Bloc (Bloc_G_Ou_D => Des_P.Bloc_P.Bloc_64_P.A_Gauche);
      Droite : constant Des_P.Bloc_P.Bloc_32_P.Bloc_32_T :=
         Bloc.Lire_Bloc (Bloc_G_Ou_D => Des_P.Bloc_P.Bloc_64_P.A_Droite);

      Resultat_F : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;

      use type Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;
   begin
      --  Passage du bloc de gauche dans la fonction f
      Resultat_F  := Fonction_F
         (
            Bloc => Droite,
            Clef => Filtre.Clef.Element
         );

      Gauche      := Gauche xor Resultat_F;

      --  On remet les blocs à leur place.
      Bloc.Ecrire_Bloc
         (
            Bloc_G_Ou_D => Des_P.Bloc_P.Bloc_64_P.A_Gauche,
            Bloc_32     => Gauche
         );

      --  On échange les blocs gauche et droite.
      Bloc.Intervertir_Blocs;
   end Filtrer;

   ---------------------------------------------------------------------------
   overriding
   procedure Modifier_Clef
      (
         Filtre   : in out Corps_T;
         Clef     :        Des_P.Clef_P.Clef_48_I_P.Clef_Interface_T'Class
      )
   is
   begin
      Filtre.Clef :=
         Des_P.Clef_P.Clef_48_I_P.Holder_P.To_Holder (New_Item => Clef);
   end Modifier_Clef;

end Des_P.Filtre_P.Corps_P.Chiffre_P;
