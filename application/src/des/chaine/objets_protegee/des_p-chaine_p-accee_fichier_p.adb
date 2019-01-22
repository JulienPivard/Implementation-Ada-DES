with Ada.Directories;

package body Des_P.Chaine_P.Accee_Fichier_P is

   ---------------------------------------------------------------------------
   ---------------------------------------------------------
   overriding
   procedure Ouvrir_Fichier
      (
         Ecriveur : in out Ecriveur_Fichier_T;
         Nom : String
      )
   is
   begin
      --  Ouvre le fichier pour écrire si il existe et écrase le contenu
      --  sinon il est créé.
      if Ada.Directories.Exists (Nom) then
         Fichier_64_IO.Open
            (Ecriveur.Resultat, Fichier_64_IO.Out_File, Nom);
      else
         Fichier_64_IO.Create
            (Ecriveur.Resultat, Fichier_64_IO.Out_File, Nom);
      end if;
   end Ouvrir_Fichier;

   ---------------------------------------------------------
   overriding
   procedure Ecrire
      (
         Ecriveur : in out Ecriveur_Fichier_T;
         Brut : C_Bloc_64_R.Bloc_64_Brut_T
      )
   is
   begin
      Fichier_64_IO.Write (Ecriveur.Resultat, Brut);
   end Ecrire;

   ---------------------------------------------------------
   overriding
   procedure Fermer_Fichier
      (Ecriveur : in out Ecriveur_Fichier_T)
   is
   begin
      Fichier_64_IO.Close (Ecriveur.Resultat);
   end Fermer_Fichier;
   ---------------------------------------------------------

   ---------------------------------------------------------------------------
   ---------------------------------------------------------
   overriding
   procedure Ouvrir_Fichier
      (
         Lecteur : in out Lecteur_Fichier_T;
         Nom : String
      )
   is
   begin
      Fichier_64_IO.Open (Lecteur.Fichier, Fichier_64_IO.In_File, Nom);
   end Ouvrir_Fichier;

   ---------------------------------------------------------
   overriding
   procedure Lire
      (
         Lecteur : in out Lecteur_Fichier_T;
         Brut : out C_Bloc_64_R.Bloc_64_Brut_T
      )
   is
   begin
      Fichier_64_IO.Read (Lecteur.Fichier, Brut);
   end Lire;

   ---------------------------------------------------------
   overriding
   function Est_Fini
      (Lecteur : Lecteur_Fichier_T)
      return Boolean
   is
   begin
      return Fichier_64_IO.End_Of_File (Lecteur.Fichier);
   end Est_Fini;

   ---------------------------------------------------------
   overriding
   procedure Fermer_Fichier
      (Lecteur : in out Lecteur_Fichier_T)
   is
   begin
      Fichier_64_IO.Close (Lecteur.Fichier);
   end Fermer_Fichier;
   ---------------------------------------------------------

end Des_P.Chaine_P.Accee_Fichier_P;
