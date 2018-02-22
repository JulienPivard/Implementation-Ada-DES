with Des_P.Filtre_P.Decryptage_P;

--  @summary
--  Représentation du filtre de permutation initial de cryptage DES.
--  @description
--  Filtre de décryptage permutation final qui va servir à
--  paramétrer le premier étage des filtres.
--  @group Filtre Décryptage
package Des_P.Filtre_P.Entree_P.Entree_Decryptage_P is

   pragma Pure;

   --  Le filtre de décryptage qui va effectuer la première permutation.
   type Entree_T is new Entree_Abstrait_T and
      Des_P.Filtre_P.Decryptage_P.Decryptage_Interface_T with private;

   overriding
   --  Filtre le bloc de 64 bits avec la clef de 56 bits.
   --  @param Filtre
   --  Le filtre.
   --  @param Bloc
   --  Le bloc de 64 bits.
   --  @param Clef
   --  la clef de 56 bits.
   procedure Filtrer
      (
         Filtre : Entree_T;
         Bloc : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
         Clef : in out Des_P.Clef_P.Clef_56_Abs_P.Clef_56_Abs_T'Class
      );

   procedure Filtrer
      (
         Filtre : Entree_T;
         Bloc : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
         Clef : Des_P.Clef_P.Clef_48_Abs_P.Clef_48_Abs_T'Class
      );

private

   type Entree_T is new Entree_Abstrait_T and
      Des_P.Filtre_P.Decryptage_P.Decryptage_Interface_T with null record;

end Des_P.Filtre_P.Entree_P.Entree_Decryptage_P;
