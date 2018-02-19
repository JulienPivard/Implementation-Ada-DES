--  @summary
--  Une fabrique abstraite de filtre de décryptage.
--  @description
--  Fabrique de filtres qui permet de fabriquer des filtres de décryptage.
--  @group Filtre
package Des_P.Filtre_P.Fabrique_P.Fabrique_Decryptage_P is

   --  Une fabrique de filtre de décryptage.
   type Fabrique_Decryptage_T is new Fabrique_Interface_T with private;

   overriding
   function Fabriquer_Entree (Fabrique : Fabrique_Decryptage_T)
      return Des_P.Filtre_P.Entree_P.Entree_Abstrait_T'Class;

   overriding
   function Fabriquer_Corps (Fabrique : Fabrique_Decryptage_T)
      return Des_P.Filtre_P.Corps_P.Corps_Abstrait_T'Class;

   overriding
   function Fabriquer_Sortie (Fabrique : Fabrique_Decryptage_T)
      return Des_P.Filtre_P.Sortie_P.Sortie_Abstrait_T'Class;

   overriding
   function Lire_Extention (Fabrique : Fabrique_Decryptage_T)
      return String;

private

   type Fabrique_Decryptage_T is new Fabrique_Interface_T with null record;

end Des_P.Filtre_P.Fabrique_P.Fabrique_Decryptage_P;
