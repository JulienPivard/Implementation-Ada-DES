with AUnit.Assertions;

with Des_P.Filtre_P.Entree_P.Entree_Cryptage_P;
with Des_P.Filtre_P.Corps_P.Corps_Cryptage_P;
with Des_P.Filtre_P.Sortie_P.Sortie_Cryptage_P;

package body Des_P.Filtre_P.Fabrique_P.Fabrique_Cryptage_P.Test_P is

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
      use Des_P.Filtre_P.Entree_P.Entree_Cryptage_P;
      Entree : Entree_T;
   begin
      AUnit.Assertions.Assert
         (Entree = Entree_T (T.Fab.Fabriquer_Entree),
         "Le filtre n'est pas un filtre d'entrée"
         );
   end Test_Fabrication_Entree;

   ---------------------------------------------------------------------------
   procedure Test_Fabrication_Corps
      (T : in out Test_Fixt_T)
   is
      use Des_P.Filtre_P.Corps_P.Corps_Cryptage_P;
      Corps : Corps_T;
   begin
      Corps.Modifier_Numero (Des_P.Filtre_P.Corps_P.Numero_Filtre_T'First);
      AUnit.Assertions.Assert
         (Corps = Corps_T (T.Fab.Fabriquer_Corps),
         "Le filtre n'est pas un filtre principal"
         );
   end Test_Fabrication_Corps;

   ---------------------------------------------------------------------------
   procedure Test_Fabrication_Sortie
      (T : in out Test_Fixt_T)
   is
      use Des_P.Filtre_P.Sortie_P.Sortie_Cryptage_P;
      Sortie : Sortie_T;
   begin
      AUnit.Assertions.Assert
         (Sortie = Sortie_T (T.Fab.Fabriquer_Sortie),
         "Le filtre n'est pas un filtre de sortie"
         );
   end Test_Fabrication_Sortie;

   ---------------------------------------------------------------------------
   procedure Test_Lire_Extention
      (T : in out Test_Fixt_T)
   is
   begin
      AUnit.Assertions.Assert
         ("crypt" = T.Fab.Lire_Extention,
         "La fabrique devrait avoir pour extension crypt mais a : " &
         T.Fab.Lire_Extention
         );
   end Test_Lire_Extention;

end Des_P.Filtre_P.Fabrique_P.Fabrique_Cryptage_P.Test_P;
