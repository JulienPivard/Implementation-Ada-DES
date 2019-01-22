with Ada.Sequential_IO;
with Des_P.Bloc_P.Bloc_64_P.Faiseur_P;

--  @summary
--  Accès aux fichiers.
--  @description
--  Gestion de la lecture et de l'écriture dans les fichiers. Se charge
--  d'éviter les écritures multiple dans le fichier de sortie.
--  @group Objets Protégé
package Des_P.Chaine_P.Accee_Fichier_P is

   package C_Bloc_64_R renames Des_P.Bloc_P.Bloc_64_P.Faiseur_P;
   package Fichier_64_IO is new Ada.Sequential_IO (C_Bloc_64_R.Bloc_64_Brut_T);

   ---------------------------------------------------------------------------

   type Ecriveur_T is limited interface;
   --  Un écriveur de donnée protégée. Nécessaire à cause
   --  de son utilisation dans des taches.

   type Ecriveur_A is not null access all Ecriveur_T'Class;
   --  Pointeur sur un écriveur protégé.

   procedure Ouvrir_Fichier
      (
         Ecriveur : in out Ecriveur_T;
         Nom : String
      )
   is abstract;
   --  Ouvre le fichier.
   --  @param Ecriveur
   --  L'écriveur de données.
   --  @param Nom
   --  Le nom du fichier à ouvrir.

   procedure Ecrire
      (
         Ecriveur : in out Ecriveur_T;
         Brut : C_Bloc_64_R.Bloc_64_Brut_T
      )
   is abstract;
   --  Écrit la donnée dans le fichier.
   --  @param Ecriveur
   --  L'écriveur de données.
   --  @param Brut
   --  La donnée à écrire dans le fichier.

   procedure Fermer_Fichier
      (Ecriveur : in out Ecriveur_T)
   is abstract;
   --  Ferme le fichier.
   --  @param Ecriveur
   --  L'écriveur de données.

   ---------------------------------------------------------------------------

   type Lecteur_T is limited interface;
   --  Un lecteur de donnée protégée. Nécessaire à cause
   --  de son utilisation dans des taches.

   type Lecteur_A is not null access all Lecteur_T'Class;
   --  Pointeur sur un lecteur protégé.

   procedure Ouvrir_Fichier
      (
         Lecteur : in out Lecteur_T;
         Nom : String
      )
   is abstract;
   --  Ouvre le fichier.
   --  @param Lecteur
   --  Le lecteur de données.
   --  @param Nom
   --  Le nom du fichier à ouvrir.

   procedure Lire
      (
         Lecteur : in out Lecteur_T;
         Brut : out C_Bloc_64_R.Bloc_64_Brut_T
      )
   is abstract;
   --  Lit la donnée dans le fichier.
   --  @param Lecteur
   --  Le lecteur de données.
   --  @param Brut
   --  La donnée lu dans le fichier.

   function Est_Fini
      (Lecteur : Lecteur_T)
      return Boolean
   is abstract;
   --  Permet de savoir si le fichier est fini de lire.
   --  @param Lecteur
   --  Le lecteur de données.
   --  @return
   --  Le fichier est fini de lire.

   procedure Fermer_Fichier
      (Lecteur : in out Lecteur_T)
   is abstract;
   --  Ferme le fichier.
   --  @param Lecteur
   --  Le lecteur de données.

   ---------------------------------------

   type Ecriveur_Fichier_T
   is limited new Ecriveur_T with private;
   --  Écrit dans le fichier le bloc donné.

   overriding
   procedure Ouvrir_Fichier
      (
         Ecriveur : in out Ecriveur_Fichier_T;
         Nom : String
      );
   --  Ouvre le fichier.
   --  @param Ecriveur
   --  L'écriveur de données.
   --  @param Nom
   --  Le nom du fichier à ouvrir.

   overriding
   procedure Ecrire
      (
         Ecriveur : in out Ecriveur_Fichier_T;
         Brut : C_Bloc_64_R.Bloc_64_Brut_T
      )
      with Inline;
   --  Écrit la donnée dans le fichier.
   --  @param Ecriveur
   --  L'écriveur de données.
   --  @param Brut
   --  La donnée à écrire dans le fichier.

   overriding
   procedure Fermer_Fichier
      (Ecriveur : in out Ecriveur_Fichier_T);
   --  Ferme le fichier.
   --  @param Ecriveur
   --  L'écriveur de données.

   ---------------------------------------

   type Lecteur_Fichier_T
   is limited new Lecteur_T with private;
   --  Lit un bloc de données dans le fichier.

   overriding
   procedure Ouvrir_Fichier
      (
         Lecteur : in out Lecteur_Fichier_T;
         Nom : String
      );
   --  Ouvre le fichier.
   --  @param Lecteur
   --  Le lecteur de données.
   --  @param Nom
   --  Le nom du fichier à ouvrir.

   overriding
   procedure Lire
      (
         Lecteur : in out Lecteur_Fichier_T;
         Brut : out C_Bloc_64_R.Bloc_64_Brut_T
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

   type Ecriveur_Fichier_T is limited new Ecriveur_T with
      record
         Resultat : Fichier_64_IO.File_Type;
      end record;

   type Lecteur_Fichier_T is limited new Lecteur_T with
      record
         Fichier : Fichier_64_IO.File_Type;
      end record;

end Des_P.Chaine_P.Accee_Fichier_P;
