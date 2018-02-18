--  @summary
--  Représentation abstraite des filtres de cryptage de DES.
--  @description
--  Filtre abstrait de cryptage qui va servir à paramétrer chaque étage
--  de la chaine.
--  @group Filtre
package Des_P.Filtre_P.Cryptage_P is

   pragma Pure;

   --  Un filtre de cryptage abstrait.
   type Cryptage_Interface_T is interface and Filtre_Interface_T;

end Des_P.Filtre_P.Cryptage_P;
