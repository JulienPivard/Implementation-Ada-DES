generic

   Nombre_De_Blocs : Positive;

package Des_P.Chaine_P.Lecteur_P.Generateur_G is

   type Reception_Blocs_T is array
      (0 .. Nombre_De_Blocs - 1)
      of C_Bloc_64_R.Bloc_64_Brut_T;

   ---------------------------------------
   type Lecteur_Generateur_T
   is limited new Lecteur_T with private;
   --  Lit un bloc de données dans le fichier.

   overriding
   procedure Ouvrir_Fichier
      (
         Lecteur : in out Lecteur_Generateur_T;
         Nom     : String
      );

   overriding
   procedure Lire
      (
         Lecteur : in out Lecteur_Generateur_T;
         Brut    : out C_Bloc_64_R.Bloc_64_Brut_T
      );

   overriding
   function Est_Fini
      (Lecteur : Lecteur_Generateur_T)
      return Boolean;

   overriding
   procedure Fermer_Fichier
      (Lecteur : in out Lecteur_Generateur_T);

   procedure Changer_Brut_Genere
      (
         Lecteur : in out Lecteur_Generateur_T;
         Brut    : C_Bloc_64_R.Bloc_64_Brut_T
      );

   function Lire_Nb_Bloc_Lu
      (Lecteur : Lecteur_Generateur_T)
      return Natural;

private

   type Lecteur_Generateur_T is limited new Lecteur_T with
      record
         Nb_Blocs_Lu : Natural := 0;
         Brut_Genere : C_Bloc_64_R.Bloc_64_Brut_T;
      end record;

end Des_P.Chaine_P.Lecteur_P.Generateur_G;
