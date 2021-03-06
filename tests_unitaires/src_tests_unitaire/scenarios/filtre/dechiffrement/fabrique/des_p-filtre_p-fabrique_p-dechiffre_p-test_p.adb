with AUnit.Assertions;

with Des_P.Filtre_P.Entree_P.Dechiffre_P;
with Des_P.Filtre_P.Corps_P.Dechiffre_P;
with Des_P.Filtre_P.Sortie_P.Dechiffre_P;

with Des_P.Clef_P.Clef_48_Simple_P;

package body Des_P.Filtre_P.Fabrique_P.Dechiffre_P.Test_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
   begin
      null;
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
   procedure Test_Fabrication_Entree
      (T : in out Test_Fixt_T)
   is
      package Entree_R renames Des_P.Filtre_P.Entree_P.Dechiffre_P;

      use type Entree_R.Entree_T;

      Entree : Entree_R.Entree_T;
   begin
      AUnit.Assertions.Assert
         (Entree = Entree_R.Entree_T (T.Fab.Fabriquer_Entree),
         "Le filtre n'est pas un filtre d'entrée"
         );
   end Test_Fabrication_Entree;

   ---------------------------------------------------------------------------
   procedure Test_Fabrication_Corps
      (T : in out Test_Fixt_T)
   is
      package Corps_R renames Des_P.Filtre_P.Corps_P.Dechiffre_P;

      use type Corps_R.Corps_T;

      Corps : Corps_R.Corps_T;
      Clef : Des_P.Clef_P.Clef_48_Simple_P.Clef_S_T;
   begin
      Corps.Modifier_Clef (Clef);
      AUnit.Assertions.Assert
         (Corps = Corps_R.Corps_T (T.Fab.Fabriquer_Corps (Clef)),
         "Le filtre n'est pas un filtre principal"
         );
   end Test_Fabrication_Corps;

   ---------------------------------------------------------------------------
   procedure Test_Fabrication_Sortie
      (T : in out Test_Fixt_T)
   is
      package Sortie_R renames Des_P.Filtre_P.Sortie_P.Dechiffre_P;

      use type Sortie_R.Sortie_T;

      Sortie : Sortie_R.Sortie_T;
   begin
      AUnit.Assertions.Assert
         (Sortie = Sortie_R.Sortie_T (T.Fab.Fabriquer_Sortie),
         "Le filtre n'est pas un filtre de sortie"
         );
   end Test_Fabrication_Sortie;

end Des_P.Filtre_P.Fabrique_P.Dechiffre_P.Test_P;
