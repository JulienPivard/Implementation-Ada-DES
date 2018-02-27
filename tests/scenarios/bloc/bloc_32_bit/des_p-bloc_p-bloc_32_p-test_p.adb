with AUnit.Assertions;

with Ada.Numerics.Discrete_Random;

package body Des_P.Bloc_P.Bloc_32_P.Test_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      b : Bloc_32_T;
   begin
      T.bloc := b;
   end Set_Up;

   ---------------------------------------------------------------------------
   overriding
   procedure Tear_Down (T : in out Test_Fixt_T) is
   begin
      null;
   end Tear_Down;

   ---------------------------------------------------------------------------
   --                              scénarios                                --
   ---------------------------------------------------------------------------
   procedure Test_Initialisation (T : in out Test_Fixt_T) is
      b : constant Bit_T := False;
      valeur_bit : Bit_IO_T;
   begin
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         AUnit.Assertions.Assert
            (T.bloc.Bits (I) = b,
            "Le bit " & I'Img &
            " vaut : " & valeur_bit'Img &
            " au lieu de 0"
            );
      end loop;
   end Test_Initialisation;

   ---------------------------------------------------------------------------
   procedure Test_1er_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 1;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_1er_Bit;

   ---------------------------------------------------------------------------
   procedure Test_2eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 2;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_2eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_3eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 3;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_3eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_4eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 4;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_4eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_5eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 5;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_5eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_6eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 6;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_6eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_7eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 7;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_7eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_8eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 8;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_8eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_9eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 9;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_9eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_10eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 10;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_10eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_11eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 11;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_11eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_12eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 12;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_12eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_13eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 13;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_13eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_14eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 14;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_14eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_15eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 15;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_15eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_16eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 16;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_16eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_17eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 17;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_17eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_18eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 18;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_18eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_19eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 19;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_19eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_20eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 20;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_20eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_21eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 21;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_21eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_22eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 22;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_22eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_23eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 23;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_23eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_24eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 24;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_24eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_25eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 25;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_25eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_26eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 26;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_26eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_27eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 27;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_27eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_28eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 28;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_28eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_29eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 29;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_29eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_30eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 30;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_30eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_31eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 31;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_31eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_32eme_Bit (T : in out Test_Fixt_T) is
      p : constant Intervalle_T := 32;
      b : constant Bit_T := True;
      valeur_bit : Bit_IO_T;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.bloc.Bits (I) then 1 else 0);
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Bits (p) = b,
               "Le bit " & p'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Bits (I) = False,
               "Le bit " & I'Img &
               " vaut : " & valeur_bit'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_32eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_Change_Bits_Aleatoirement (T : in out Test_Fixt_T) is
      b : Bit_T;
      attendu : Tableau_Bits_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      generateur : Bit_Aleatoire.Generator;
      valeur_bit_resulta, valeur_bit_attendu : Bit_IO_T;
   begin

      Bit_Aleatoire.Reset (generateur);

      for I in Intervalle_T'Range loop
         b := Bit_Aleatoire.Random (generateur);
         T.bloc.Ecrire_Bit (I, b);
         attendu (I) := b;
      end loop;

      for I in Intervalle_T'Range loop
         valeur_bit_resulta := (if T.bloc.Lire_Bit (I) then 1 else 0);
         valeur_bit_attendu := (if attendu (I) then 1 else 0);
         AUnit.Assertions.Assert
            (T.bloc.Lire_Bit (I) = attendu (I),
            "Le bit " & I'Img &
            " vaut : " & valeur_bit_resulta'Img &
            " au lieu de " & valeur_bit_attendu'Img
            );
      end loop;

   end Test_Change_Bits_Aleatoirement;

   ---------------------------------------------------------------------------
   procedure Test_Ou_Exclusif (T : in out Test_Fixt_T) is
      B1 : Bloc_32_T;
      B2 : Bloc_32_T;
      I, J : Intervalle_T;
      Valeur : Bit_T;
      attendu : constant Tableau_Bits_T :=
         (False, False, False, False, True, True, True, True,
         True, True, True, True, False, False, False, False,
         False, False, False, False, True, True, True, True,
         True, True, True, True, False, False, False, False);
      valeur_bit_resulta, valeur_bit_attendu : Bit_IO_T;
   begin
      I := Intervalle_T'First;
      Valeur := False;
      Autour :
      loop
         J := Intervalle_T'First;
         Interne :
         loop
            B1.Bits (I) := Valeur;
            exit Autour when I = Intervalle_T'Last;
            I := Intervalle_T'Succ (I);
            J := Intervalle_T'Succ (J);
            exit Interne when J > 4;
         end loop Interne;
         if Valeur = Bit_T'Last then
            Valeur := False;
         else
            Valeur := True;
         end if;
      end loop Autour;

      I := Intervalle_T'First;
      Valeur := False;
      Autour_Bis :
      loop
         J := Intervalle_T'First;
         Interne_Bis :
         loop
            B2.Bits (I) := Valeur;
            exit Autour_Bis when I = Intervalle_T'Last;
            I := Intervalle_T'Succ (I);
            J := Intervalle_T'Succ (J);
            exit Interne_Bis when J > 8;
         end loop Interne_Bis;
         if Valeur then
            Valeur := False;
         else
            Valeur := True;
         end if;
      end loop Autour_Bis;

      T.bloc := B1 xor B2;

      for I in Intervalle_T'Range loop
         valeur_bit_resulta := (if T.bloc.Lire_Bit (I) then 1 else 0);
         valeur_bit_attendu := (if attendu (I) then 1 else 0);
         AUnit.Assertions.Assert
            (T.bloc.Lire_Bit (I) = attendu (I),
            "Le bit " & I'Img &
            " vaut : " & valeur_bit_resulta'Img &
            " au lieu de " & valeur_bit_attendu'Img
            );
      end loop;
   end Test_Ou_Exclusif;

end Des_P.Bloc_P.Bloc_32_P.Test_P;
