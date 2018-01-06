--  @summary
--  Opérations de permutations sur bloc de 64 bits.
--  @description
--  Contient les opérations initial et final de permutations
--  sur des blocs de 64 bits.
--  @group Bloc
package Des_P.Bloc_P.Bloc_64_P.Permutations_P is

   pragma Pure;

   --  Effectue la permutation initial entre les bits
   --  du bloc de 64 bits.
   --  @param Bloc
   --  Le bloc de 64 bits.
   procedure Permutation_Entrante (Bloc : in out Bloc_64_T);

   --  Effectue la permutation finale entre les bits
   --  du bloc de 64 bits.
   --  @param Bloc
   --  Le bloc de 64 bits.
   procedure Permutation_Sortante (Bloc : in out Bloc_64_T);

private

   type Table_Permutations_T is array
      (Intervalle_Bloc_64_T)
      of Intervalle_Bloc_64_T;

end Des_P.Bloc_P.Bloc_64_P.Permutations_P;
