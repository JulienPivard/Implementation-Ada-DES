with Ada.Text_IO;
with Ada.Directories;

with Des_P.Clef_P.Clef_64_I_P.Faiseur_I_P;
with Des_P.Clef_P.Clef_64_P.Faiseur_P;

with Des_P.Faiseur_P;

package body Gerer_Options_P is

   ---------------------------------------------------------------------------
   procedure Afficher_Aide is
   begin
      W_W_IO_R.Put_Line
         (
            File => W_W_IO_R.Standard_Error,
            Item => "Utilisation du programme :"
         );
      Ada.Text_IO.Put
         (
            File => Ada.Text_IO.Standard_Error,
            Item => "   " & Ada.Directories.Base_Name
               (Name => Ada.Command_Line.Command_Name)
         );
      W_W_IO_R.Put_Line
         (
            File => W_W_IO_R.Standard_Error,
            Item => " [option] <nom_fichier> <clef>"
         );
      W_W_IO_R.Put_Line
         (
            File => W_W_IO_R.Standard_Error,
            Item => "-c --chiffrer"
         );
      W_W_IO_R.Put_Line
         (
            File => W_W_IO_R.Standard_Error,
            Item => "  Chiffre le fichier avec la clef."
         );
      W_W_IO_R.Put_Line
         (
            File => W_W_IO_R.Standard_Error,
            Item => "-d --dechiffrer"
         );
      W_W_IO_R.Put_Line
         (
            File => W_W_IO_R.Standard_Error,
            Item => "  Déchiffre le ficher avec la clef."
         );
      W_W_IO_R.Put_Line
         (
            File => W_W_IO_R.Standard_Error,
            Item => ""
         );
   end Afficher_Aide;

   ---------------------------------------------------------------------------
   procedure Verifier_Nombre_Arguments is
   begin

      --  Aucun arguments en entrée
      if Nb_Args = 0 then

         Afficher_Aide;
         Ada.Command_Line.Set_Exit_Status (Code => Ada.Command_Line.Success);
         raise Options_Incorrect_E;

      --  Trop d'arguments
      elsif Nb_Args > Nb_Args_Max then

         Afficher_Aide;
         W_W_IO_R.Put
            (
               File => W_W_IO_R.Standard_Error,
               Item => "Trop d'arguments. "
            );
         W_W_IO_R.Put_Line
            (
               File => W_W_IO_R.Standard_Error,
               Item => "Les arguments suivants sont invalide : "
            );

         for I in Args_En_Trop_T loop
            Ada.Text_IO.Put_Line
               (
                  File => Ada.Text_IO.Standard_Error,
                  Item => "  - " & Ada.Command_Line.Argument
                     (Number => I)
               );
         end loop;
         Ada.Command_Line.Set_Exit_Status (Code => Ada.Command_Line.Failure);
         raise Options_Incorrect_E;

      --  Moins de deux arguments
      elsif Nb_Args < 2 then

         Afficher_Aide;
         W_W_IO_R.Put_Line
            (
               File => W_W_IO_R.Standard_Error,
               Item => "Vous devez donner au moins le " &
                  "<nom_fichier> et la <clef>."
            );
         Ada.Command_Line.Set_Exit_Status (Code => Ada.Command_Line.Failure);
         raise Options_Incorrect_E;

      end if;

   end Verifier_Nombre_Arguments;

   ---------------------------------------------------------------------------
   function Lire_Option_1_Optionnel
      return Action_T
   is
      Chiffre_Dechiffre : constant String :=
         Ada.Command_Line.Argument (Number => 1);
      Action : Action_T;
   begin
      --  L'argument optionnel -c ou -d à été donné
      if Nb_Args = 3 then
         if
            Chiffre_Dechiffre = "-c"
            or else
            Chiffre_Dechiffre = "--chiffrer"
         then
            Action := Chiffrer;

         elsif
            Chiffre_Dechiffre = "-d"
            or else
            Chiffre_Dechiffre = "--dechiffrer"
         then
            Action := Dechiffrer;

         else
            W_W_IO_R.Put
               (
                  File => W_W_IO_R.Standard_Error,
                  Item => "L'argument ["
               );
            Ada.Text_IO.Put
               (
                  File => Ada.Text_IO.Standard_Error,
                  Item => Chiffre_Dechiffre
               );
            W_W_IO_R.Put_Line
               (
                  File => W_W_IO_R.Standard_Error,
                  Item => "] n'est pas valable"
               );
            Ada.Command_Line.Set_Exit_Status
               (Code => Ada.Command_Line.Failure);
            raise Options_Incorrect_E;
         end if;
      else
         Action := Chiffrer;
      end if;

      return Action;
   end Lire_Option_1_Optionnel;

   ---------------------------------------------------------------------------
   function Lire_Option_Clef
      return Des_P.Clef_P.Clef_64_P.Clef_T
   is
      Position_Clef : constant Positive :=
         (if Nb_Args = 3 then 3 else 2);
      Clef_Brut : constant String :=
         Ada.Command_Line.Argument (Number => Position_Clef);
      Taille_Clef : constant Natural := Clef_Brut'Size;
   begin
      --  La clef est un bloc de 64 bits
      if Taille_Clef /= 64 then
         W_W_IO_R.Put_Line
            (
               File => W_W_IO_R.Standard_Error,
               Item => "██████ Erreur !"
            );
         W_W_IO_R.Put_Line
            (
               File => W_W_IO_R.Standard_Error,
               Item => "   La taille de la clef doit " &
                  "être de 8 octets exactement."
            );
         Ada.Text_IO.Put
            (
               File => Ada.Text_IO.Standard_Error,
               Item => "   Taille actuelle de la clef : "
            );
         Ada.Text_IO.Put
            (
               File => Ada.Text_IO.Standard_Error,
               Item => Taille_Clef'Img
            );
         Ada.Text_IO.Put_Line
            (
               File => Ada.Text_IO.Standard_Error,
               Item => " octets."
            );

         Ada.Command_Line.Set_Exit_Status (Code => Ada.Command_Line.Failure);
         raise Options_Incorrect_E;
      end if;

      Transformer_En_Clef :
      declare
         package Clef_I_R renames Des_P.Clef_P.Clef_64_I_P;

         F_C_64 : Des_P.Clef_P.Clef_64_P.Faiseur_P.Faiseur_Clef_T;
         Brut_Clef : Clef_I_R.Faiseur_I_P.Clef_64_Brut_T
            with Address => Clef_Brut'Address;
         Clef_I : constant Clef_I_R.Clef_Interface_T'Class :=
            Des_P.Faiseur_P.Faire_Clef
               (
                  Faiseur => F_C_64,
                  Clef    => Brut_Clef
               );

         pragma Unreferenced (F_C_64);
         pragma Unreferenced (Brut_Clef);
      begin
         return Des_P.Clef_P.Clef_64_P.Clef_T (Clef_I);
      end Transformer_En_Clef;
   end Lire_Option_Clef;

   ---------------------------------------------------------------------------
   function Lire_Option_Nom_Fichier
      return String
   is
      Position_Nom_Fic : constant Positive :=
         (if Nb_Args = 3 then 2 else 1);
      Nom_Fichier : constant String :=
         Ada.Command_Line.Argument (Number => Position_Nom_Fic);
   begin
      --  Vérification de l'existence du fichier
      if not Ada.Directories.Exists (Name => Nom_Fichier) then
         W_W_IO_R.Put_Line
            (
               File => W_W_IO_R.Standard_Error,
               Item => "██████ Erreur !"
            );
         W_W_IO_R.Put
            (
               File => W_W_IO_R.Standard_Error,
               Item => "   Le fichier ["
            );
         Ada.Text_IO.Put
            (
               File => Ada.Text_IO.Standard_Error,
               Item => Nom_Fichier
            );
         W_W_IO_R.Put_Line
            (
               File => W_W_IO_R.Standard_Error,
               Item => "] n'existe pas"
            );

         Ada.Command_Line.Set_Exit_Status
            (Code => Ada.Command_Line.Failure);
         raise Options_Incorrect_E;
      end if;

      Verifier_Taille_Fichier :
      declare
         use type Ada.Directories.File_Size;
         --  Vérification de la taille du fichier.
         --  Si il n'est pas multiple de 64 bits : termine sur une erreur.
         Octets_En_Trop : constant Ada.Directories.File_Size :=
            Ada.Directories.Size (Name => Nom_Fichier) mod 8;
      begin
         --  La taille est en octet, 64 bits fait 8 octets,
         --  d'où l'utilisation de mod 8.
         if not (Octets_En_Trop = 0) then
            W_W_IO_R.Put_Line
               (
                  File => W_W_IO_R.Standard_Error,
                  Item => "██████ Erreur !"
               );
            Ada.Text_IO.Put_Line
               (
                  File => Ada.Text_IO.Standard_Error,
                  Item => "   La taille du fichier n'est pas " &
                     "un multiple de 64 bits."
               );
            Ada.Text_IO.Put_Line
               (
                  File => Ada.Text_IO.Standard_Error,
                  Item => "   " &
                     Octets_En_Trop'Img &
                     " Octets de trop."
               );

            Ada.Command_Line.Set_Exit_Status
               (Code => Ada.Command_Line.Failure);
            raise Options_Incorrect_E;
         end if;
      end Verifier_Taille_Fichier;

      return Nom_Fichier;
   end Lire_Option_Nom_Fichier;

end Gerer_Options_P;
