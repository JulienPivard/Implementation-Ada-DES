--  @summary
--  Accède en écriture à un fichier.
--  @description
--  Gestion de l'écriture dans les fichiers. Se charge
--  d'éviter les écritures multiple dans le fichier de sortie.
--  @group Écriveur
package Des_P.Chaine_P.Ecriveur_P.Fichier_P is

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

private

   type Ecriveur_Fichier_T is limited new Ecriveur_T with
      record
         Resultat : Fichier_64_IO.File_Type;
      end record;

end Des_P.Chaine_P.Ecriveur_P.Fichier_P;
