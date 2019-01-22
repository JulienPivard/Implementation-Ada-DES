package body Des_P.Chaine_P.Ecriveur_P.Generateur_G is

   ---------------------------------------------------------------------------
   overriding
   procedure Ouvrir_Fichier
      (
         Ecriveur : in out Ecriveur_Generateur_T;
         Nom      : String
      )
   is
   begin
      pragma Unreferenced (Nom);
      Ecriveur.Nb_Blocs_Ecrit := Natural'First;
   end Ouvrir_Fichier;

   ---------------------------------------------------------------------------
   overriding
   procedure Ecrire
      (
         Ecriveur : in out Ecriveur_Generateur_T;
         Brut     : C_Bloc_64_R.Bloc_64_Brut_T
      )
   is
   begin
      Ecriveur.Resultats (Ecriveur.Nb_Blocs_Ecrit) := Brut;
      Ecriveur.Nb_Blocs_Ecrit := Natural'Succ (Ecriveur.Nb_Blocs_Ecrit);
   end Ecrire;

   ---------------------------------------------------------------------------
   overriding
   procedure Fermer_Fichier
      (Ecriveur : in out Ecriveur_Generateur_T)
   is
   begin
      null;
   end Fermer_Fichier;

   ---------------------------------------------------------------------------
   function Lire_Resultat
      (Ecriveur : Ecriveur_Generateur_T)
      return Reception_Blocs_T
   is
   begin
      return Ecriveur.Resultats;
   end Lire_Resultat;

   ---------------------------------------------------------------------------
   function Lire_Nb_Bloc_Ecrit
      (Ecriveur : Ecriveur_Generateur_T)
      return Natural
   is
   begin
      return Ecriveur.Nb_Blocs_Ecrit;
   end Lire_Nb_Bloc_Ecrit;

end Des_P.Chaine_P.Ecriveur_P.Generateur_G;
