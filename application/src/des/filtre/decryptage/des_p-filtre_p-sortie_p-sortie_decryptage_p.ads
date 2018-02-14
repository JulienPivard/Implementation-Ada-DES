with Des_P.Filtre_P.Decryptage_P;

--  @summary
--  Représentation du filtre de permutation final de cryptage DES.
--  @description
--  Filtre de décryptage permutation initial qui va servir à
--  paramétrer le dernier étage des filtres.
--  @group Filtre
package Des_P.Filtre_P.Sortie_P.Sortie_Decryptage_P is

   pragma Pure;

   --  Le filtre de décryptage qui va effectuer la dernière permutation.
   type Sortie_T is new Sortie_Abstrait_T and
      Des_P.Filtre_P.Decryptage_P.Decryptage_Interface_T with private;

   overriding
   procedure Filtrer
      (
         Filtre : Sortie_T;
         Bloc : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
         Clef : in out Des_P.Clef_P.Clef_56_Abs_P.Clef_56_Abs_T'Class
      );

private

   type Sortie_T is new Sortie_Abstrait_T and
      Des_P.Filtre_P.Decryptage_P.Decryptage_Interface_T with null record;

end Des_P.Filtre_P.Sortie_P.Sortie_Decryptage_P;
