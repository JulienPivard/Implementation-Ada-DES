--  @summary
--  Une fabrique abstraite de filtre de cryptage.
--  @description
--  Fabrique de filtres qui permet de fabriquer des filtres de cryptage.
--  @group Filtre
package Des_P.Filtre_P.Fabrique_P.Fabrique_Cryptage_P is

   --  Une fabrique de filtre de cryptage.
   type Fabrique_Cryptage_T is new Fabrique_Interface_T with private;

   overriding
   function Fabriquer_Entree (Fabrique : Fabrique_Cryptage_T)
      return Des_P.Filtre_P.Entree_P.Entree_Abstrait_T'Class;

   overriding
   function Fabriquer_Corps (Fabrique : Fabrique_Cryptage_T)
      return Des_P.Filtre_P.Corps_P.Corps_Abstrait_T'Class;

   overriding
   function Fabriquer_Sortie (Fabrique : Fabrique_Cryptage_T)
      return Des_P.Filtre_P.Sortie_P.Sortie_Abstrait_T'Class;

private

   type Fabrique_Cryptage_T is new Fabrique_Interface_T with null record;

end Des_P.Filtre_P.Fabrique_P.Fabrique_Cryptage_P;
