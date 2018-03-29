with Des_P.Filtre_P.Entree_P.Dechiffre_P;
with Des_P.Filtre_P.Corps_P.Dechiffre_P;
with Des_P.Filtre_P.Sortie_P.Dechiffre_P;

package body Des_P.Filtre_P.Fabrique_P.Dechiffre_P is

   ---------------------------------------------------------------------------
   overriding
   function Fabriquer_Entree
      (Fabrique : Fabrique_T)
      return Des_P.Filtre_P.Entree_P.Entree_Abstrait_T'Class
   is
      pragma Unreferenced (Fabrique);
      Filtre : Des_P.Filtre_P.Entree_P.Dechiffre_P.Entree_T;
   begin
      return Filtre;
   end Fabriquer_Entree;

   ---------------------------------------------------------------------------
   overriding
   function Fabriquer_Corps
      (
         Fabrique : Fabrique_T;
         Clef : Des_P.Clef_P.Clef_48_I_P.Clef_Interface_T'Class
      )
      return Des_P.Filtre_P.Corps_P.Corps_Abstrait_T'Class
   is
      pragma Unreferenced (Fabrique);
      Filtre : Des_P.Filtre_P.Corps_P.Dechiffre_P.Corps_T;
   begin
      Filtre.Modifier_Clef (Clef);
      return Filtre;
   end Fabriquer_Corps;

   ---------------------------------------------------------------------------
   overriding
   function Fabriquer_Sortie
      (Fabrique : Fabrique_T)
      return Des_P.Filtre_P.Sortie_P.Sortie_Abstrait_T'Class
   is
      pragma Unreferenced (Fabrique);
      Filtre : Des_P.Filtre_P.Sortie_P.Dechiffre_P.Sortie_T;
   begin
      return Filtre;
   end Fabriquer_Sortie;

end Des_P.Filtre_P.Fabrique_P.Dechiffre_P;
