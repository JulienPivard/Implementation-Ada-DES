generic

   Nombre_De_Blocs : Positive;

package Des_P.Chaine_P.Accee_Fichier_P.Generateur_G is

   type Reception_Blocs_T is array
      (0 .. Nombre_De_Blocs - 1)
      of C_Bloc_64_R.Bloc_64_Brut_T;

   ---------------------------------------
   type Ecriveur_Generateur_Protegee
   is limited new Ecriveur_Protegee_T with private;
   --  Écrit dans le fichier le bloc donné.

   overriding
   procedure Ouvrir_Fichier
      (
         Ecriveur : in out Ecriveur_Generateur_Protegee;
         Nom : String
      );

   overriding
   procedure Ecrire
      (
         Ecriveur : in out Ecriveur_Generateur_Protegee;
         Brut : C_Bloc_64_R.Bloc_64_Brut_T
      );

   overriding
   procedure Fermer_Fichier
      (Ecriveur : in out Ecriveur_Generateur_Protegee);

   function Lire_Resultat
      (Ecriveur : Ecriveur_Generateur_Protegee)
      return Reception_Blocs_T;

   function Lire_Nb_Bloc_Ecrit
      (Ecriveur : Ecriveur_Generateur_Protegee)
      return Natural;

   ---------------------------------------
   type Lecteur_Generateur_Protegee
   is limited new Lecteur_Protegee_T with private;
   --  Lit un bloc de données dans le fichier.

   overriding
   procedure Ouvrir_Fichier
      (
         Lecteur : in out Lecteur_Generateur_Protegee;
         Nom : String
      );

   overriding
   procedure Lire
      (
         Lecteur : in out Lecteur_Generateur_Protegee;
         Brut : out C_Bloc_64_R.Bloc_64_Brut_T
      );

   overriding
   function Est_Fini
      (Lecteur : Lecteur_Generateur_Protegee)
      return Boolean;

   overriding
   procedure Fermer_Fichier
      (Lecteur : in out Lecteur_Generateur_Protegee);

   procedure Changer_Brut_Genere
      (
         Lecteur : in out Lecteur_Generateur_Protegee;
         Brut : C_Bloc_64_R.Bloc_64_Brut_T
      );

   function Lire_Nb_Bloc_Lu
      (Lecteur : Lecteur_Generateur_Protegee)
      return Natural;

private

   type Ecriveur_Generateur_Protegee
   is limited new Ecriveur_Protegee_T with
      record
         Resultats : Reception_Blocs_T;
         Nb_Blocs_Ecrit : Natural := 0;
      end record;

   type Lecteur_Generateur_Protegee
   is limited new Lecteur_Protegee_T with
      record
         Nb_Blocs_Lu : Natural := 0;
         Brut_Genere : C_Bloc_64_R.Bloc_64_Brut_T;
      end record;

end Des_P.Chaine_P.Accee_Fichier_P.Generateur_G;
