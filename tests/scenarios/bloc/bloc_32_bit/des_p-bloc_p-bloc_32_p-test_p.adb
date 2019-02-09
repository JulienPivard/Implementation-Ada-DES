with AUnit.Assertions;

with Ada.Numerics.Discrete_Random;

package body Des_P.Bloc_P.Bloc_32_P.Test_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      B : Bloc_32_T;
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
      for I in Intervalle_T loop
         Verification_Bit_Init :
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
         end Verification_Bit_Init;
      end loop;
   end Test_Initialisation;

   ---------------------------------------------------------------------------
   procedure Test_Modification_Un_Bit_Par_Un_Bit
      (T : in out Test_Fixt_T)
   is
      Nb_Bit_A_Un : Natural;
   begin
      Parcours_Tous_Les_Bits :
      for I in Intervalle_T loop
         AUnit.Assertions.Assert
            (
               (for all E of T.Bloc.Bits => E = False),
               "Tous les bits devraient etre faux"
            );
         T.Bloc.Ecrire_Bit (I, True);
         Nb_Bit_A_Un := 0;
         Verifie_Tous_Les_Bits :
         for J in Intervalle_T loop
            Extraire_Bit_En_Valeur :
            declare
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
            end Extraire_Bit_En_Valeur;
         end loop Verifie_Tous_Les_Bits;
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
      end loop Parcours_Tous_Les_Bits;
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
      Compteur_Nombre_Configurations_Aleatoire :
      for C in Interval_Nb_Conf_Genere_T loop

         Generateur_Configuration :
         for I in Intervalle_T loop
            Generateur_De_Bit :
            declare
               B : constant Bit_T := Bit_Aleatoire.Random (Generateur);
            begin
               T.Bloc.Ecrire_Bit (I, B);
               Attendu (I) := B;
            end Generateur_De_Bit;
         end loop Generateur_Configuration;

         Verificateur_Configuration :
         for I in Intervalle_T loop
            Verification_Bit_Par_Bit :
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
            end Verification_Bit_Par_Bit;
         end loop Verificateur_Configuration;

      end loop Compteur_Nombre_Configurations_Aleatoire;

   end Test_Change_Bits_Aleatoirement;

   ---------------------------------------------------------------------------
   procedure Test_Ou_Exclusif
      (T : in out Test_Fixt_T)
   is
      B1 : Bloc_32_T;
      B2 : Bloc_32_T;
      I, J : Intervalle_T;
      Valeur : Bit_T;
      Attendu : constant Tableau_Bits_T :=
         (
            False, False, False, False, True, True, True, True,
            True, True, True, True, False, False, False, False,
            False, False, False, False, True, True, True, True,
            True, True, True, True, False, False, False, False
         );
   begin
      I := Intervalle_T'First;
      Valeur := False;
      --  Initialise le premier bloc de 32 bits
      --  F,F,F,F,V,V,V,V, F,F,F,F,V,V,V,V, F,F,F,F,V,V,V,V, F,F,F,F,V,V,V,V,
      --  F,F,F,F,V,V,V,V, F,F,F,F,V,V,V,V, F,F,F,F,V,V,V,V, F,F,F,F,V,V,V,V,
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
         --  On inverse la valeur du bit à écrire tout les 4 bits
         if Valeur then
            Valeur := False;
         else
            Valeur := True;
         end if;
      end loop Autour;

      I := Intervalle_T'First;
      Valeur := False;
      --  Initialise le second bloc de 32 bits
      --  F,F,F,F,F,F,F,F, V,V,V,V,V,V,V,V, F,F,F,F,F,F,F,F, V,V,V,V,V,V,V,V,
      --  F,F,F,F,F,F,F,F, V,V,V,V,V,V,V,V, F,F,F,F,F,F,F,F, V,V,V,V,V,V,V,V,
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
         --  On inverse la valeur du bit à écrire tout les 8 bits
         if Valeur then
            Valeur := False;
         else
            Valeur := True;
         end if;
      end loop Autour_Bis;

      T.Bloc := B1 xor B2;

      for I in Intervalle_T loop
         Extrait_Verifie_Bit :
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
         end Extrait_Verifie_Bit;
      end loop;
   end Test_Ou_Exclusif;

end Des_P.Bloc_P.Bloc_32_P.Test_P;
