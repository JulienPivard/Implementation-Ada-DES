with AUnit.Assertions;
with Des_P.Bloc_P.Bloc_48_I_P;

with Ada.Numerics.Discrete_Random;

package body Des_P.Bloc_P.Bloc_48_P.Test_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      B : Bloc_48_T;
   begin
      T.Bloc := B;
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
      B : constant Bit_T := False;
   begin
      for I in Des_P.Bloc_P.Bloc_48_I_P.Intervalle_T loop
         declare
            Valeur_Bit : constant Bit_IO_T :=
               (if T.Bloc.Bits (I) then 1 else 0);
         begin
            AUnit.Assertions.Assert
               (T.Bloc.Bits (I) = B,
               "Le bit " & I'Img &
               " vaut : " & Valeur_Bit'Img &
               " au lieu de 0"
               );
         end;
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
               (for all E of T.Bloc.Bits => E = False),
               "Tous les bits devraient etre faux"
            );
         T.Bloc.Ecrire_Bit (I, True);
         Nb_Bit_A_Un := 0;
         for J in Des_P.Bloc_P.Bloc_48_I_P.Intervalle_T loop
            declare
               use type Des_P.Bloc_P.Bloc_48_I_P.Intervalle_T;
               B : constant Bit_T := J = I;
               Valeur_Attendu : constant Bit_IO_T := (if B then 1 else 0);
               --  valeur trouvée interne
               V_T_I : constant Bit_T := T.Bloc.Bits (J);
               --  valeur trouvée lue
               V_T_L : constant Bit_T := T.Bloc.Lire_Bit (J);

               V_T_I_IO : constant Bit_IO_T := (if V_T_I then 1 else 0);
               V_T_L_IO : constant Bit_IO_T := (if V_T_L then 1 else 0);
            begin
               if V_T_L then
                  Nb_Bit_A_Un := Nb_Bit_A_Un + 1;
               end if;
               AUnit.Assertions.Assert
                  (
                     V_T_I = B,
                     "Le bit interne " & J'Img &
                     " vaut : " & V_T_I_IO'Img &
                     " au lieu de " & Valeur_Attendu'Img
                  );
               AUnit.Assertions.Assert
                  (
                     V_T_L = B,
                     "Le bit lu " & J'Img &
                     " vaut : " & V_T_L_IO'Img &
                     " au lieu de " & Valeur_Attendu'Img
                  );
            end;
         end loop;
         AUnit.Assertions.Assert
            (
               Nb_Bit_A_Un = 1,
               "Le nombre de bit a 1 devrait etre 1 et pas " &
               Nb_Bit_A_Un'Img
            );
         T.Bloc.Ecrire_Bit (I, False);
         AUnit.Assertions.Assert
            (
               (for all E of T.Bloc.Bits => E = False),
               "Tous les bits devraient etre faux"
            );
      end loop;
   end Test_Modification_Un_Bit_Par_Un_Bit;

   ---------------------------------------------------------------------------
   procedure Test_Change_Bits_Aleatoirement
      (T : in out Test_Fixt_T)
   is
      Attendu : Tableau_Bits_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      Generateur : Bit_Aleatoire.Generator;
   begin

      Bit_Aleatoire.Reset (Generateur);

      --  Génère un grand nombre de configuration aléatoire
      for C in Interval_Nb_Conf_Genere_T loop

         for I in Des_P.Bloc_P.Bloc_48_I_P.Intervalle_T loop
            declare
               B : constant Bit_T := Bit_Aleatoire.Random (Generateur);
            begin
               T.Bloc.Ecrire_Bit (I, B);
               Attendu (I) := B;
            end;
         end loop;

         for I in Des_P.Bloc_P.Bloc_48_I_P.Intervalle_T loop
            declare
               Valeur_Bit_Resulta : constant Bit_IO_T :=
                  (if T.Bloc.Lire_Bit (I) then 1 else 0);
               Valeur_Bit_Attendu : constant Bit_IO_T :=
                  (if Attendu (I) then 1 else 0);
            begin
               AUnit.Assertions.Assert
                  (T.Bloc.Lire_Bit (I) = Attendu (I),
                  "Le bit " & I'Img &
                  " vaut : " & Valeur_Bit_Resulta'Img &
                  " au lieu de " & Valeur_Bit_Attendu'Img
                  );
            end;
         end loop;

      end loop;

   end Test_Change_Bits_Aleatoirement;

end Des_P.Bloc_P.Bloc_48_P.Test_P;
