--  @summary
--  Une fabrique abstraite de filtre de décryptage.
--  @description
--  Fabrique de filtres qui permet de fabriquer des filtres de décryptage.
--  @group Filtre Fabrique Décryptage
package Des_P.Filtre_P.Fabrique_P.Fabrique_Decryptage_P is

   pragma Pure;

   --  Une fabrique de filtre de décryptage.
   type Fabrique_Decryptage_T is new Fabrique_Interface_T with private;

   overriding
   --  Fabrique un filtre de permutation initial.
   --  @param Fabrique
   --  La fabrique de filtre
   --  @return Un filtre initial.
   function Fabriquer_Entree (Fabrique : Fabrique_Decryptage_T)
      return Des_P.Filtre_P.Entree_P.Entree_Abstrait_T'Class;

   overriding
   --  Fabrique un filtre principal.
   --  @param Fabrique
   --  La fabrique de filtre
   --  @return Un filtre principal.
   function Fabriquer_Corps (Fabrique : Fabrique_Decryptage_T)
      return Des_P.Filtre_P.Corps_P.Corps_Abstrait_T'Class;

   overriding
   --  Fabrique un filtre de permutation initial inverse.
   --  @param Fabrique
   --  La fabrique de filtre
   --  @return Un filtre initial inverse.
   function Fabriquer_Sortie (Fabrique : Fabrique_Decryptage_T)
      return Des_P.Filtre_P.Sortie_P.Sortie_Abstrait_T'Class;

private

   type Fabrique_Decryptage_T is new Fabrique_Interface_T with null record;

end Des_P.Filtre_P.Fabrique_P.Fabrique_Decryptage_P;