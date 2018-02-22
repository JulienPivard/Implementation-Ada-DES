with Des_P.Bloc_P.Bloc_64_P.Permutations_P;

package body Des_P.Filtre_P.Entree_P.Entree_Decryptage_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Filtrer
      (
         Filtre : Entree_T;
         Bloc : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
         Clef : in out Des_P.Clef_P.Clef_56_Abs_P.Clef_56_Abs_T'Class
      )
   is
      pragma Unreferenced (Filtre);
      pragma Unreferenced (Clef);
   begin
      Des_P.Bloc_P.Bloc_64_P.Permutations_P.Permutation_Entrante (Bloc);
   end Filtrer;

   ---------------------------------------------------------------------------
   overriding
   procedure Filtrer
      (
         Filtre : Entree_T;
         Bloc : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
         Clef : Des_P.Clef_P.Clef_48_Abs_P.Clef_48_Abs_T'Class
      )
   is
      pragma Unreferenced (Filtre);
      pragma Unreferenced (Clef);
   begin
      Des_P.Bloc_P.Bloc_64_P.Permutations_P.Permutation_Entrante (Bloc);
   end Filtrer;

end Des_P.Filtre_P.Entree_P.Entree_Decryptage_P;
