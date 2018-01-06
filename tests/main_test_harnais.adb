with AUnit.Reporter.Text;
with AUnit.Run;
with AUnit.Options;

with Suite_De_Tests_Bloc_P;

with Suite_De_Tests_Clef_P;

procedure Main_Test_Harnais is

   procedure runner_suite_tests_bloc is new AUnit.Run.Test_Runner
      (Suite_De_Tests_Bloc_P.Fonc_Suite);

   procedure runner_suite_tests_clef is new AUnit.Run.Test_Runner
      (Suite_De_Tests_Clef_P.Fonc_Suite);

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
end Main_Test_Harnais;
