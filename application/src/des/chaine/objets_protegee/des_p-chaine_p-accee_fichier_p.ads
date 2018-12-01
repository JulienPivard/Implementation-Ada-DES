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

   type Ecriveur_Protegee_T is protected interface;
   --  Un écriveur de donnée protégée. Nécessaire à cause
   --  de son utilisation dans des taches.

   procedure Ouvrir_Fichier
      (
         Ecriveur : in out Ecriveur_Protegee_T;
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
         Ecriveur : in out Ecriveur_Protegee_T;
         Brut : C_Bloc_64_R.Bloc_64_Brut_T
      )
   is abstract;
   --  Écrit la donnée dans le fichier.
   --  @param Ecriveur
   --  L'écriveur de données.
   --  @param Brut
   --  La donnée à écrire dans le fichier.

   procedure Fermer_Fichier
      (Ecriveur : in out Ecriveur_Protegee_T)
   is abstract;
   --  Ferme le fichier.
   --  @param Ecriveur
   --  L'écriveur de données.

   ---------------------------------------------------------------------------

   type Lecteur_Protegee_T is protected interface;
   --  Un lecteur de donnée protégée. Nécessaire à cause
   --  de son utilisation dans des taches.

   procedure Ouvrir_Fichier
      (
         Lecteur : in out Lecteur_Protegee_T;
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
         Lecteur : in out Lecteur_Protegee_T;
         Brut : out C_Bloc_64_R.Bloc_64_Brut_T
      )
   is abstract;
   --  Lit la donnée dans le fichier.
   --  @param Lecteur
   --  Le lecteur de données.
   --  @param Brut
   --  La donnée lu dans le fichier.

   function Est_Fini
      (Lecteur : Lecteur_Protegee_T)
      return Boolean
   is abstract;
   --  Permet de savoir si le fichier est fini de lire.
   --  @param Lecteur
   --  Le lecteur de données.
   --  @return
   --  Le fichier est fini de lire.

   procedure Fermer_Fichier
      (Lecteur : in out Lecteur_Protegee_T)
   is abstract;
   --  Ferme le fichier.
   --  @param Lecteur
   --  Le lecteur de données.

   ---------------------------------------

   protected type Ecriveur_Fichier_Protegee
   is new Ecriveur_Protegee_T with
      overriding
      procedure Ouvrir_Fichier
         (Nom : String);
      --  Ouvre le fichier.
      --  @param Nom
      --  Le nom du fichier à ouvrir.

      overriding
      procedure Ecrire
         (Brut : C_Bloc_64_R.Bloc_64_Brut_T)
         with Inline;
      --  Écrit la donnée dans le fichier.
      --  @param Brut
      --  La donnée à écrire dans le fichier.

      overriding
      procedure Fermer_Fichier;
      --  Ferme le fichier.
   private
      Resultat : Fichier_64_IO.File_Type;
   end Ecriveur_Fichier_Protegee;
   --  Écrit dans le fichier le bloc donné.

   ---------------------------------------

   protected type Lecteur_Fichier_Protegee
   is new Lecteur_Protegee_T with
      overriding
      procedure Ouvrir_Fichier
         (Nom : String);
      --  Ouvre le fichier.
      --  @param Nom
      --  Le nom du fichier à ouvrir.

      overriding
      procedure Lire
         (Brut : out C_Bloc_64_R.Bloc_64_Brut_T)
         with Inline;
      --  Lit la donnée dans le fichier.
      --  @param Brut
      --  La donnée lu dans le fichier.

      overriding
      function Est_Fini return Boolean
         with Inline;
      --  Permet de savoir si le fichier est fini de lire.
      --  @return
      --  Le fichier est fini de lire.

      overriding
      procedure Fermer_Fichier;
      --  Ferme le fichier.
   private
      Fichier : Fichier_64_IO.File_Type;
   end Lecteur_Fichier_Protegee;
   --  Lit un bloc de données dans le fichier.

end Des_P.Chaine_P.Accee_Fichier_P;
