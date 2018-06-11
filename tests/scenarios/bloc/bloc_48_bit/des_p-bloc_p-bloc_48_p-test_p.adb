with AUnit.Assertions;
with Des_P.Bloc_P.Bloc_48_I_P;

with Ada.Numerics.Discrete_Random;

package body Des_P.Bloc_P.Bloc_48_P.Test_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      b : Bloc_48_T;
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
   procedure Test_Initialisation
      (T : in out Test_Fixt_T)
   is
      b : constant Bit_T := False;
      valeur_bit : Bit_IO_T;
   begin
      for I in Des_P.Bloc_P.Bloc_48_I_P.Intervalle_T'Range loop
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
   procedure Test_Modification_Un_Bit_Par_Un_Bit
      (T : in out Test_Fixt_T)
   is
      Nb_Bit_A_Un : Natural;
   begin
      for I in Des_P.Bloc_P.Bloc_48_I_P.Intervalle_T loop
         AUnit.Assertions.Assert
            (
               (for all I of T.bloc.Bits => I = False),
               "Tous les bits devraient etre faux"
            );
         T.bloc.Ecrire_Bit (I, True);
         Nb_Bit_A_Un := Natural'First;
         for J in Des_P.Bloc_P.Bloc_48_I_P.Intervalle_T loop
            declare
               use type Des_P.Bloc_P.Bloc_48_I_P.Intervalle_T;
               b : constant Bit_T := J = I;
               valeur_attendu : constant Bit_IO_T := (if b then 1 else 0);
               --  valeur trouvée interne
               v_t_i : constant Bit_T := T.bloc.Bits (J);
               --  valeur trouvée lue
               v_t_l : constant Bit_T := T.bloc.Lire_Bit (J);

               v_t_i_io : constant Bit_IO_T := (if v_t_i then 1 else 0);
               v_t_l_io : constant Bit_IO_T := (if v_t_l then 1 else 0);
            begin
               if v_t_l then
                  Nb_Bit_A_Un := Nb_Bit_A_Un + 1;
               end if;
               AUnit.Assertions.Assert
                  (
                     v_t_i = b,
                     "Le bit interne " & J'Img &
                     " vaut : " & v_t_i_io'Img &
                     " au lieu de " & valeur_attendu'Img
                  );
               AUnit.Assertions.Assert
                  (
                     v_t_l = b,
                     "Le bit lu " & J'Img &
                     " vaut : " & v_t_l_io'Img &
                     " au lieu de " & valeur_attendu'Img
                  );
            end;
         end loop;
         AUnit.Assertions.Assert
            (
               Nb_Bit_A_Un = 1,
               "Le nombre de bit a 1 devrait etre 1 et pas " &
               Nb_Bit_A_Un'Img
            );
         T.bloc.Ecrire_Bit (I, False);
         AUnit.Assertions.Assert
            (
               (for all I of T.bloc.Bits => I = False),
               "Tous les bits devraient etre faux"
            );
      end loop;
   end Test_Modification_Un_Bit_Par_Un_Bit;

   ---------------------------------------------------------------------------
   procedure Test_Change_Bits_Aleatoirement
      (T : in out Test_Fixt_T)
   is
      b : Bit_T;
      attendu : Tableau_Bits_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      generateur : Bit_Aleatoire.Generator;
      valeur_bit_resulta, valeur_bit_attendu : Bit_IO_T;
   begin

      Bit_Aleatoire.Reset (generateur);

      --  Génère un grand nombre de configuration aléatoire
      for C in 0 .. 128 loop

         for I in Des_P.Bloc_P.Bloc_48_I_P.Intervalle_T'Range loop
            b := Bit_Aleatoire.Random (generateur);
            T.bloc.Ecrire_Bit (I, b);
            attendu (I) := b;
         end loop;

         for I in Des_P.Bloc_P.Bloc_48_I_P.Intervalle_T'Range loop
            valeur_bit_resulta := (if T.bloc.Lire_Bit (I) then 1 else 0);
            valeur_bit_attendu := (if attendu (I) then 1 else 0);
            AUnit.Assertions.Assert
               (T.bloc.Lire_Bit (I) = attendu (I),
               "Le bit " & I'Img &
               " vaut : " & valeur_bit_resulta'Img &
               " au lieu de " & valeur_bit_attendu'Img
               );
         end loop;

      end loop;

   end Test_Change_Bits_Aleatoirement;

end Des_P.Bloc_P.Bloc_48_P.Test_P;
