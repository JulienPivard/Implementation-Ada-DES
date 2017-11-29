with AUnit.Assertions;

with Ada.Numerics.Discrete_Random;

package body Des_P.Bloc_32_P.Test_P is

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
      b : constant Bit_T := 0;
   begin
      for I in Interval_Bloc_32_T'Range loop
         AUnit.Assertions.Assert
            (T.bloc.Tableau_Bit (I) = b,
            "Le bit " & I'Img &
            " vaut : " & T.bloc.Tableau_Bit (I)'Img &
            " au lieu de 0"
            );
      end loop;
   end Test_Initialisation;

   ---------------------------------------------------------------------------
   procedure Test_1er_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 1;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_1er_Bit;

   ---------------------------------------------------------------------------
   procedure Test_2eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 2;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_2eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_3eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 3;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_3eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_4eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 4;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_4eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_5eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 5;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_5eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_6eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 6;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_6eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_7eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 7;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_7eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_8eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 8;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_8eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_9eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 9;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_9eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_10eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 10;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_10eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_11eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 11;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_11eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_12eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 12;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_12eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_13eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 13;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_13eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_14eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 14;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_14eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_15eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 15;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_15eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_16eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 16;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_16eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_17eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 17;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_17eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_18eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 18;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_18eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_19eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 19;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_19eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_20eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 20;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_20eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_21eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 21;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_21eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_22eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 22;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_22eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_23eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 23;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_23eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_24eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 24;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_24eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_25eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 25;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_25eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_26eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 26;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_26eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_27eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 27;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_27eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_28eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 28;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_28eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_29eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 29;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_29eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_30eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 30;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_30eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_31eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 31;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_31eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_32eme_Bit (T : in out Test_Fixt_T) is
      p : constant Interval_Bloc_32_T := 32;
      b : constant Bit_T := 1;
   begin
      T.bloc.Ecrire_Bit (p, b);
      for I in Interval_Bloc_32_T'Range loop
         if I = p then
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (p) = b,
               "Le bit " & p'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 1"
               );
         else
            AUnit.Assertions.Assert
               (T.bloc.Tableau_Bit (I) = 0,
               "Le bit " & I'Img &
               " vaut : " & T.bloc.Tableau_Bit (I)'Img &
               " au lieu de 0"
               );
         end if;
      end loop;
   end Test_32eme_Bit;

   ---------------------------------------------------------------------------
   procedure Test_Change_Bits_Aleatoirement (T : in out Test_Fixt_T) is
      b : Bit_T;
      attendu : array (Interval_Bloc_32_T range 1 .. 32) of Bit_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      generateur : Bit_Aleatoire.Generator;
   begin
      Bit_Aleatoire.Reset (generateur);
      for I in Interval_Bloc_32_T'Range loop
         b := Bit_Aleatoire.Random (generateur);
         T.bloc.Ecrire_Bit (I, b);
         attendu (I) := b;
      end loop;
      for I in Interval_Bloc_32_T'Range loop
         AUnit.Assertions.Assert
            (T.bloc.Lire_Bit (I) = attendu (I),
            "Le bit " & I'Img &
            " vaut : " & T.bloc.Tableau_Bit (I)'Img &
            " au lieu de " & attendu (I)'Img
            );
      end loop;
   end Test_Change_Bits_Aleatoirement;

end Des_P.Bloc_32_P.Test_P;
