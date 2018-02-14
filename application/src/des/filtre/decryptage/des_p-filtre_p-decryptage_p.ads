--  @summary
--  Représentation abstraite des filtres de cryptage de DES.
--  @description
--  Filtre abstrait de décryptage qui va servir à paramétrer chaque étage
--  de la chaine.
--  @group Filtre
package Des_P.Filtre_P.Decryptage_P is

   pragma Pure;

   --  Un filtre de cryptage abstrait.
   type Decryptage_Interface_T is interface and Filtre_Interface_T;

end Des_P.Filtre_P.Decryptage_P;
