with Entree_Chiffre_Suite_P;
with Sortie_Chiffre_Suite_P;
with Corps_Chiffre_Suite_P;

with Entree_Dechiffre_Suite_P;
with Sortie_Dechiffre_Suite_P;
with Corps_Dechiffre_Suite_P;

with Fonction_F_Suite_P;

with Fabrique_Chiffre_Suite_P;
with Fabrique_Dechiffre_Suite_P;

package body Suite_De_Tests_Filtre_P is

   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;
   begin
      Ptr_Test_Suite.all.Add_Test (Entree_Chiffre_Suite_P.Fonc_Suite);
      Ptr_Test_Suite.all.Add_Test (Sortie_Chiffre_Suite_P.Fonc_Suite);
      Ptr_Test_Suite.all.Add_Test (Corps_Chiffre_Suite_P.Fonc_Suite);

      Ptr_Test_Suite.all.Add_Test (Entree_Dechiffre_Suite_P.Fonc_Suite);
      Ptr_Test_Suite.all.Add_Test (Sortie_Dechiffre_Suite_P.Fonc_Suite);
      Ptr_Test_Suite.all.Add_Test (Corps_Dechiffre_Suite_P.Fonc_Suite);

      Ptr_Test_Suite.all.Add_Test (Fonction_F_Suite_P.Fonc_Suite);

      Ptr_Test_Suite.all.Add_Test (Fabrique_Chiffre_Suite_P.Fonc_Suite);
      Ptr_Test_Suite.all.Add_Test (Fabrique_Dechiffre_Suite_P.Fonc_Suite);

      return Ptr_Test_Suite;
   end Fonc_Suite;

end Suite_De_Tests_Filtre_P;
