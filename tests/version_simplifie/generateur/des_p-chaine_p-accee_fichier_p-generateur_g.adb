package body Des_P.Chaine_P.Accee_Fichier_P.Generateur_G is

   ---------------------------------------------------------------------------
   ---------------------------------------------------------
   overriding
   procedure Ouvrir_Fichier
      (
         Ecriveur : in out Ecriveur_Generateur_Protegee;
         Nom : String
      )
   is
   begin
      pragma Unreferenced (Nom);
      Ecriveur.Nb_Blocs_Ecrit := Natural'First;
   end Ouvrir_Fichier;

   ---------------------------------------------------------
   overriding
   procedure Ecrire
      (
         Ecriveur : in out Ecriveur_Generateur_Protegee;
         Brut : C_Bloc_64_R.Bloc_64_Brut_T
      )
   is
   begin
      Ecriveur.Resultats (Ecriveur.Nb_Blocs_Ecrit) := Brut;
      Ecriveur.Nb_Blocs_Ecrit := Natural'Succ (Ecriveur.Nb_Blocs_Ecrit);
   end Ecrire;

   ---------------------------------------------------------
   overriding
   procedure Fermer_Fichier
      (Ecriveur : in out Ecriveur_Generateur_Protegee)
   is
   begin
      null;
   end Fermer_Fichier;

   ---------------------------------------------------------
   function Lire_Resultat
      (Ecriveur : Ecriveur_Generateur_Protegee)
      return Reception_Blocs_T
   is
   begin
      return Ecriveur.Resultats;
   end Lire_Resultat;

   ---------------------------------------------------------
   function Lire_Nb_Bloc_Ecrit
      (Ecriveur : Ecriveur_Generateur_Protegee)
      return Natural
   is
   begin
      return Ecriveur.Nb_Blocs_Ecrit;
   end Lire_Nb_Bloc_Ecrit;
   ---------------------------------------------------------

   ---------------------------------------------------------------------------
   ---------------------------------------------------------
   overriding
   procedure Ouvrir_Fichier
      (
         Lecteur : in out Lecteur_Generateur_Protegee;
         Nom : String
      )
   is
   begin
      pragma Unreferenced (Nom);
      Lecteur.Nb_Blocs_Lu := Natural'First;
   end Ouvrir_Fichier;

   ---------------------------------------------------------
   overriding
   procedure Lire
      (
         Lecteur : in out Lecteur_Generateur_Protegee;
         Brut : out C_Bloc_64_R.Bloc_64_Brut_T
      )
   is
   begin
      Lecteur.Nb_Blocs_Lu := Natural'Succ (Lecteur.Nb_Blocs_Lu);
      Brut := Lecteur.Brut_Genere;
   end Lire;

   ---------------------------------------------------------
   overriding
   function Est_Fini
      (Lecteur : Lecteur_Generateur_Protegee)
      return Boolean
   is
   begin
      return Lecteur.Nb_Blocs_Lu >= Nombre_De_Blocs;
   end Est_Fini;

   ---------------------------------------------------------
   overriding
   procedure Fermer_Fichier
      (Lecteur : in out Lecteur_Generateur_Protegee)
   is
   begin
      null;
   end Fermer_Fichier;

   ---------------------------------------------------------
   procedure Changer_Brut_Genere
      (
         Lecteur : in out Lecteur_Generateur_Protegee;
         Brut : C_Bloc_64_R.Bloc_64_Brut_T
      )
   is
   begin
      Lecteur.Brut_Genere := Brut;
   end Changer_Brut_Genere;

   ---------------------------------------------------------
   function Lire_Nb_Bloc_Lu
      (Lecteur : Lecteur_Generateur_Protegee)
      return Natural
   is
   begin
      return Lecteur.Nb_Blocs_Lu;
   end Lire_Nb_Bloc_Lu;
   ---------------------------------------------------------

end Des_P.Chaine_P.Accee_Fichier_P.Generateur_G;
