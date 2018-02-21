with AUnit.Assertions;

with Des_P.Etage_P.Filtrage_P;
with Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Constructeur_56_P;
with Des_P.Clef_P.Clef_64_Abs_P.Clef_Simplifie_P;
with Des_P.Etage_P.Filtrage_P.Explorer_P;

package body Des_P.Chaine_P.Sequentiel_P.Constructeur_Cryptage_P.Test_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      C : Constructeur_Cryptage_T;
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
         use Des_P.Etage_P.Filtrage_P.Explorer_P;
         Etage : Des_P.Etage_P.Filtrage_P.Etage_T :=
            Lire_Etage_Suivant (T.C.Chaine.Tete);
         C : Integer := 1;
      begin
         Verif_Successeur :
         loop
            exit Verif_Successeur when not Etage.Possede_Successeur;
            C := C + 1;
            AUnit.Assertions.Assert
               (Etage.Possede_Filtre,
               "L'étage : " & C'Img & " ne possede pas de filtre"
               );
            Etage := Lire_Etage_Suivant (Etage);
         end loop Verif_Successeur;
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
         use Des_P.Etage_P.Filtrage_P.Explorer_P;
         Etage : Des_P.Etage_P.Filtrage_P.Etage_T :=
            Lire_Etage_Suivant (Chaine.Tete);
         C : Integer := 1;
      begin
         Verif_Successeur :
         loop
            exit Verif_Successeur when not Etage.Possede_Successeur;
            C := C + 1;
            AUnit.Assertions.Assert
               (Etage.Possede_Filtre,
               "L'étage : " & C'Img & " ne possede pas de filtre"
               );
            Etage := Lire_Etage_Suivant (Etage);
         end loop Verif_Successeur;
         AUnit.Assertions.Assert
            (C = 17,
            "Il y a : " & C'Img &
            " estages, au lieu de 17"
            );
      end;
   end Test_Recuperation;

end Des_P.Chaine_P.Sequentiel_P.Constructeur_Cryptage_P.Test_P;
