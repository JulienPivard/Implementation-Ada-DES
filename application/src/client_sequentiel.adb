------------------------------------------------------------------------------
--                                                                          --
--                          Auteur : PIVARD Julien                          --
--           Dernière modification : Mercredi 25 avril[04] 2018
--                                                                          --
------------------------------------------------------------------------------

with Ada.Text_IO;
with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with Ada.Command_Line;
with Ada.Directories;

with Des_P.Clef_P.Clef_64_I_P.Faiseur_I_P;
with Des_P.Clef_P.Clef_64_P.Faiseur_P;
with Des_P.Clef_P.Clef_64_P;

with Procedure_Run_Sequentiel_P;

with Des_P.Faiseur_P;

---------------------------------------------------------------------------
procedure Client_Sequentiel is

   Nb_Arguments : constant Natural := Ada.Command_Line.Argument_Count;
   Nb_Arguments_Max : constant Natural := 3;

   ---------------------------------------------------------------------------
   procedure Afficher_Aide;

   procedure Afficher_Aide is
   begin
      Put_Line (Standard_Error, "Utilisation du programme :");
      Ada.Text_IO.Put ("   ");
      Ada.Text_IO.Put
         (
            Ada.Text_IO.Standard_Error,
            Ada.Directories.Base_Name (Ada.Command_Line.Command_Name)
         );
      Put (Standard_Error, " [option] <nom_fichier> <clef>");
      Put_Line (Standard_Error, "");
      Put_Line (Standard_Error, "-c --chiffrer");
      Put_Line (Standard_Error, "  Chiffre le fichier avec la clef.");
      Put_Line (Standard_Error, "-d --dechiffrer");
      Put_Line (Standard_Error, "  Déchiffre le ficher avec la clef.");
      Put_Line (Standard_Error, "");
   end Afficher_Aide;
   ---------------------------------------------------------------------------

   Action : Procedure_Run_Sequentiel_P.Action_T;
   Clef : Des_P.Clef_P.Clef_64_P.Clef_T;

