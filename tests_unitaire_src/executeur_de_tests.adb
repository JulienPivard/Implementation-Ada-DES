with Ada.Command_Line;
with Ada.Exceptions;
with Ada.Text_IO;

with GNAT.Source_Info;

with AUnit.Options;
with AUnit.Reporter.Text;
with AUnit.Reporter.XML;
with AUnit.Run;

with Suite_De_Tests_Bloc_P;
with Suite_De_Tests_Clef_P;
with Suite_De_Tests_Xor_P;
with Suite_De_Tests_Etage_P;
with Suite_De_Tests_Filtre_P;
with Suite_De_Tests_Sequentiel_P;
with Suite_De_Tests_Taches_P;
with Suite_De_Tests_Ravenscar_P;

with Des_P.Chaine_P.Ravenscar_P.Test_P;

procedure Executeur_De_Tests is
   type Mode_T is (Txt_E, XML_E);

   ---------------------------------------------------------------------------
   function Creer_Reporter
      return AUnit.Reporter.Reporter'Class;

   function Creer_Reporter
      return AUnit.Reporter.Reporter'Class
   is
      NB_Args : constant Integer := Ada.Command_Line.Argument_Count;

      Mode : constant Mode_T :=
         (
            if NB_Args = 0 then
               Txt_E
            elsif Ada.Command_Line.Argument (1) = "xml" then
               XML_E
            elsif Ada.Command_Line.Argument (1) = "txt" then
               Txt_E
            else
               Txt_E
         );

      Reporter_Txt : AUnit.Reporter.Text.Text_Reporter;
      Reporter_XML : AUnit.Reporter.XML.XML_Reporter;
   begin
      case Mode is
         when Txt_E =>
            AUnit.Reporter.Text.Set_Use_ANSI_Colors
               (
                  Engine => Reporter_Txt,
                  Value  => True
               );
         when XML_E =>
            null;
      end case;

      return
         (
            case Mode is
               when Txt_E =>
                  Reporter_Txt,
               when XML_E =>
                  Reporter_XML
         );
   end Creer_Reporter;
   ---------------------------------------------------------------------------

   --  Instanciation des procédures de tests.
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

   --  Options d'affichage du reporter
   Options  : constant AUnit.Options.AUnit_Options :=
      AUnit.Options.AUnit_Options'
         (
            Global_Timer     => True,
            Test_Case_Timer  => True,
            Report_Successes => True,
            Filter           => null
         );
   Reporter : constant AUnit.Reporter.Reporter'Class := Creer_Reporter;
begin
   --  Lancement des suites de tests.
   Runner_Suite_Tests_Bloc       (Reporter, Options);
   Runner_Suite_Tests_Clef       (Reporter, Options);
   Runner_Suite_Tests_Xor        (Reporter, Options);
   Runner_Suite_Tests_Etage      (Reporter, Options);
   Runner_Suite_Tests_Filtre     (Reporter, Options);
   Runner_Suite_Tests_Sequentiel (Reporter, Options);
   Runner_Suite_Tests_Taches     (Reporter, Options);
   Runner_Suite_Tests_Ravenscar  (Reporter, Options);

   Des_P.Chaine_P.Ravenscar_P.Test_P.Test_Fin;
exception
   when E : others =>
      Ada.Text_IO.Put_Line
         (
            Item => Ada.Exceptions.Exception_Information (X => E) &
                  ASCII.LF & GNAT.Source_Info.Source_Location
         );
end Executeur_De_Tests;
