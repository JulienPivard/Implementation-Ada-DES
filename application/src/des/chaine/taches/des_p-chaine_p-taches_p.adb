with Ada.Directories;

with Ada.Sequential_IO;

with Des_P.Bloc_P.Bloc_64_P;
with Des_P.Bloc_P.Bloc_64_P.Constructeur_P;

package body Des_P.Chaine_P.Taches_P is

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

      Fichier : Lecteur_64_IO.File_Type;
      Resultat : Lecteur_64_IO.File_Type;

      --  (=v.v=)(=^.^=)(=o.o=)(=O.o=)(=o.O=)(=O.O=)(=$.$=)(=*.*=)  --
      procedure Lanceur_Taches;

      procedure Lanceur_Taches is
         --  (=v.v=)(=^.^=)(=o.o=)(=O.o=)(=o.O=)(=O.O=)(=$.$=)(=*.*=)  --
         task Etage_Sortie is
            entry Ecrire
               (
                  Bloc : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T
               );
         end Etage_Sortie;

         task body Etage_Sortie is
            B_Tmp : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
            C_64 : C_Bloc_64_P.Constructeur_Bloc_64_T;
            Occupe : Boolean := False;
         begin
            loop
               select
                  when not Occupe =>
                  accept Ecrire
                     (
                        Bloc : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T
                     )
                  do
                     Occupe := True;
                     B_Tmp := Bloc;
                  end Ecrire;
               or
                  terminate;
               end select;

               declare
                  Brut : constant C_Bloc_64_P.Bloc_64_Brut_T
                     := C_64.Transformer_En_Brut (B_Tmp);
               begin
                  Lecteur_64_IO.Write (Resultat, Brut);
               end;
               Occupe := False;
            end loop;
         end Etage_Sortie;
         --  (=v.v=)(=^.^=)(=o.o=)(=O.o=)(=o.O=)(=O.O=)(=$.$=)(=*.*=)  --

         --  (=v.v=)(=^.^=)(=o.o=)(=O.o=)(=o.O=)(=O.O=)(=$.$=)(=*.*=)  --
         task Etage_Utile is
            entry Filtrer
               (
                  Bloc : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T
               );
         end Etage_Utile;

         task body Etage_Utile is
            B_Tmp : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
         begin
            accept Filtrer
               (
                  Bloc : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T
               )
            do
               B_Tmp := Bloc;
            end Filtrer;
            --  Ajouter filtre ici.
         end Etage_Utile;
         --  (=v.v=)(=^.^=)(=o.o=)(=O.o=)(=o.O=)(=O.O=)(=$.$=)(=*.*=)  --

         C_64 : C_Bloc_64_P.Constructeur_Bloc_64_T;
         Brut : C_Bloc_64_P.Bloc_64_Brut_T;
      begin
         Lecture_Fichier :
         loop
            exit Lecture_Fichier when Lecteur_64_IO.End_Of_File (Fichier);
            Lecteur_64_IO.Read (Fichier, Brut);
            C_64.Preparer_Nouveau_Bloc;
            C_64.Construire_Bloc (Brut);
            declare
               Bloc : constant Des_P.Bloc_P.Bloc_64_P.Bloc_64_T :=
                  C_64.Recuperer_Bloc;
            begin
               Etage_Utile.Filtrer (Bloc);
            end;
         end loop Lecture_Fichier;
      end Lanceur_Taches;
      --  (=v.v=)(=^.^=)(=o.o=)(=O.o=)(=o.O=)(=O.O=)(=$.$=)(=*.*=)  --

      Brut : C_Bloc_64_P.Bloc_64_Brut_T;
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

      Lanceur_Taches;

      Lecteur_64_IO.Close (Fichier);
      pragma Unreferenced (Fichier);
      Lecteur_64_IO.Close (Resultat);
      pragma Unreferenced (Resultat);
   end Filtrer;

end Des_P.Chaine_P.Taches_P;