begin

   --  Aucun arguments en entrée
   if Nb_Arguments = 0 then

      Afficher_Aide;
      Ada.Command_Line.Set_Exit_Status
         (Ada.Command_Line.Success);
      return;

      --  Trop d'arguments
   elsif Nb_Arguments > Nb_Arguments_Max then

      Afficher_Aide;
      Put (Standard_Error, "Trop d'arguments. ");
      Put_Line
         (Standard_Error, "Les arguments suivants sont invalide : ");
      for i in Nb_Arguments_Max + 1 .. Nb_Arguments loop
         Put (Standard_Error, "  - ");
         Ada.Text_IO.Put_Line
            (Ada.Text_IO.Standard_Error, Ada.Command_Line.Argument (i));
      end loop;
      Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
      return;

      --  Moins de deux arguments
   elsif Nb_Arguments < 2 then

      Afficher_Aide;
      Put_Line
         (
            Standard_Error,
            "Vous devez donner au moins le <nom_fichier> et la <clef>."
         );
      Ada.Command_Line.Set_Exit_Status
         (Ada.Command_Line.Failure);
      return;

   end if;

   --  L'argument optionnel -c ou -d à été donné
   if Nb_Arguments = 3 then
      Lire_Option_Chiffrement :
      declare
         Chiffre_Dechiffre : constant String :=
            Ada.Command_Line.Argument (1);
      begin
         if
            Chiffre_Dechiffre = "-c"
            or else
            Chiffre_Dechiffre = "--chiffrer"
         then
            Action := Procedure_Run_Sequentiel_P.Chiffrer;

         elsif
            Chiffre_Dechiffre = "-d"
            or else
            Chiffre_Dechiffre = "--dechiffrer"
         then
            Action := Procedure_Run_Sequentiel_P.Dechiffrer;

         else
            Put (Standard_Error, "L'argument [");
            Ada.Text_IO.Put
               (Ada.Text_IO.Standard_Error, Chiffre_Dechiffre);
            Put_Line
               (
                  Standard_Error,
                  "] n'est pas valable"
               );
            Ada.Command_Line.Set_Exit_Status
               (Ada.Command_Line.Failure);
            return;
         end if;
      end Lire_Option_Chiffrement;
   end if;

   Initialiser_Clef :
   declare
      Position_Clef : constant Positive :=
         (if Nb_Arguments = 3 then 3 else 2);
      Clef_Brut : constant String :=
         Ada.Command_Line.Argument (Position_Clef);
      Taille_Clef : constant Natural := Clef_Brut'Size;
   begin
      --  La clef est un bloc de 64 bits
      if Taille_Clef /= 64 then
         Put_Line (Standard_Error, "██████ Erreur !");
         Put_Line (Standard_Error,
               "   La taille de la clef doit être de 8 octets exactement.");
         Ada.Text_IO.Put ("   ");
         Put ("Taille actuelle de la clef : ");
         Ada.Text_IO.Put (Taille_Clef'Img);
         Ada.Text_IO.Put_Line (" octets.");

         Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
         return;
      end if;

      Transformer_En_Clef :
      declare
         package C_I_P renames Des_P.Clef_P.Clef_64_I_P.Faiseur_I_P;
         Brut_Clef : C_I_P.Clef_64_Brut_T with Address => Clef_Brut'Address;
         C_C_64 : Des_P.Clef_P.Clef_64_P.Faiseur_P.Faiseur_Clef_T;
         C_I : constant Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T'Class :=
            Des_P.Faiseur_P.Faire_Clef (C_C_64, Brut_Clef);
         pragma Unreferenced (C_C_64);
      begin
         Clef := Des_P.Clef_P.Clef_64_P.Clef_T (C_I);
      end Transformer_En_Clef;
   end Initialiser_Clef;

   Ouverture_Fichier :
   declare
      Position_Nom_Fic : constant Positive :=
         (if Nb_Arguments = 3 then 2 else 1);
      Nom_Fichier : constant String := Ada.Command_Line.Argument
         (Position_Nom_Fic);
   begin
      --  Vérification de l'existence du fichier
      if not Ada.Directories.Exists (Nom_Fichier) then
         Put_Line (Standard_Error, "██████ Erreur !");
         Put (Standard_Error, "   Le fichier [");
         Ada.Text_IO.Put
            (Ada.Text_IO.Standard_Error, Nom_Fichier);
         Put_Line (Standard_Error, "] n'existe pas");

         Ada.Command_Line.Set_Exit_Status
            (Ada.Command_Line.Failure);
         return;
      end if;

      Verifier_Taille_Fichier :
      declare
         --  Vérification de la taille du fichier.
         --  Si il n'est pas multiple de 64 bits : termine sur une erreur.
         use type Ada.Directories.File_Size;
         Octets_En_Trop : constant Ada.Directories.File_Size :=
            Ada.Directories.Size (Nom_Fichier) mod 8;
      begin
         --  La taille est en octet, 64 bits fait 8 octets,
         --  d'où l'utilisation de mod 8.
         if not (Octets_En_Trop = 0) then
            Put_Line (Standard_Error, "██████ Erreur !");
            Ada.Text_IO.Put_Line
               (
                  Ada.Text_IO.Standard_Error,
                  "   La taille du fichier n'est pas un multiple de 64 bits."
               );
            Ada.Text_IO.Put ("   ");
            Ada.Text_IO.Put (Octets_En_Trop'Img);
            Ada.Text_IO.Put_Line (" Octets de trop.");

            Ada.Command_Line.Set_Exit_Status
               (Ada.Command_Line.Failure);
            return;
         end if;
      end Verifier_Taille_Fichier;

      --  Lancement du chiffrement
      Procedure_Run_Sequentiel_P.Executer_Chiffrement
         (Clef, Nom_Fichier, Action);
   end Ouverture_Fichier;

   Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Success);
   return;

end Client_Sequentiel;
