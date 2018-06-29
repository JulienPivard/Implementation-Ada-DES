package body Des_P.Chaine_P.Accee_Fichier_P.Generateur_G is

   ---------------------------------------------------------------------------
   protected body Ecriveur_Generateur_Protegee is
      ---------------------------------------------------------
      procedure Ouvrir_Fichier (Nom : String) is
      begin
         pragma Unreferenced (Nom);
         Nb_Blocs_Ecrit := Natural'First;
      end Ouvrir_Fichier;

      ---------------------------------------------------------
      procedure Ecrire
         (Brut : C_Bloc_64_P.Bloc_64_Brut_T)
      is
      begin
         Resultats (Nb_Blocs_Ecrit) := Brut;
         Nb_Blocs_Ecrit := Natural'Succ (Nb_Blocs_Ecrit);
      end Ecrire;

      ---------------------------------------------------------
      procedure Fermer_Fichier is
      begin
         null;
      end Fermer_Fichier;

      ---------------------------------------------------------
      function Lire_Resultat return Reception_Blocs_T is
      begin
         return Resultats;
      end Lire_Resultat;

      ---------------------------------------------------------
      function Lire_Nb_Bloc_Ecrit return Natural is
      begin
         return Nb_Blocs_Ecrit;
      end Lire_Nb_Bloc_Ecrit;
      ---------------------------------------------------------
   end Ecriveur_Generateur_Protegee;

   ---------------------------------------------------------------------------
   protected body Lecteur_Generateur_Protegee is
      ---------------------------------------------------------
      procedure Ouvrir_Fichier (Nom : String) is
      begin
         pragma Unreferenced (Nom);
         Nb_Blocs_Lu := Natural'First;
      end Ouvrir_Fichier;

      ---------------------------------------------------------
      procedure Lire
         (Brut : out C_Bloc_64_P.Bloc_64_Brut_T)
      is
      begin
         Nb_Blocs_Lu := Natural'Succ (Nb_Blocs_Lu);
         Brut := Brut_Genere;
      end Lire;

      ---------------------------------------------------------
      function Est_Fini
         return Boolean
      is
      begin
         return Nb_Blocs_Lu >= Nombre_De_Blocs;
      end Est_Fini;

      ---------------------------------------------------------
      procedure Fermer_Fichier is
      begin
         null;
      end Fermer_Fichier;

      ---------------------------------------------------------
      procedure Changer_Brut_Genere
         (Brut : C_Bloc_64_P.Bloc_64_Brut_T)
      is
      begin
         Brut_Genere := Brut;
      end Changer_Brut_Genere;

      ---------------------------------------------------------
      function Lire_Nb_Bloc_Lu return Natural is
      begin
         return Nb_Blocs_Lu;
      end Lire_Nb_Bloc_Lu;
      ---------------------------------------------------------
   end Lecteur_Generateur_Protegee;

end Des_P.Chaine_P.Accee_Fichier_P.Generateur_G;
