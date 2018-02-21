with AUnit.Assertions;

with Des_P.Etage_P.Filtrage_P;
with Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Constructeur_56_P;
with Des_P.Clef_P.Clef_64_Abs_P.Clef_Simplifie_P;
with Des_P.Etage_P.Filtrage_P.Explorer_P;
with Des_P.Filtre_P.Entree_P.Entree_Decryptage_P;
with Des_P.Filtre_P.Corps_P.Corps_Decryptage_P;
with Des_P.Filtre_P.Sortie_P.Sortie_Decryptage_P;
with Des_P.Filtre_P.Corps_P.Corps_Decryptage_P.Lecteur_P;

package body Des_P.Chaine_P.Sequentiel_P.Constructeur_Decryptage_P.Test_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      C : Constructeur_Decryptage_T;
   begin
      C.Initialiser;
      T.C := C;
   end Set_Up;

   ---------------------------------------------------------------------------
   overriding
   procedure Tear_Down (T : in out Test_Fixt_T) is
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
         (T.C.Chaine.Clef.Is_Empty,
         "La clef devrait être vide."
         );
      AUnit.Assertions.Assert
         (T.C.Chaine.Tete = E,
         "La tète devrait être un étage vide"
         );
   end Test_Initialisation;

   ---------------------------------------------------------------------------
   procedure Test_Construction (T : in out Test_Fixt_T) is
      use Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Constructeur_56_P;
      C_64 : Des_P.Clef_P.Clef_64_Abs_P.Clef_Simplifie_P.Clef_Simplifie_T;
      Const : constant access Constructeur_Clef_56_T :=
         new Constructeur_Clef_56_T;
   begin
      C_64.Init ((others => False), Const);
      T.C.Construire (C_64);
      declare
         use Des_P.Filtre_P.Corps_P.Corps_Decryptage_P.Lecteur_P;
         use Des_P.Filtre_P.Corps_P.Corps_Decryptage_P;
         use Des_P.Filtre_P.Corps_P;
         use Des_P.Etage_P.Filtrage_P.Explorer_P;
         Etage : Des_P.Etage_P.Filtrage_P.Etage_T :=
            Lire_Etage_Suivant (T.C.Chaine.Tete);
         C : Integer := 1;
         Num_Lu : Numero_Filtre_T;
      begin
         AUnit.Assertions.Assert
            (T.C.Chaine.Tete.Possede_Filtre,
            "L'étage : " & C'Img & " ne possede pas de filtre"
            );
         AUnit.Assertions.Assert
            (Lire_Filtre (T.C.Chaine.Tete) in
            Des_P.Filtre_P.Entree_P.Entree_Decryptage_P.Entree_T,
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
               (Lire_Filtre (Etage) in
               Des_P.Filtre_P.Corps_P.Corps_Decryptage_P.Corps_T,
               "L'estage : " & C'Img & " n'est pas un corps"
               );
            Num_Lu := Lire_Numero_Filtre (Corps_T (Lire_Filtre (Etage)));
            AUnit.Assertions.Assert
               (Num_Lu = Numero_Filtre_T (C),
               "L'estage : " & C'Img & " a le numero : " &
               Num_Lu'Img & " au lieu de " & C'Img
               );
            C := C + 1;
            Etage := Lire_Etage_Suivant (Etage);
         end loop Verif_Successeur;
         AUnit.Assertions.Assert
            (Etage.Possede_Filtre,
            "L'étage : " & C'Img & " ne possede pas de filtre"
            );
         AUnit.Assertions.Assert
            (Lire_Filtre (Etage) in
            Des_P.Filtre_P.Sortie_P.Sortie_Decryptage_P.Sortie_T,
            "L'estage : " & C'Img & " n'est pas une sortie"
            );
         AUnit.Assertions.Assert
            (C = 17,
            "Il y a : " & C'Img &
            " estages, au lieu de 17"
            );
      end;
   end Test_Construction;

   ---------------------------------------------------------------------------
   procedure Test_Recuperation (T : in out Test_Fixt_T) is
      use Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Constructeur_56_P;
      C_64 : Des_P.Clef_P.Clef_64_Abs_P.Clef_Simplifie_P.Clef_Simplifie_T;
      Const : constant access Constructeur_Clef_56_T :=
         new Constructeur_Clef_56_T;
      Chaine : Chaine_T;
   begin
      C_64.Init ((others => False), Const);
      T.C.Construire (C_64);
      Chaine := T.C.Recuperer_Chaine;
      declare
         use Des_P.Filtre_P.Corps_P.Corps_Decryptage_P.Lecteur_P;
         use Des_P.Filtre_P.Corps_P.Corps_Decryptage_P;
         use Des_P.Filtre_P.Corps_P;
         use Des_P.Etage_P.Filtrage_P.Explorer_P;
         Etage : Des_P.Etage_P.Filtrage_P.Etage_T :=
            Lire_Etage_Suivant (Chaine.Tete);
         C : Integer := 1;
         Num_Lu : Numero_Filtre_T;
      begin
         AUnit.Assertions.Assert
            (Chaine.Tete.Possede_Filtre,
            "L'étage : " & C'Img & " ne possede pas de filtre"
            );
         AUnit.Assertions.Assert
            (Lire_Filtre (Chaine.Tete) in
            Des_P.Filtre_P.Entree_P.Entree_Decryptage_P.Entree_T,
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
               (Lire_Filtre (Etage) in
               Des_P.Filtre_P.Corps_P.Corps_Decryptage_P.Corps_T,
               "L'estage : " & C'Img & " n'est pas un corps"
               );
            Num_Lu := Lire_Numero_Filtre (Corps_T (Lire_Filtre (Etage)));
            AUnit.Assertions.Assert
               (Num_Lu = Numero_Filtre_T (C),
               "L'estage : " & C'Img & " a le numero : " &
               Num_Lu'Img & " au lieu de " & C'Img
               );
            C := C + 1;
            Etage := Lire_Etage_Suivant (Etage);
         end loop Verif_Successeur;
         AUnit.Assertions.Assert
            (Etage.Possede_Filtre,
            "L'étage : " & C'Img & " ne possede pas de filtre"
            );
         AUnit.Assertions.Assert
            (Lire_Filtre (Etage) in
            Des_P.Filtre_P.Sortie_P.Sortie_Decryptage_P.Sortie_T,
            "L'estage : " & C'Img & " n'est pas une sortie"
            );
         AUnit.Assertions.Assert
            (C = 17,
            "Il y a : " & C'Img &
            " estages, au lieu de 17"
            );
      end;
   end Test_Recuperation;

end Des_P.Chaine_P.Sequentiel_P.Constructeur_Decryptage_P.Test_P;
