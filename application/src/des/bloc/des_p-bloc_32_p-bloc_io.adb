with Ada.Text_IO;

package body Des_P.Bloc_32_P.Bloc_IO is

   ---------------------------------------------------------------------------
   procedure Put (Bloc : Bloc_32_T) is
      package Bit_IO is new Ada.Text_IO.Integer_IO (Bit_T);
      c : Natural := 1;
   begin
      for I in Interval_Bloc_32_T'Range loop
         if c > 8 then
            Bit_IO.Put (Bloc.Tableau_Bit (I), 2);
            c := 2;
         else
            Bit_IO.Put (Bloc.Tableau_Bit (I), 1);
            c := c + 1;
         end if;
      end loop;
   end Put;

   ---------------------------------------------------------------------------
   procedure Put_Line (Bloc : Bloc_32_T) is
   begin
      Put (Bloc);
      Ada.Text_IO.New_Line (1);
   end Put_Line;

end Des_P.Bloc_32_P.Bloc_IO;
