with AUnit.Reporter.Text;
with AUnit.Run;
with AUnit.Options;

with Bloc_Suite;
with Constructeur_Suite;

procedure Main_Test_Harnais is

   procedure runner_bloc is new AUnit.Run.Test_Runner
      (Bloc_Suite.Fonc_Bloc_Suite);
   procedure runner_constructeur is new AUnit.Run.Test_Runner
      (Constructeur_Suite.Fonc_Constructeur_Suite);

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
   runner_bloc (reporter, options);
   runner_constructeur (reporter, options);
end Main_Test_Harnais;
