with AUnit.Reporter.Text;
with AUnit.Run;
with AUnit.Options;

with Bloc_32_Suite_P;
with Constructeur_Bloc_32_Suite_P;
with Sous_Clef_Suite;
with Clef_Suite;
with Constructeur_Sous_Clef_Suite;

procedure Main_Test_Harnais is

   procedure runner_bloc_32 is new AUnit.Run.Test_Runner
      (Bloc_32_Suite_P.Fonc_Bloc_32_Suite);
   procedure runner_constructeur_bloc_32 is new AUnit.Run.Test_Runner
      (Constructeur_Bloc_32_Suite_P.Fonc_Constructeur_Bloc_32_Suite);
   procedure runner_sous_clef is new AUnit.Run.Test_Runner
      (Sous_Clef_Suite.Fonc_Sous_Clef_Suite);
   procedure runner_clef is new AUnit.Run.Test_Runner
      (Clef_Suite.Fonc_Clef_Suite);
   procedure runner_construct_sous_clef is new AUnit.Run.Test_Runner
      (Constructeur_Sous_Clef_Suite.Fonc_Constructeur_Sous_Clef_Suite);

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

   runner_bloc_32 (reporter, options);
   runner_constructeur_bloc_32 (reporter, options);
   runner_sous_clef (reporter, options);
   runner_clef (reporter, options);
   runner_construct_sous_clef (reporter, options);
end Main_Test_Harnais;
