--  @summary
--  Représentation abstraite des filtres de DES.
--  @description
--  Filtre de sortie abstrait qui va servir à paramétrer
--  chaque étages de la chaine.
--  @group Filtre
package Des_P.Filtre_P.Sortie_P is

   pragma Pure;

   --  Un filtre de sortie abstrait.
   type Sortie_Abstrait_T is abstract new
      Filtre_Interface_T with private;

private

   type Sortie_Abstrait_T is abstract new
      Filtre_Interface_T with null record;

end Des_P.Filtre_P.Sortie_P;
