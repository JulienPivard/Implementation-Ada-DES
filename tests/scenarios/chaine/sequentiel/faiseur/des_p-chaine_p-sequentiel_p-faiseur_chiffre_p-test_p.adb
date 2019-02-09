with AUnit.Assertions;

with Des_P.Etage_P.Filtrage_P;
with Des_P.Filtre_P.Entree_P.Chiffre_P;
with Des_P.Filtre_P.Corps_P.Chiffre_P;
with Des_P.Filtre_P.Sortie_P.Chiffre_P;
with Des_P.Clef_P.Clef_56_P.Faiseur_P;
with Des_P.Clef_P.Clef_48_P.Faiseur_P;

with Des_P.Clef_P.Clef_64_Simplifie_P;

package body Des_P.Chaine_P.Sequentiel_P.Faiseur_Chiffre_P.Test_P is

   package Faiseur_56_P renames Des_P.Clef_P.Clef_56_P.Faiseur_P;
   package Faiseur_48_P renames Des_P.Clef_P.Clef_48_P.Faiseur_P;

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      C : Faiseur_Chiffrement_T;
      F_56 : Faiseur_56_P.Faiseur_Clef_T;
      F_48 : Faiseur_48_P.Faiseur_Clef_T;
   begin
      C.Initialiser (F_56, F_48);
      T.C := C;
   end Set_Up;

   ---------------------------------------------------------------------------
   overriding
   procedure Tear_Down (T : in out Test_Fixt_T) is
      pragma Unreferenced (T);
   begin
      null;
   end Tear_Down;

   ---------------------------------------------------------------------------
   --                              scénarios                                --
   ---------------------------------------------------------------------------
   ---------------------------------------------------------------------------
   procedure Test_Initialisation (T : in out Test_Fixt_T) is
      E : Des_P.Etage_P.Filtrage_P.Etage_T;
      use type Des_P.Etage_P.Filtrage_P.Etage_T;
   begin
      AUnit.Assertions.Assert
         (T.C.Chaine.Tete = E,
         "La tète devrait être un étage vide"
         );
      AUnit.Assertions.Assert
         (not T.C.Faiseur_56.Is_Empty,
         "Le constructeur de 56 est vide"
         );
      AUnit.Assertions.Assert
         (not T.C.Faiseur_48.Is_Empty,
         "Le constructeur de 48 est vide"
         );
   end Test_Initialisation;

   ---------------------------------------------------------------------------
   procedure Test_Construction (T : in out Test_Fixt_T) is
      package Clef_Simple_R renames Des_P.Clef_P.Clef_64_Simplifie_P;
      C_64 : Des_P.Clef_P.Clef_64_Simplifie_P.Clef_S_T;
   begin
      C_64.Init (Clef_Simple_R.Tableau_Bits_T'(others => False));
      T.C.Construire (C_64);
      Construction_Estages :
      declare
         Etage : Des_P.Etage_P.Filtrage_P.Etage_T :=
            Explorer_R.Lire_Etage_Suivant (T.C.Chaine.Tete);
         C : Integer := 1;
      begin
         AUnit.Assertions.Assert
            (
               T.C.Chaine.Tete.Possede_Filtre,
               "L'étage : " & C'Img & " ne possede pas de filtre"
            );
         AUnit.Assertions.Assert
            (
               Explorer_R.Lire_Filtre (T.C.Chaine.Tete) in
               Des_P.Filtre_P.Entree_P.Chiffre_P.Entree_T,
               "L'estage : " & C'Img & " n'est pas une entree"
            );
         Verif_Successeur :
         loop
            exit Verif_Successeur when not Etage.Possede_Successeur;
            AUnit.Assertions.Assert
               (Etage.Possede_Filtre,
               "L'étage : " & C'Img & " ne possede pas de filtre"
               );
            AUnit.Assertions.Assert
               (Explorer_R.Lire_Filtre (Etage) in
               Des_P.Filtre_P.Corps_P.Chiffre_P.Corps_T,
               "L'estage : " & C'Img & " n'est pas un corps"
               );
            C := C + 1;
            Etage := Explorer_R.Lire_Etage_Suivant (Etage);
         end loop Verif_Successeur;
         AUnit.Assertions.Assert
            (Etage.Possede_Filtre,
            "L'étage : " & C'Img & " ne possede pas de filtre"
            );
         AUnit.Assertions.Assert
            (Explorer_R.Lire_Filtre (Etage) in
            Des_P.Filtre_P.Sortie_P.Chiffre_P.Sortie_T,
            "L'estage : " & C'Img & " n'est pas une sortie"
            );
         AUnit.Assertions.Assert
            (C = 17,
            "Il y a : " & C'Img &
            " estages, au lieu de 17"
            );
      end Construction_Estages;
   end Test_Construction;

   ---------------------------------------------------------------------------
   procedure Test_Recuperation (T : in out Test_Fixt_T) is
      package Clef_Simple_R renames Des_P.Clef_P.Clef_64_Simplifie_P;
      C_64 : Des_P.Clef_P.Clef_64_Simplifie_P.Clef_S_T;
      Chaine : Chaine_T;
   begin
      C_64.Init (Clef_Simple_R.Tableau_Bits_T'(others => False));
      T.C.Construire (C_64);
      Chaine := Chaine_T (T.C.Recuperer_Chaine);
      Recuperation_Et_Verification_Estage :
      declare
         Etage : Des_P.Etage_P.Filtrage_P.Etage_T :=
            Explorer_R.Lire_Etage_Suivant (Chaine.Tete);
         C : Integer := 1;
      begin
         AUnit.Assertions.Assert
            (Chaine.Tete.Possede_Filtre,
            "L'étage : " & C'Img & " ne possede pas de filtre"
            );
         AUnit.Assertions.Assert
            (Explorer_R.Lire_Filtre (Chaine.Tete) in
            Des_P.Filtre_P.Entree_P.Chiffre_P.Entree_T,
            "L'estage : " & C'Img & " n'est pas une entree"
            );
         Verif_Successeur :
         loop
            exit Verif_Successeur when not Etage.Possede_Successeur;
            AUnit.Assertions.Assert
               (Etage.Possede_Filtre,
               "L'étage : " & C'Img & " ne possede pas de filtre"
               );
            AUnit.Assertions.Assert
               (Explorer_R.Lire_Filtre (Etage) in
               Des_P.Filtre_P.Corps_P.Chiffre_P.Corps_T,
               "L'estage : " & C'Img & " n'est pas un corps"
               );
            C := C + 1;
            Etage := Explorer_R.Lire_Etage_Suivant (Etage);
         end loop Verif_Successeur;
         AUnit.Assertions.Assert
            (Etage.Possede_Filtre,
            "L'étage : " & C'Img & " ne possede pas de filtre"
            );
         AUnit.Assertions.Assert
            (Explorer_R.Lire_Filtre (Etage) in
            Des_P.Filtre_P.Sortie_P.Chiffre_P.Sortie_T,
            "L'estage : " & C'Img & " n'est pas une sortie"
            );
         AUnit.Assertions.Assert
            (C = 17,
            "Il y a : " & C'Img &
            " estages, au lieu de 17"
            );
      end Recuperation_Et_Verification_Estage;
   end Test_Recuperation;

end Des_P.Chaine_P.Sequentiel_P.Faiseur_Chiffre_P.Test_P;
