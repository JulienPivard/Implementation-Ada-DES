with Bloc_32_Suite_P;
with Constructeur_Bloc_32_Suite_P;
with Bloc_48_Suite_P;
with Constructeur_Bloc_48_Suite_P;
with Bloc_64_Suite_P;
with Constructeur_Bloc_64_Suite_P;
with Permutations_64_Suite_P;

package body Suite_De_Tests_Bloc_P is

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
   begin
      Ptr_Test_Suite.all.Add_Test
         (Bloc_32_Suite_P.Fonc_Suite);
      Ptr_Test_Suite.all.Add_Test
         (Constructeur_Bloc_32_Suite_P.Fonc_Suite);
      Ptr_Test_Suite.all.Add_Test
         (Bloc_48_Suite_P.Fonc_Suite);
      Ptr_Test_Suite.all.Add_Test
         (Constructeur_Bloc_48_Suite_P.Fonc_Suite);
      Ptr_Test_Suite.all.Add_Test
         (Bloc_64_Suite_P.Fonc_Suite);
      Ptr_Test_Suite.all.Add_Test
         (Constructeur_Bloc_64_Suite_P.Fonc_Suite);
      Ptr_Test_Suite.all.Add_Test
         (Permutations_64_Suite_P.Fonc_Suite);

      return Ptr_Test_Suite;
   end Fonc_Suite;

end Suite_De_Tests_Bloc_P;
