with Des_P.Filtre_P.Dechiffre_Interface_P;

--  @summary
--  Représentation du filtre de permutation final de chiffrement DES.
--  @description
--  Filtre de déchiffrement permutation initial qui va servir à
--  paramétrer le dernier étage des filtres.
--  @group Filtre Déchiffrement
package Des_P.Filtre_P.Sortie_P.Dechiffre_P
   with Pure
is

   package P_Dechiffrement_R renames Des_P.Filtre_P.Dechiffre_Interface_P;

   type Sortie_T is new Sortie_Abstrait_T and
      P_Dechiffrement_R.Dechiffrement_Interface_T with private;
   --  Le filtre de déchiffrement qui va effectuer la dernière permutation.

   overriding
   procedure Filtrer
      (
         Filtre   :        Sortie_T;
         Bloc     : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T
      )
      with Inline;
   --  Filtre le bloc de 64 bits avec la clef de 48 bits.
   --  @param Filtre
   --  Le filtre.
   --  @param Bloc
   --  Le bloc de 64 bits.

private

   type Sortie_T is new Sortie_Abstrait_T and
      P_Dechiffrement_R.Dechiffrement_Interface_T with null record;

end Des_P.Filtre_P.Sortie_P.Dechiffre_P;
