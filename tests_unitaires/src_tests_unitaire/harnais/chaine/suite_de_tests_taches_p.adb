with Chaine_Tache_Suite_P;
with Constructeur_Tache_Chiffre_Suite_P;
with Constructeur_Tache_Dechiffre_Suite_P;

package body Suite_De_Tests_Taches_P is

   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
   begin
      Ptr_Test_Suite.all.Add_Test
         (Chaine_Tache_Suite_P.Fonc_Suite);
      Ptr_Test_Suite.all.Add_Test
         (Constructeur_Tache_Chiffre_Suite_P.Fonc_Suite);
      Ptr_Test_Suite.all.Add_Test
         (Constructeur_Tache_Dechiffre_Suite_P.Fonc_Suite);

      return Ptr_Test_Suite;
   end Fonc_Suite;

end Suite_De_Tests_Taches_P;
