with Ada.Text_IO;
with Ada.Directories;

package body Executeur_G is

   ---------------------------------------------------------------------------
   procedure Executer
      --  (Arguments)
   is separate;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Afficher_Aide is
      Indentation : constant Wide_Wide_String := "        ";
   begin
      W_W_IO_R.Put
         (File => W_W_IO_R.Standard_Error, Item => "Usage : ");
      Ada.Text_IO.Put
         (
            File => Ada.Text_IO.Standard_Error,
            Item => Ada.Directories.Base_Name
               (Name => Ada.Command_Line.Command_Name)
         );
      W_W_IO_R.Put_Line
         (File => W_W_IO_R.Standard_Error, Item => " [arguments]");
      W_W_IO_R.Put_Line
         (File => W_W_IO_R.Standard_Error, Item => Indentation);
      --  W_W_IO_R.New_Line
      --     (File => W_W_IO_R.Standard_Error, Spacing => 1);
   end Afficher_Aide;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Verifier_Nombre_D_Arguments is
   begin
      Ada.Command_Line.Set_Exit_Status (Code => Ada.Command_Line.Success);

      if Nb_Args = 0 and then Nombre_D_Arguments_Min > 0 then
         Afficher_Aide;
         raise Pas_Assez_D_Arguments_E;

      elsif Nb_Args > Nombre_D_Arguments_Max then
         Afficher_Aide;
         W_W_IO_R.Put
            (File => W_W_IO_R.Standard_Error, Item => "Trop d'arguments. ");
         W_W_IO_R.Put_Line
            (
               File => W_W_IO_R.Standard_Error,
               Item => "Les arguments suivants sont invalide : "
            );
         for I in Arguments_En_Trop_T loop
            Ada.Text_IO.Put
               (File => Ada.Text_IO.Standard_Error, Item => "  - ");
            Ada.Text_IO.Put_Line
               (
                  File => Ada.Text_IO.Standard_Error,
                  Item => Ada.Command_Line.Argument (Number => I)
               );
         end loop;
         Ada.Command_Line.Set_Exit_Status (Code => Ada.Command_Line.Failure);
         raise Trop_D_Arguments_E;

      elsif Nb_Args < Nombre_D_Arguments_Min then
         Afficher_Aide;
         W_W_IO_R.Put_Line
            (
               File => W_W_IO_R.Standard_Error,
               Item => "Vous devez donner au moins le [argument]."
            );
         Ada.Command_Line.Set_Exit_Status (Code => Ada.Command_Line.Failure);
         raise Pas_Assez_D_Arguments_E;

      end if;
   end Verifier_Nombre_D_Arguments;
   ---------------------------------------------------------------------------

end Executeur_G;
