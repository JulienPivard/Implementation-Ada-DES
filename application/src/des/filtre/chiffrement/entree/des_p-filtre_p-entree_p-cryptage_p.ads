with Des_P.Filtre_P.Cryptage_Interface_P;

--  @summary
--  Représentation du filtre de permutation initial de chiffrement DES.
--  @description
--  Filtre de chiffrement permutation initial qui va servir à paramétrer le
--  premier étage des filtres.
--  @group Filtre Chiffrement
package Des_P.Filtre_P.Entree_P.Cryptage_P is

   pragma Pure;

   package P_Cryptage_P renames Des_P.Filtre_P.Cryptage_Interface_P;

   type Entree_T is new Entree_Abstrait_T and
      P_Cryptage_P.Cryptage_Interface_T with private;
   --  Le filtre de chiffrement qui va effectuer la première
   --  permutation pour chiffrer.

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
      P_Cryptage_P.Cryptage_Interface_T with null record;

end Des_P.Filtre_P.Entree_P.Cryptage_P;
