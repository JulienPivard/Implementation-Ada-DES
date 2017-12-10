with AUnit;
with AUnit.Test_Fixtures;

package Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P.Test_P is

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         clef_64 : Clef_64_T;
      end record;

   overriding
   procedure Set_Up (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down (T : in out Test_Fixt_T);

   procedure Test_Possede_Constructeur_56 (T : in out Test_Fixt_T);

   procedure Test_Possede_Constructeur_48 (T : in out Test_Fixt_T);

   procedure Test_Construire_Clef_56_Exception (T : in out Test_Fixt_T);

   procedure Test_Construire_Clef_56 (T : in out Test_Fixt_T);

   procedure Test_Construire_Clef_48_Via_56 (T : in out Test_Fixt_T);

   procedure Test_Lecture_Bit (T : in out Test_Fixt_T);

   procedure Test_Bits_Aleatoire (T : in out Test_Fixt_T);

   ---------------------------------------------------------------------------
   --                         Procédure d'exception                         --
   ---------------------------------------------------------------------------
   procedure Declencher_Exception_Constructeur_56;

end Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P.Test_P;
