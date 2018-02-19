--  with Ada.Directories;

with Ada.Sequential_IO;

with Des_P.Bloc_P.Bloc_64_P;
with Des_P.Bloc_P.Bloc_64_P.Constructeur_P;
with Des_P.Clef_P.Clef_56_Abs_P;

package body Des_P.Chaine_P.Sequentiel_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Initiliser
      (
         Chaine : in out Chaine_T;
         Fabrique : Des_P.Filtre_P.Fabrique_P.Fabrique_Interface_T'Class;
         Clef : Des_P.Clef_P.Clef_64_Abs_P.Clef_64_Abs_T'Class
      )
   is
      pragma Unreferenced (Fabrique);
   begin
      Chaine.Clef := Des_P.Clef_P.Clef_56_Abs_P.Holder_P.To_Holder
         (Clef.Lire_Clef_56);
   end Initiliser;

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

      C_64 : Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Constructeur_Bloc_64_T;
      Brut : Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Bloc_64_Brut_T;
      Bloc : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
      Clef : Des_P.Clef_P.Clef_56_Abs_P.Clef_56_Abs_T'Class :=
         Chaine.Clef.Element;
   begin

      Lecteur_64_IO.Open (Fichier, Lecteur_64_IO.In_File, Nom_Fichier);
      Lecteur_64_IO.Open
         (Resultat, Lecteur_64_IO.Out_File, Nom_Fichier & "." & Extension);

      Lecture_Fichier :
      loop
         exit Lecture_Fichier when Lecteur_64_IO.End_Of_File (Fichier);
         Lecteur_64_IO.Read (Fichier, Brut);

         C_64.Preparer_Nouveau_Bloc;
         C_64.Construire_Bloc (Brut);
         Bloc := C_64.Recuperer_Bloc;

         Chaine.Tete.Filtrer (Bloc, Clef);

         Brut := C_64.Transformer_En_Brut (Bloc);

         Lecteur_64_IO.Write (Resultat, Brut);
      end loop Lecture_Fichier;

      Lecteur_64_IO.Close (Resultat);
      pragma Unreferenced (Resultat);
      Lecteur_64_IO.Close (Fichier);
      pragma Unreferenced (Fichier);

   end Filtrer;

end Des_P.Chaine_P.Sequentiel_P;
