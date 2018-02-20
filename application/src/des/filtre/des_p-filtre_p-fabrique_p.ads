with Des_P.Filtre_P.Entree_P;
with Des_P.Filtre_P.Corps_P;
with Des_P.Filtre_P.Sortie_P;

--  @summary
--  Interface fabrique abstraite de filtre.
--  @description
--  Fabrique de filtres qui permet de fabriquer une famille de filtre.
--  @group Filtre
package Des_P.Filtre_P.Fabrique_P is

   pragma Pure;

   --  L'interface de la fabrique de filtre.
   type Fabrique_Interface_T is interface;

   --  Fabrique un filtre de permutation initial.
   --  @param Fabrique
   --  La fabrique de filtre
   --  @return Un filtre initial.
   function Fabriquer_Entree (Fabrique : Fabrique_Interface_T)
      return Des_P.Filtre_P.Entree_P.Entree_Abstrait_T'Class
   is abstract;

   --  Fabrique un filtre principal.
   --  @param Fabrique
   --  La fabrique de filtre
   --  @return Un filtre principal.
   function Fabriquer_Corps (Fabrique : Fabrique_Interface_T)
      return Des_P.Filtre_P.Corps_P.Corps_Abstrait_T'Class
   is abstract;

   --  Fabrique un filtre de permutation initial inverse.
   --  @param Fabrique
   --  La fabrique de filtre
   --  @return Un filtre initial inverse.
   function Fabriquer_Sortie (Fabrique : Fabrique_Interface_T)
      return Des_P.Filtre_P.Sortie_P.Sortie_Abstrait_T'Class
   is abstract;

   --  Permet de savoir quel est le type de filtre.
   --  @param Fabrique
   --  La fabrique de filtre
   --  @return Le type du filtre.
   function Lire_Extention (Fabrique : Fabrique_Interface_T)
      return String
   is abstract;

end Des_P.Filtre_P.Fabrique_P;
