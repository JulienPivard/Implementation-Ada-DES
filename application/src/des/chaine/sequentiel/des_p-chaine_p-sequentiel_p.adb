with Ada.Directories;

with Ada.Sequential_IO;

with Des_P.Bloc_P.Bloc_64_P;

package body Des_P.Chaine_P.Sequentiel_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Filtrer
      (
         Chaine : Chaine_T;
         Nom_Fichier : String;
         Extension : String
      )
   is
      package Lecteur_64_IO is new Ada.Sequential_IO
      (Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T);

      Fichier : Lecteur_64_IO.File_Type;
      Resultat : Lecteur_64_IO.File_Type;

      Brut : Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T;
      Nom_Alternatif : constant String := Nom_Fichier & "." & Extension;
   begin

      if Ada.Directories.Exists (Nom_Alternatif) then
         Lecteur_64_IO.Open
            (Resultat, Lecteur_64_IO.Out_File, Nom_Alternatif);
      else
         Lecteur_64_IO.Create
            (Resultat, Lecteur_64_IO.Out_File, Nom_Alternatif);
      end if;
      Lecteur_64_IO.Open (Fichier, Lecteur_64_IO.In_File, Nom_Fichier);

      Lecture_Fichier :
      loop
         exit Lecture_Fichier when Lecteur_64_IO.End_Of_File (Fichier);
         Lecteur_64_IO.Read (Fichier, Brut);

         Chaine.Execution (Brut);

         Lecteur_64_IO.Write (Resultat, Brut);
      end loop Lecture_Fichier;

      Lecteur_64_IO.Close (Fichier);
      pragma Unreferenced (Fichier);
      Lecteur_64_IO.Close (Resultat);
      pragma Unreferenced (Resultat);

   end Filtrer;

   ---------------------------------------------------------------------------
   procedure Execution
      (
         Chaine : Chaine_T;
         Brut : in out Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T
      )
   is
      C_64 : Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Constructeur_Bloc_64_T;
      Bloc : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
   begin
      C_64.Preparer_Nouveau_Bloc;
      C_64.Construire_Bloc (Brut);
      Bloc := C_64.Recuperer_Bloc;

      Chaine.Tete.Iterer (Bloc);

      Brut := C_64.Transformer_En_Brut (Bloc);
   end Execution;

end Des_P.Chaine_P.Sequentiel_P;
