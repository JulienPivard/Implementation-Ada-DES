with AUnit.Reporter.Text;
with AUnit.Run;
with AUnit.Options;

with Suite_De_Tests_Bloc_P;
with Suite_De_Tests_Clef_P;
with Suite_De_Tests_Xor_P;
with Suite_De_Tests_Etage_P;
with Suite_De_Tests_Filtre_P;
with Suite_De_Tests_Chaine_P;

with Des_P.Chaine_P.Ravenscar_P.Test_P;

procedure Main_Test_Harnais is

   procedure runner_suite_tests_bloc is new AUnit.Run.Test_Runner
      (Suite_De_Tests_Bloc_P.Fonc_Suite);
   procedure runner_suite_tests_clef is new AUnit.Run.Test_Runner
      (Suite_De_Tests_Clef_P.Fonc_Suite);
   procedure runner_suite_tests_xor is new AUnit.Run.Test_Runner
      (Suite_De_Tests_Xor_P.Fonc_Suite);
   procedure runner_suite_tests_etage is new AUnit.Run.Test_Runner
      (Suite_De_Tests_Etage_P.Fonc_Suite);
   procedure runner_suite_tests_filtre is new AUnit.Run.Test_Runner
      (Suite_De_Tests_Filtre_P.Fonc_Suite);
   procedure runner_suite_tests_chaine is new AUnit.Run.Test_Runner
      (Suite_De_Tests_Chaine_P.Fonc_Suite);

   options : constant AUnit.Options.AUnit_Options :=
      (
         Global_Timer     => True,
         Test_Case_Timer  => True,
         Report_Successes => True,
         Filter           => null
      );
   reporter : AUnit.Reporter.Text.Text_Reporter;

begin
   AUnit.Reporter.Text.Set_Use_ANSI_Colors (reporter, True);

   runner_suite_tests_bloc (reporter, options);
   runner_suite_tests_clef (reporter, options);
   runner_suite_tests_xor (reporter, options);
   runner_suite_tests_etage (reporter, options);
   runner_suite_tests_filtre (reporter, options);
   runner_suite_tests_chaine (reporter, options);

   Des_P.Chaine_P.Ravenscar_P.Test_P.Test_Fin;

end Main_Test_Harnais;
