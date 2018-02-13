--  @summary
--  Représentation du filtre de permutation initial de cryptage DES.
--  @description
--  Filtre de cryptage permutation initial qui va servir à paramétrer le
--  premier étage des filtres.
--  @group Filtre
package Des_P.Filtre_P.Decryptage_P.Ip_P is

   pragma Pure;

   --  Le filtre de cryptage qui va effectuer la permutation initial
   type Entree_T is new Cryptage_Abstrait_T with private;

   overriding
   procedure Filtrer
      (
         Filtre : Entree_T;
         Bloc : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
         Clef : in out Des_P.Clef_P.Clef_56_Abs_P.Clef_56_Abs_T'Class
      );

   overriding
   procedure Modifier_Numero
      (
         Filtre : in out Entree_T;
         Numero : Numero_Filtre_T
      );

private

   type Entree_T is new Cryptage_Abstrait_T with null record;

end Des_P.Filtre_P.Decryptage_P.Ip_P;
