with Des_P.Bloc_P.Bloc_64_P.Faiseur_P;

--  @summary
--  Point d'accès au flux de sortie.
--  @description
--  Gestion de l'écriture dans les fichiers ou objets. Se charge
--  de centraliser les écritures.
--  @group Écriveur
package Des_P.Chaine_P.Ecriveur_P
   with Pure
is

   package C_Bloc_64_R renames Des_P.Bloc_P.Bloc_64_P.Faiseur_P;

   type Ecriveur_T is limited interface;
   --  Un écriveur de donnée. Nécessaire pour centraliser.

   --  Interdit l'utilisation du pragma Pure.
   type Ecriveur_A is not null access all Ecriveur_T'Class
      with Storage_Size => 0;
   --  Pointeur sur un écriveur.

   procedure Ouvrir_Fichier
      (
         Ecriveur : in out Ecriveur_T;
         Nom      :        String
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
         Brut     :        C_Bloc_64_R.Bloc_64_Brut_T
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

end Des_P.Chaine_P.Ecriveur_P;
