with AUnit.Assertions;

with Des_P.Etage_P.Filtrage_P;
with Des_P.Clef_P.Clef_56_P.Constructeur_P;
with Des_P.Clef_P.Clef_48_P.Constructeur_P;

with Des_P.Clef_P.Clef_64_Simplifie_P;

package body Des_P.Chaine_P.Taches_P.Constructeur_Decryptage_P.Test_P is

   package Faiseur_56_P renames Des_P.Clef_P.Clef_56_P.Constructeur_P;
   package Faiseur_48_P renames Des_P.Clef_P.Clef_48_P.Constructeur_P;

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      C : Constructeur_Decryptage_T;
      F_56 : Faiseur_56_P.Constructeur_Clef_T;
      F_48 : Faiseur_48_P.Constructeur_Clef_T;
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
      C : Chaine_T;
   begin
      AUnit.Assertions.Assert
         (T.C.Chaine = C,
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
      C_64 : Des_P.Clef_P.Clef_64_Simplifie_P.Clef_S_T;
   begin
      C_64.Init ((others => False));
      T.C.Construire (C_64);
      AUnit.Assertions.Assert
         (
            not T.C.Chaine.Filtre_Entree.Is_Empty,
            "L'entree est vide"
         );
      Verif_Successeur :
      for I in Numero_Filtre_T loop
         AUnit.Assertions.Assert
            (
               not T.C.Chaine.Filtres_Corps (I).Is_Empty,
               "Le filtre de corps" & I'Img & " est vide."
            );
      end loop Verif_Successeur;
      AUnit.Assertions.Assert
         (
            not T.C.Chaine.Filtre_Sortie.Is_Empty,
            "L'entree est vide"
         );
   end Test_Construction;

   ---------------------------------------------------------------------------
   procedure Test_Recuperation (T : in out Test_Fixt_T) is
      C_64 : Des_P.Clef_P.Clef_64_Simplifie_P.Clef_S_T;
      Chaine : Chaine_T;
   begin
      C_64.Init ((others => False));
      T.C.Construire (C_64);
      Chaine := Chaine_T (T.C.Recuperer_Chaine);
      AUnit.Assertions.Assert
         (
            not Chaine.Filtre_Entree.Is_Empty,
            "L'entree est vide"
         );
      Verif_Successeur :
      for I in Numero_Filtre_T loop
         AUnit.Assertions.Assert
            (
               not Chaine.Filtres_Corps (I).Is_Empty,
               "Le filtre de corps" & I'Img & " est vide."
            );
      end loop Verif_Successeur;
      AUnit.Assertions.Assert
         (
            not Chaine.Filtre_Sortie.Is_Empty,
            "L'entree est vide"
         );
   end Test_Recuperation;

end Des_P.Chaine_P.Taches_P.Constructeur_Decryptage_P.Test_P;
