with Ada.Directories;

package body Des_P.Chaine_P.Accee_Fichier_P is

   ---------------------------------------------------------------------------
   protected body Ecriveur_Fichier_Protegee is
      ---------------------------------------------------------
      procedure Ouvrir_Fichier (Nom : String) is
      begin
         --  Ouvre le fichier pour écrire si il existe et écrase le contenu
         --  sinon il est créé.
         if Ada.Directories.Exists (Nom) then
            Fichier_64_IO.Open
               (Resultat, Fichier_64_IO.Out_File, Nom);
         else
            Fichier_64_IO.Create
               (Resultat, Fichier_64_IO.Out_File, Nom);
         end if;
      end Ouvrir_Fichier;

      ---------------------------------------------------------
      procedure Ecrire
         (Brut : C_Bloc_64_P.Bloc_64_Brut_T)
      is
      begin
         Fichier_64_IO.Write (Resultat, Brut);
      end Ecrire;

      ---------------------------------------------------------
      procedure Fermer_Fichier is
      begin
         Fichier_64_IO.Close (Resultat);
      end Fermer_Fichier;
      ---------------------------------------------------------
   end Ecriveur_Fichier_Protegee;

   ---------------------------------------------------------------------------
   protected body Lecteur_Fichier_Protegee is
      ---------------------------------------------------------
      procedure Ouvrir_Fichier (Nom : String) is
      begin
         Fichier_64_IO.Open (Fichier, Fichier_64_IO.In_File, Nom);
      end Ouvrir_Fichier;

      ---------------------------------------------------------
      procedure Lire (Brut : out C_Bloc_64_P.Bloc_64_Brut_T)
      is
      begin
         Fichier_64_IO.Read (Fichier, Brut);
      end Lire;

      ---------------------------------------------------------
      function Est_Fini
         return Boolean
      is
      begin
         return Fichier_64_IO.End_Of_File (Fichier);
      end Est_Fini;

      ---------------------------------------------------------
      procedure Fermer_Fichier is
      begin
         Fichier_64_IO.Close (Fichier);
      end Fermer_Fichier;
      ---------------------------------------------------------
   end Lecteur_Fichier_Protegee;

end Des_P.Chaine_P.Accee_Fichier_P;
