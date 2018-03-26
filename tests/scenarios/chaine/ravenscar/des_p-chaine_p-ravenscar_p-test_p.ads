with AUnit;
with AUnit.Test_Fixtures;

with Des_P.Bloc_P.Bloc_64_P.Constructeur_P;
with Des_P.Clef_P.Clef_64_I_P.Constructeur_I_P;

with Des_P.Clef_P.Clef_64_P;

package Des_P.Chaine_P.Ravenscar_P.Test_P is

   Brut_Original : constant
   Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T :=
   2#11110000_11110000_11110000_11110000_11110000_11110000_11110000_11110000#;

   Brut_Clef : constant
   Des_P.Clef_P.Clef_64_I_P.Constructeur_I_P.Clef_64_Brut_T :=
   2#11110000_11110000_11110000_11110000_11110000_11110000_11110000_11110000#;

   Brut_Attendu : constant
   Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T :=
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

   procedure Test_Filtre_Crypt_1
      (T : in out Test_Fixt_T);

   procedure Test_Filtre_Decrypt_1
      (T : in out Test_Fixt_T);

   procedure Test_Filtre_Crypt_2048
      (T : in out Test_Fixt_T);

   procedure Test_Filtre_Decrypt_2048
      (T : in out Test_Fixt_T);

   procedure Test_Fin;

private

   Fin_Constante_Bloc : constant Natural := 2047;
   type Reception_Blocs_T is array
      (0 .. Fin_Constante_Bloc)
      of C_Bloc_64_P.Bloc_64_Brut_T;

   ---------------------------------------
   protected type Ecriveur_Generateur_Protegee
   is new Ecriveur_Protegee_T with
      overriding
      procedure Ouvrir_Fichier (Nom : String);
      overriding
      procedure Ecrire (Brut : C_Bloc_64_P.Bloc_64_Brut_T);
      overriding
      procedure Fermer_Fichier;
      procedure Remettre_A_Zero;
      function Lire_Resultat return Reception_Blocs_T;
      function Lire_Nb_Bloc_Ecrit return Natural;
   private
      Resultats : Reception_Blocs_T;
      Nb_Blocs_Ecrit : Natural := 0;
   end Ecriveur_Generateur_Protegee;
   --  Écrit dans le fichier le bloc donné.

   Ecriveur_Generateur : aliased Ecriveur_Generateur_Protegee;
   --  Un écriveur de fichier classique.

   ---------------------------------------
   protected type Lecteur_Generateur_Protegee
   is new Lecteur_Protegee_T with
      overriding
      procedure Ouvrir_Fichier (Nom : String);
      overriding
      procedure Lire (Brut : out C_Bloc_64_P.Bloc_64_Brut_T);
      overriding
      function Est_Fini return Boolean;
      overriding
      procedure Fermer_Fichier;
      procedure Remettre_A_Zero;
      procedure Changer_Brut_Genere (Brut : C_Bloc_64_P.Bloc_64_Brut_T);
      procedure Changer_Max_Genere (Max : Natural);
      function Lire_Nb_Bloc_Lu return Natural;
   private
      Nb_Blocs_Lu : Natural := 0;
      Brut_Genere : C_Bloc_64_P.Bloc_64_Brut_T;
      Max_Blocs : Natural := Fin_Constante_Bloc;
   end Lecteur_Generateur_Protegee;
   --  Lit un bloc de données dans le fichier.

   Lecteur_Generateur : aliased Lecteur_Generateur_Protegee;
   --  Un lecteur de fichier classique.

end Des_P.Chaine_P.Ravenscar_P.Test_P;
