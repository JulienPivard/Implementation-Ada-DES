with Ada.Text_IO;

package body Des_P.Bloc_P.Bloc_32_P.Bloc_IO is

   ---------------------------------------------------------------------------
   procedure Put (Bloc : Bloc_32_T) is
      type Bit_IO_T is range 0 .. 1;
      package Bit_IO is new Ada.Text_IO.Integer_IO (Bit_IO_T);
      c : Natural := 1;
      taille : Natural;
      Bit : Bit_IO_T;
   begin
      for I in Intervalle_Bloc_32_T'Range loop
         if c > 8 then
            taille := 2;
            c := 1;
         else
            taille := 1;
         end if;
         Bit := (if Bloc.Bits (I) then 1 else 0);
         Bit_IO.Put (Bit, taille);
         c := c + 1;
      end loop;
   end Put;

   ---------------------------------------------------------------------------
   procedure Put_Line (Bloc : Bloc_32_T) is
   begin
      Put (Bloc);
      Ada.Text_IO.New_Line (1);
   end Put_Line;

end Des_P.Bloc_P.Bloc_32_P.Bloc_IO;
