package body Des_P.Chaine_P.Lecteur_P.Generateur_G is

   ---------------------------------------------------------------------------
   overriding
   procedure Ouvrir_Fichier
      (
         Lecteur : in out Lecteur_Generateur_T;
         Nom     : String
      )
   is
   begin
      pragma Unreferenced (Nom);
      Lecteur.Nb_Blocs_Lu := Natural'First;
   end Ouvrir_Fichier;

   ---------------------------------------------------------------------------
   overriding
   procedure Lire
      (
         Lecteur : in out Lecteur_Generateur_T;
         Brut    : out C_Bloc_64_R.Bloc_64_Brut_T
      )
   is
   begin
      Lecteur.Nb_Blocs_Lu := Natural'Succ (Lecteur.Nb_Blocs_Lu);
      Brut := Lecteur.Brut_Genere;
   end Lire;

   ---------------------------------------------------------------------------
   overriding
   function Est_Fini
      (Lecteur : Lecteur_Generateur_T)
      return Boolean
   is
   begin
      return Lecteur.Nb_Blocs_Lu >= Nombre_De_Blocs;
   end Est_Fini;

   ---------------------------------------------------------------------------
   overriding
   procedure Fermer_Fichier
      (Lecteur : in out Lecteur_Generateur_T)
   is
   begin
      null;
   end Fermer_Fichier;

   ---------------------------------------------------------------------------
   procedure Changer_Brut_Genere
      (
         Lecteur : in out Lecteur_Generateur_T;
         Brut    : C_Bloc_64_R.Bloc_64_Brut_T
      )
   is
   begin
      Lecteur.Brut_Genere := Brut;
   end Changer_Brut_Genere;

   ---------------------------------------------------------------------------
   function Lire_Nb_Bloc_Lu
      (Lecteur : Lecteur_Generateur_T)
      return Natural
   is
   begin
      return Lecteur.Nb_Blocs_Lu;
   end Lire_Nb_Bloc_Lu;

end Des_P.Chaine_P.Lecteur_P.Generateur_G;
