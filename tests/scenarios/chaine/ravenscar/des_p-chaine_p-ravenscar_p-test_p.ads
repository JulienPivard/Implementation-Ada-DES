with AUnit;
with AUnit.Test_Fixtures;

with Des_P.Bloc_P.Bloc_64_P.Faiseur_P;
with Des_P.Clef_P.Clef_64_I_P.Faiseur_I_P;

with Des_P.Clef_P.Clef_64_P;

private with Des_P.Chaine_P.Accee_Fichier_P.Generateur_P;

package Des_P.Chaine_P.Ravenscar_P.Test_P is

   Brut_Original : constant
   Des_P.Bloc_P.Bloc_64_P.Faiseur_P.Bloc_64_Brut_T :=
   2#11110000_11110000_11110000_11110000_11110000_11110000_11110000_11110000#;

   Brut_Clef : constant
   Des_P.Clef_P.Clef_64_I_P.Faiseur_I_P.Clef_64_Brut_T :=
   2#11110000_11110000_11110000_11110000_11110000_11110000_11110000_11110000#;

   Brut_Attendu : constant
   Des_P.Bloc_P.Bloc_64_P.Faiseur_P.Bloc_64_Brut_T :=
      15799177843826553255;

   Nom_Fichier : constant String := "fichier_ravenscar.test";
   Extension : constant String := "chiffre";
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

   procedure Test_Filtre_Chiffre_1
      (T : in out Test_Fixt_T);

   procedure Test_Filtre_Dechiff_1
      (T : in out Test_Fixt_T);

   procedure Test_Filtre_Chiffre_2048
      (T : in out Test_Fixt_T);

   procedure Test_Filtre_Dechiff_2048
      (T : in out Test_Fixt_T);

   procedure Test_Fin;

private

   package Accee_G_P renames Des_P.Chaine_P.Accee_Fichier_P.Generateur_P;

   Lecteur_Generateur : aliased Accee_G_P.Lecteur_Generateur_Protegee;
   --  Un lecteur de fichier classique.

   Ecriveur_Generateur : aliased Accee_G_P.Ecriveur_Generateur_Protegee;
   --  Un écriveur de fichier classique.

end Des_P.Chaine_P.Ravenscar_P.Test_P;
