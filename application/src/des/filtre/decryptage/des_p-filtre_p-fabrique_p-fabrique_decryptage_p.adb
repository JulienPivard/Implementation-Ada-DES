with Des_P.Filtre_P.Entree_P.Entree_Decryptage_P;
with Des_P.Filtre_P.Corps_P.Corps_Decryptage_P;
with Des_P.Filtre_P.Sortie_P.Sortie_Decryptage_P;

package body Des_P.Filtre_P.Fabrique_P.Fabrique_Decryptage_P is

   ---------------------------------------------------------------------------
   overriding
   function Fabriquer_Entree
      (Fabrique : Fabrique_Decryptage_T)
      return Des_P.Filtre_P.Entree_P.Entree_Abstrait_T'Class
   is
      pragma Unreferenced (Fabrique);
      Filtre : Des_P.Filtre_P.Entree_P.Entree_Decryptage_P.Entree_T;
   begin
      return Filtre;
   end Fabriquer_Entree;

   ---------------------------------------------------------------------------
   overriding
   function Fabriquer_Corps
      (Fabrique : Fabrique_Decryptage_T)
      return Des_P.Filtre_P.Corps_P.Corps_Abstrait_T'Class
   is
      pragma Unreferenced (Fabrique);
      Filtre : Des_P.Filtre_P.Corps_P.Corps_Decryptage_P.Corps_T;
   begin
      Filtre.Modifier_Numero (Des_P.Filtre_P.Corps_P.Numero_Filtre_T'First);
      return Filtre;
   end Fabriquer_Corps;

   ---------------------------------------------------------------------------
   overriding
   function Fabriquer_Sortie
      (Fabrique : Fabrique_Decryptage_T)
      return Des_P.Filtre_P.Sortie_P.Sortie_Abstrait_T'Class
   is
      pragma Unreferenced (Fabrique);
      Filtre : Des_P.Filtre_P.Sortie_P.Sortie_Decryptage_P.Sortie_T;
   begin
      return Filtre;
   end Fabriquer_Sortie;

end Des_P.Filtre_P.Fabrique_P.Fabrique_Decryptage_P;
