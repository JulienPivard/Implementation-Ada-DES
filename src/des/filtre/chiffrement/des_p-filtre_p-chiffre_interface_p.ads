--  @summary
--  Représentation abstraite des filtres de chiffrement de DES.
--  @description
--  Filtre abstrait de chiffrement qui va servir à paramétrer chaque étage
--  de la chaine.
--  @group Filtre Chiffrement
package Des_P.Filtre_P.Chiffre_Interface_P
   with Pure
is

   type Chiffrement_Interface_T is interface and Filtre_Interface_T;
   --  Un filtre de chiffrement abstrait.

end Des_P.Filtre_P.Chiffre_Interface_P;
