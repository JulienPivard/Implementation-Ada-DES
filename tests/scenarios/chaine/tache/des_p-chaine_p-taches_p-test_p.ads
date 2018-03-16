with AUnit;
with AUnit.Test_Fixtures;

with Des_P.Bloc_P.Bloc_64_P.Constructeur_P;
with Des_P.Clef_P.Clef_64_I_P.Constructeur_I_P;

with Des_P.Clef_P.Clef_64_P;

package Des_P.Chaine_P.Taches_P.Test_P is

   Brut : constant Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T :=
   2#11110000_11110000_11110000_11110000_11110000_11110000_11110000_11110000#;

   Brut_Clef : constant
   Des_P.Clef_P.Clef_64_I_P.Constructeur_I_P.Clef_64_Brut_T :=
   2#11110000_11110000_11110000_11110000_11110000_11110000_11110000_11110000#;

   Brut_Attendu : constant
   Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T :=
      15799177843826553255;

   Nom_Fichier : constant String := "fichier_tests_unitaire.txt";
   Extension : constant String := "crypt";
   Nom_Alternatif : constant String := Nom_Fichier & "." & Extension;

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         Chaine : Chaine_T;
         Clef : Des_P.Clef_P.Clef_64_P.Clef_T;
      end record;

   overriding
   procedure Set_Up (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down (T : in out Test_Fixt_T);

   procedure Test_Filtre_Crypt
      (T : in out Test_Fixt_T);

   procedure Test_Filtre_Decrypt
      (T : in out Test_Fixt_T);

   procedure Test_Comparaison_Sequentiel_Crypt
      (T : in out Test_Fixt_T);

   procedure Test_Comparaison_Sequentiel_Decrypt
      (T : in out Test_Fixt_T);

end Des_P.Chaine_P.Taches_P.Test_P;
