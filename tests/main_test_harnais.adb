with AUnit.Reporter.Text;
with AUnit.Run;
with AUnit.Options;

with Suite_De_Tests_Bloc_P;

with Clef_48_Suite_P;
with Clef_56_Suite_P;
with Clef_64_Suite_P;

with Constructeur_Clef_48_Suite_P;
with Constructeur_Clef_56_Suite_P;
with Constructeur_Clef_64_Suite_P;

procedure Main_Test_Harnais is

   procedure runner_suite_tests_bloc is new AUnit.Run.Test_Runner
      (Suite_De_Tests_Bloc_P.Fonc_Suite);

   procedure runner_clef_48 is new AUnit.Run.Test_Runner
      (Clef_48_Suite_P.Fonc_Clef_48_Suite);
   procedure runner_clef_56 is new AUnit.Run.Test_Runner
      (Clef_56_Suite_P.Fonc_Clef_56_Suite);
   procedure runner_clef_64 is new AUnit.Run.Test_Runner
      (Clef_64_Suite_P.Fonc_Clef_64_Suite);

   procedure runner_construct_48_clef is new AUnit.Run.Test_Runner
      (Constructeur_Clef_48_Suite_P.Fonc_Constructeur_Clef_48_Suite);
   procedure runner_construct_56_clef is new AUnit.Run.Test_Runner
      (Constructeur_Clef_56_Suite_P.Fonc_Constructeur_Clef_56_Suite);
   procedure runner_construct_64_clef is new AUnit.Run.Test_Runner
      (Constructeur_Clef_64_Suite_P.Fonc_Constructeur_Clef_64_Suite);

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

   runner_clef_48 (reporter, options);
   runner_clef_56 (reporter, options);
   runner_clef_64 (reporter, options);

   runner_construct_48_clef (reporter, options);
   runner_construct_56_clef (reporter, options);
   runner_construct_64_clef (reporter, options);
end Main_Test_Harnais;
