with AUnit;
with AUnit.Test_Fixtures;

with Des_P.Bloc_P.Bloc_64_P.Faiseur_P;
with Des_P.Clef_P.Clef_64_I_P.Faiseur_I_P;

with Des_P.Clef_P.Clef_64_P;

private with Des_P.Chaine_P.Accee_Fichier_P.Generateur_1_P;
private with Des_P.Chaine_P.Accee_Fichier_P.Generateur_2048_P;

package Des_P.Chaine_P.Taches_P.Test_P is

   Brut_Original : constant
   Des_P.Bloc_P.Bloc_64_P.Faiseur_P.Bloc_64_Brut_T :=
   2#11110000_11110000_11110000_11110000_11110000_11110000_11110000_11110000#;

   Brut_Clef : constant
   Des_P.Clef_P.Clef_64_I_P.Faiseur_I_P.Clef_64_Brut_T :=
   2#11110000_11110000_11110000_11110000_11110000_11110000_11110000_11110000#;

   Brut_Attendu : constant
   Des_P.Bloc_P.Bloc_64_P.Faiseur_P.Bloc_64_Brut_T :=
      15799177843826553255;

   Nom_Fichier : constant String := "fichier_taches.test";
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

private

   package Accee_1_G_P renames
      Des_P.Chaine_P.Accee_Fichier_P.Generateur_1_P;
   package Accee_2048_G_P renames
      Des_P.Chaine_P.Accee_Fichier_P.Generateur_2048_P;

   Lecteur_1_Generateur : aliased Accee_1_G_P.Lecteur_Generateur_Protegee;
   Lecteur_2048_Generateur : aliased
      Accee_2048_G_P.Lecteur_Generateur_Protegee;
   --  Un lecteur de fichier classique.

   Ecriveur_1_Generateur : aliased Accee_1_G_P.Ecriveur_Generateur_Protegee;
   Ecriveur_2048_Generateur : aliased
      Accee_2048_G_P.Ecriveur_Generateur_Protegee;
   --  Un écriveur de fichier classique.

end Des_P.Chaine_P.Taches_P.Test_P;
