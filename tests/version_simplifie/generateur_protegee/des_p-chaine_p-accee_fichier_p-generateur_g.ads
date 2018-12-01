generic

   Nombre_De_Blocs : Positive;

package Des_P.Chaine_P.Accee_Fichier_P.Generateur_G is

   type Reception_Blocs_T is array
      (0 .. Nombre_De_Blocs - 1)
      of C_Bloc_64_R.Bloc_64_Brut_T;

   ---------------------------------------
   protected type Ecriveur_Generateur_Protegee
   is new Ecriveur_Protegee_T with
      overriding
      procedure Ouvrir_Fichier (Nom : String);
      overriding
      procedure Ecrire (Brut : C_Bloc_64_R.Bloc_64_Brut_T);
      overriding
      procedure Fermer_Fichier;
      function Lire_Resultat return Reception_Blocs_T;
      function Lire_Nb_Bloc_Ecrit return Natural;
   private
      Resultats : Reception_Blocs_T;
      Nb_Blocs_Ecrit : Natural := 0;
   end Ecriveur_Generateur_Protegee;
   --  Écrit dans le fichier le bloc donné.

   ---------------------------------------
   protected type Lecteur_Generateur_Protegee
   is new Lecteur_Protegee_T with
      overriding
      procedure Ouvrir_Fichier (Nom : String);
      overriding
      procedure Lire (Brut : out C_Bloc_64_R.Bloc_64_Brut_T);
      overriding
      function Est_Fini return Boolean;
      overriding
      procedure Fermer_Fichier;
      procedure Changer_Brut_Genere (Brut : C_Bloc_64_R.Bloc_64_Brut_T);
      function Lire_Nb_Bloc_Lu return Natural;
   private
      Nb_Blocs_Lu : Natural := 0;
      Brut_Genere : C_Bloc_64_R.Bloc_64_Brut_T;
   end Lecteur_Generateur_Protegee;
   --  Lit un bloc de données dans le fichier.

end Des_P.Chaine_P.Accee_Fichier_P.Generateur_G;
