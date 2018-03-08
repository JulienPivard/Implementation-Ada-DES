with AUnit.Assertions;

with Des_P.Etage_P.Filtrage_P;
--  with Des_P.Etage_P.Filtrage_P.Explorer_P;
--  with Des_P.Filtre_P.Entree_P.Cryptage_P;
--  with Des_P.Filtre_P.Corps_P.Cryptage_P;
--  with Des_P.Filtre_P.Sortie_P.Cryptage_P;
with Des_P.Clef_P.Clef_56_P.Constructeur_P;
with Des_P.Clef_P.Clef_48_P.Constructeur_P;

--  with Des_P.Clef_P.Clef_64_Simplifie_P;

package body Des_P.Chaine_P.Taches_P.Constructeur_Cryptage_P.Test_P is

   package Faiseur_56_P renames Des_P.Clef_P.Clef_56_P.Constructeur_P;
   package Faiseur_48_P renames Des_P.Clef_P.Clef_48_P.Constructeur_P;

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      C : Constructeur_Cryptage_T;
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
   procedure Test_Initialisation
      (T : in out Test_Fixt_T)
   is
      --  E : Des_P.Etage_P.Filtrage_P.Etage_T;
   begin
--    AUnit.Assertions.Assert
--       (T.C.Chaine.Tete = E,
--       "La tète devrait être un étage vide"
--       );
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
   procedure Test_Construction
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);
   begin
      AUnit.Assertions.Assert
         (False,
         "Pas encore implemente."
         );
   end Test_Construction;

   ---------------------------------------------------------------------------
   procedure Test_Recuperation
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);
   begin
      AUnit.Assertions.Assert
         (False,
         "Pas encore implemente."
         );
   end Test_Recuperation;

end Des_P.Chaine_P.Taches_P.Constructeur_Cryptage_P.Test_P;
