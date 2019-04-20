with Des_P.Bloc_P.Bloc_64_P.Faiseur_P;

--  @summary
--  Lit le flux d'entrée.
--  @description
--  Gestion de la lecture dans les fichiers ou objets. Se charge
--  de centraliser la lecture.
--  @group Lecteur
package Des_P.Chaine_P.Lecteur_P is

   package C_Bloc_64_R renames Des_P.Bloc_P.Bloc_64_P.Faiseur_P;

   type Lecteur_T is limited interface;
   --  Un lecteur de donnée. Nécessaire pour centraliser.

   type Lecteur_A is not null access all Lecteur_T'Class;
   --  Pointeur sur un lecteur.

   procedure Ouvrir_Fichier
      (
         Lecteur  : in out Lecteur_T;
         Nom      : String
      )
   is abstract;
   --  Ouvre le fichier.
   --  @param Lecteur
   --  Le lecteur de données.
   --  @param Nom
   --  Le nom du fichier à ouvrir.

   procedure Lire
      (
         Lecteur  : in out Lecteur_T;
         Brut     : out C_Bloc_64_R.Bloc_64_Brut_T
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

end Des_P.Chaine_P.Lecteur_P;
