with Ada.Directories;

package body Des_P.Chaine_P.Ecriveur_P.Fichier_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Ouvrir_Fichier
      (
         Ecriveur : in out Ecriveur_Fichier_T;
         Nom      :        String
      )
   is
   begin
      --  Ouvre le fichier pour écrire si il existe et écrase le contenu
      --  sinon il est créé.
      if Ada.Directories.Exists (Name => Nom) then
         Fichier_64_IO.Open
            (
               File => Ecriveur.Resultat,
               Mode => Fichier_64_IO.Out_File,
               Name => Nom
            );
      else
         Fichier_64_IO.Create
            (
               File => Ecriveur.Resultat,
               Mode => Fichier_64_IO.Out_File,
               Name => Nom
            );
      end if;
   end Ouvrir_Fichier;

   ---------------------------------------------------------------------------
   overriding
   procedure Ecrire
      (
         Ecriveur : in out Ecriveur_Fichier_T;
         Brut     :        C_Bloc_64_R.Bloc_64_Brut_T
      )
   is
   begin
      Fichier_64_IO.Write
         (
            File => Ecriveur.Resultat,
            Item => Brut
         );
   end Ecrire;

   ---------------------------------------------------------------------------
   overriding
   procedure Fermer_Fichier
      (Ecriveur : in out Ecriveur_Fichier_T)
   is
   begin
      Fichier_64_IO.Close (File => Ecriveur.Resultat);
   end Fermer_Fichier;

end Des_P.Chaine_P.Ecriveur_P.Fichier_P;
