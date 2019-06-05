with Des_P.Bloc_P.Bloc_64_P.Permutations_P;

package body Des_P.Filtre_P.Entree_P.Dechiffre_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Filtrer
      (
         Filtre   :        Entree_T;
         Bloc     : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T
      )
   is
      pragma Unreferenced (Filtre);
   begin
      Des_P.Bloc_P.Bloc_64_P.Permutations_P.Permutation_Entrante
         (Bloc => Bloc);
   end Filtrer;

end Des_P.Filtre_P.Entree_P.Dechiffre_P;
