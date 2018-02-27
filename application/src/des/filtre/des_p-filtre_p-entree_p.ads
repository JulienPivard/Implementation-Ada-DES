--  @summary
--  Représentation abstraite des filtres de DES.
--  @description
--  Filtre d'entrée abstrait qui va servir à paramétrer
--  chaque étages de la chaine.
--  @group Filtre
package Des_P.Filtre_P.Entree_P is

   pragma Pure;

   type Entree_Abstrait_T is abstract new
      Filtre_Interface_T with private;
   --  Un filtre d'entrée abstrait.

private

   type Entree_Abstrait_T is abstract new
      Filtre_Interface_T with null record;

end Des_P.Filtre_P.Entree_P;
