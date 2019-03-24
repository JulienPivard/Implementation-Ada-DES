with AUnit.Reporter.Text;
with AUnit.Run;
with AUnit.Options;

with Suite_De_Tests_Bloc_P;
with Suite_De_Tests_Clef_P;
with Suite_De_Tests_Xor_P;
with Suite_De_Tests_Etage_P;
with Suite_De_Tests_Filtre_P;
with Suite_De_Tests_Sequentiel_P;
with Suite_De_Tests_Taches_P;
with Suite_De_Tests_Ravenscar_P;

with Des_P.Chaine_P.Ravenscar_P.Test_P;

procedure Main_Test_Harnais is

   procedure Runner_Suite_Tests_Bloc         is new AUnit.Run.Test_Runner
      (Suite_De_Tests_Bloc_P.Fonc_Suite);
   procedure Runner_Suite_Tests_Clef         is new AUnit.Run.Test_Runner
      (Suite_De_Tests_Clef_P.Fonc_Suite);
   procedure Runner_Suite_Tests_Xor          is new AUnit.Run.Test_Runner
      (Suite_De_Tests_Xor_P.Fonc_Suite);
   procedure Runner_Suite_Tests_Etage        is new AUnit.Run.Test_Runner
      (Suite_De_Tests_Etage_P.Fonc_Suite);
   procedure Runner_Suite_Tests_Filtre       is new AUnit.Run.Test_Runner
      (Suite_De_Tests_Filtre_P.Fonc_Suite);
   procedure Runner_Suite_Tests_Sequentiel   is new AUnit.Run.Test_Runner
      (Suite_De_Tests_Sequentiel_P.Fonc_Suite);
   procedure Runner_Suite_Tests_Taches       is new AUnit.Run.Test_Runner
      (Suite_De_Tests_Taches_P.Fonc_Suite);
   procedure Runner_Suite_Tests_Ravenscar    is new AUnit.Run.Test_Runner
      (Suite_De_Tests_Ravenscar_P.Fonc_Suite);

   Options : constant AUnit.Options.AUnit_Options :=
      AUnit.Options.AUnit_Options'
      (
         Global_Timer     => True,
         Test_Case_Timer  => True,
         Report_Successes => True,
         Filter           => null
      );
   Reporter : AUnit.Reporter.Text.Text_Reporter;

begin
   AUnit.Reporter.Text.Set_Use_ANSI_Colors (Reporter, True);

   Runner_Suite_Tests_Bloc       (Reporter, Options);
   Runner_Suite_Tests_Clef       (Reporter, Options);
   Runner_Suite_Tests_Xor        (Reporter, Options);
   Runner_Suite_Tests_Etage      (Reporter, Options);
   Runner_Suite_Tests_Filtre     (Reporter, Options);
   Runner_Suite_Tests_Sequentiel (Reporter, Options);
   Runner_Suite_Tests_Taches     (Reporter, Options);
   Runner_Suite_Tests_Ravenscar  (Reporter, Options);

   Des_P.Chaine_P.Ravenscar_P.Test_P.Test_Fin;

end Main_Test_Harnais;
