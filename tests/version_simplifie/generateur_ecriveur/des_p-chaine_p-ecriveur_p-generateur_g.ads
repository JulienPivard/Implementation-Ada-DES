generic

   Nombre_De_Blocs : Positive;

package Des_P.Chaine_P.Ecriveur_P.Generateur_G is

   subtype Intervalle_Table_Blocs_T is Natural range 0 .. Nombre_De_Blocs - 1;

   type Reception_Blocs_T is array
      (Intervalle_Table_Blocs_T)
      of C_Bloc_64_R.Bloc_64_Brut_T;

   ---------------------------------------
   type Ecriveur_Generateur_T
   is limited new Ecriveur_T with private;
   --  Écrit dans le fichier le bloc donné.

   overriding
   procedure Ouvrir_Fichier
      (
         Ecriveur : in out Ecriveur_Generateur_T;
         Nom      : String
      );

   overriding
   procedure Ecrire
      (
         Ecriveur : in out Ecriveur_Generateur_T;
         Brut     : C_Bloc_64_R.Bloc_64_Brut_T
      );

   overriding
   procedure Fermer_Fichier
      (Ecriveur : in out Ecriveur_Generateur_T);

   function Lire_Resultat
      (Ecriveur : Ecriveur_Generateur_T)
      return Reception_Blocs_T;

   function Lire_Nb_Bloc_Ecrit
      (Ecriveur : Ecriveur_Generateur_T)
      return Natural;

private

   type Ecriveur_Generateur_T is limited new Ecriveur_T with
      record
         Resultats      : Reception_Blocs_T;
         Nb_Blocs_Ecrit : Natural := 0;
      end record;

end Des_P.Chaine_P.Ecriveur_P.Generateur_G;
