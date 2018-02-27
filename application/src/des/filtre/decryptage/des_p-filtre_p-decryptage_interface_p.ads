--  @summary
--  Représentation abstraite des filtres de cryptage de DES.
--  @description
--  Filtre abstrait de décryptage qui va servir à paramétrer chaque étage
--  de la chaine.
--  @group Filtre Décryptage
package Des_P.Filtre_P.Decryptage_Interface_P is

   pragma Pure;

   type Decryptage_Interface_T is interface and Filtre_Interface_T;
   --  Un filtre de cryptage abstrait.

end Des_P.Filtre_P.Decryptage_Interface_P;
