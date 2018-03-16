with Ada.Directories;

with Ada.Sequential_IO;

with Des_P.Bloc_P.Bloc_64_P.Constructeur_P;

package body Des_P.Chaine_P.Ravenscar_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Filtrer
      (
         Chaine : Chaine_T;
         Nom_Fichier : String;
         Extension : String
      )
   is
      package C_Bloc_64_P renames Des_P.Bloc_P.Bloc_64_P.Constructeur_P;
      package Lecteur_64_IO is new Ada.Sequential_IO
         (C_Bloc_64_P.Bloc_64_Brut_T);

      --  Les fichiers à lire et à écrire.
      Fichier : Lecteur_64_IO.File_Type;
      Resultat : Lecteur_64_IO.File_Type;

      Nom_Alternatif : constant String := Nom_Fichier & "." & Extension;
      pragma Unreferenced (Chaine);
   begin
      --  Ouvre le fichier pour écrire si il existe et écrase le contenu
      --  sinon il est créé.
      if Ada.Directories.Exists (Nom_Alternatif) then
         Lecteur_64_IO.Open
            (Resultat, Lecteur_64_IO.Out_File, Nom_Alternatif);
      else
         Lecteur_64_IO.Create
            (Resultat, Lecteur_64_IO.Out_File, Nom_Alternatif);
      end if;
      --  Ouverture du fichier à lire.
      Lecteur_64_IO.Open (Fichier, Lecteur_64_IO.In_File, Nom_Fichier);

      Demarreur_Protegee.Demarrer;

      Lecteur_64_IO.Close (Fichier);
      pragma Unreferenced (Fichier);
      Lecteur_64_IO.Close (Resultat);
      pragma Unreferenced (Resultat);
   end Filtrer;

   ---------------------------------------------------------------------------
   protected body Demarreur_Protegee is
      ---------------------------------------------------------
      entry Attendre when Signal is
      begin
         null;
      end Attendre;

      ---------------------------------------------------------
      procedure Demarrer is
      begin
         Signal := True;
      end Demarrer;
   end Demarreur_Protegee;

end Des_P.Chaine_P.Ravenscar_P;
