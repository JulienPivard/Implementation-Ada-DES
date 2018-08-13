--  @summary
--  Représentation abstraite des filtres de chiffrement de DES.
--  @description
--  Filtre abstrait de déchiffrement qui va servir à paramétrer chaque étage
--  de la chaine.
--  @group Filtre Déchiffrement
package Des_P.Filtre_P.Dechiffre_Interface_P
   with Pure
is

   type Dechiffrement_Interface_T is interface and Filtre_Interface_T;
   --  Un filtre de déchiffrement abstrait.

end Des_P.Filtre_P.Dechiffre_Interface_P;
