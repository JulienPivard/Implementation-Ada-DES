with Des_P.Bloc_P.Bloc_64_P.Permutations_P;

package body Des_P.Filtre_P.Sortie_P.Sortie_Decryptage_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Filtrer
      (
         Filtre : Sortie_T;
         Bloc : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
         Clef : Des_P.Clef_P.Clef_48_Abs_P.Clef_48_Abs_T'Class
      )
   is
      pragma Unreferenced (Filtre);
      pragma Unreferenced (Clef);
   begin
      Des_P.Bloc_P.Bloc_64_P.Permutations_P.Permutation_Sortante (Bloc);
   end Filtrer;

end Des_P.Filtre_P.Sortie_P.Sortie_Decryptage_P;
