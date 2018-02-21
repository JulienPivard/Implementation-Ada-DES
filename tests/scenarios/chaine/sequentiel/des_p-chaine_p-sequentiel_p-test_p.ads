with AUnit;
with AUnit.Test_Fixtures;

with Des_P.Bloc_P.Bloc_64_P.Constructeur_P;
with Des_P.Clef_P.Constructeur_64_Abs_P;

with Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P;

package Des_P.Chaine_P.Sequentiel_P.Test_P is

   Brut : constant Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T :=
   2#11110000_11110000_11110000_11110000_11110000_11110000_11110000_11110000#;
   Brut_Initial : constant
      Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T := Brut;

   Brut_Clef : constant Des_P.Clef_P.Constructeur_64_Abs_P.Clef_64_Brut_T :=
   2#11110000_11110000_11110000_11110000_11110000_11110000_11110000_11110000#;

   Nom_Fichier : constant String := "fichier_tests_unitaire.txt";
   Extension : constant String := "crypt";

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         Chaine : Chaine_T;
         Clef : Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P.Clef_64_T;
      end record;

   overriding
   procedure Set_Up (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down (T : in out Test_Fixt_T);

   procedure Test_Filtre
      (T : in out Test_Fixt_T);

   procedure Test_Execution_2_Filtres
      (T : in out Test_Fixt_T);

   procedure Test_Execution_18_Filtres
      (T : in out Test_Fixt_T);

end Des_P.Chaine_P.Sequentiel_P.Test_P;
