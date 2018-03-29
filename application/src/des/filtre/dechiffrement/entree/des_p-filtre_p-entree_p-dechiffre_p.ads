with Des_P.Filtre_P.Dechiffre_Interface_P;

--  @summary
--  Représentation du filtre de permutation initial de chiffrement DES.
--  @description
--  Filtre de déchiffrement permutation final qui va servir à
--  paramétrer le premier étage des filtres.
--  @group Filtre Déchiffrement
package Des_P.Filtre_P.Entree_P.Dechiffre_P is

   pragma Pure;

   package P_Dechiffrement_P renames Des_P.Filtre_P.Dechiffre_Interface_P;

   type Entree_T is new Entree_Abstrait_T and
      P_Dechiffrement_P.Dechiffrement_Interface_T with private;
   --  Le filtre de déchiffrement qui va effectuer la première permutation.

   overriding
   procedure Filtrer
      (
         Filtre : Entree_T;
         Bloc : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T
      );
   --  Filtre le bloc de 64 bits.
   --  @param Filtre
   --  Le filtre.
   --  @param Bloc
   --  Le bloc de 64 bits.

private

   type Entree_T is new Entree_Abstrait_T and
      P_Dechiffrement_P.Dechiffrement_Interface_T with null record;

end Des_P.Filtre_P.Entree_P.Dechiffre_P;
