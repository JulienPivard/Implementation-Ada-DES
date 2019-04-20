with Ada.Sequential_IO;
--  Interdit l'utilisation de preelaborate.

--  @summary
--  Accède en lecture à un fichier.
--  @description
--  Gestion de la lecture dans les fichiers. Se charge
--  de centraliser la lecture dans les fichiers.
--  @group Lecteur
package Des_P.Chaine_P.Lecteur_P.Fichier_P is

   package Fichier_64_IO is new Ada.Sequential_IO (C_Bloc_64_R.Bloc_64_Brut_T);

   type Lecteur_Fichier_T
   is limited new Lecteur_T with private;
   --  Lit un bloc de données dans le fichier.

   overriding
   procedure Ouvrir_Fichier
      (
         Lecteur  : in out Lecteur_Fichier_T;
         Nom      : String
      );
   --  Ouvre le fichier.
   --  @param Lecteur
   --  Le lecteur de données.
   --  @param Nom
   --  Le nom du fichier à ouvrir.

   overriding
   procedure Lire
      (
         Lecteur  : in out Lecteur_Fichier_T;
         Brut     : out C_Bloc_64_R.Bloc_64_Brut_T
      )
      with Inline;
   --  Lit la donnée dans le fichier.
   --  @param Lecteur
   --  Le lecteur de données.
   --  @param Brut
   --  La donnée lu dans le fichier.

   overriding
   function Est_Fini
      (Lecteur : Lecteur_Fichier_T)
      return Boolean
      with Inline;
   --  Permet de savoir si le fichier est fini de lire.
   --  @param Lecteur
   --  Le lecteur de données.
   --  @return
   --  Le fichier est fini de lire.

   overriding
   procedure Fermer_Fichier
      (Lecteur : in out Lecteur_Fichier_T);
   --  @param Lecteur
   --  Le lecteur de données.
   --  Ferme le fichier.

private

   type Lecteur_Fichier_T is limited new Lecteur_T with
      record
         Fichier : Fichier_64_IO.File_Type;
         --  Le fichier qui va etre lu bloc par bloc.
      end record;

end Des_P.Chaine_P.Lecteur_P.Fichier_P;
