with AUnit.Assertions;

with Ada.Numerics.Discrete_Random;

with Des_P.Bloc_P.Bloc_32_P;

package body Des_P.Bloc_P.Bloc_64_P.Test_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      B : Bloc_64_T;
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
      B : constant Bit_IO_T := 0;
   begin
      AUnit.Assertions.Assert
         (T.Bloc.Decalage = 0,
         "Le decalage vaut " & T.Bloc.Decalage'Img &
         " au lieu de 0 apres 0 decalages."
         );
      for I in Intervalle_T loop
         Verification_Bit_Init :
         declare
            Valeur_Bit : constant Bit_IO_T :=
               (if T.Bloc.Lire_Bit (I) then 1 else 0);
         begin
            AUnit.Assertions.Assert
               (Valeur_Bit = B,
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
               (for all E in Intervalle_T => T.Bloc.Lire_Bit (E) = False),
               "Tous les bits devraient etre faux"
            );
         T.Bloc.Ecrire_Bit (I, True);
         Nb_Bit_A_Un := Natural'First;
         Verifie_Tous_Les_Bits :
         for J in Intervalle_T loop
            Extraire_Bit_En_Valeur :
            declare
               B : constant Bit_T := J = I;
               Valeur_Attendu : constant Bit_IO_T := (if B then 1 else 0);
               --  valeur trouvée interne
               V_T_L : constant Bit_T := T.Bloc.Lire_Bit (J);

               V_T_L_IO : constant Bit_IO_T := (if V_T_L then 1 else 0);
            begin
               if V_T_L then
                  Nb_Bit_A_Un := Nb_Bit_A_Un + 1;
               end if;
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
               (for all E in Intervalle_T => T.Bloc.Lire_Bit (E) = False),
               "Tous les bits devraient etre faux"
            );
      end loop Parcours_Tous_Les_Bits;
   end Test_Modification_Un_Bit_Par_Un_Bit;

   ---------------------------------------------------------------------------
   procedure Test_Bits_Aleatoire
      (T : in out Test_Fixt_T)
   is
      Attendu : Tableau_Bits_64_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      Generateur : Bit_Aleatoire.Generator;
   begin

      Bit_Aleatoire.Reset (Generateur);

      --  Génère un grand nombre de configuration aléatoire
      Compteur_Nombre_Configurations_Aleatoire :
      for C in Interval_Nb_Conf_Genere_T loop

         --  Remplissage avec des bits aléatoire
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

         --  Vérification du contenu.
         Verificateur_Configuration :
         for I in Intervalle_T loop
            Verification_Bit_Par_Bit :
            declare
               Bit_Resulta : constant Bit_IO_T :=
                  (if T.Bloc.Lire_Bit (I) then 1 else 0);
               Bit_Attendu : constant Bit_IO_T :=
                  (if Attendu (I) then 1 else 0);
            begin
               AUnit.Assertions.Assert
                  (Bit_Resulta = Bit_Attendu,
                  "Le bit " & I'Img &
                  " vaut : " & Bit_Resulta'Img &
                  " au lieu de " & Bit_Attendu'Img
                  );
            end Verification_Bit_Par_Bit;
         end loop Verificateur_Configuration;

      end loop Compteur_Nombre_Configurations_Aleatoire;

   end Test_Bits_Aleatoire;

   ---------------------------------------------------------------------------
   procedure Test_Bits_Aleatoire_Par_Bloc
      (T : in out Test_Fixt_T)
   is
      Attendu_Gauche : Tableau_Bits_32_T;
      Attendu_Droite : Tableau_Bits_32_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      Generateur : Bit_Aleatoire.Generator;
   begin

      Bit_Aleatoire.Reset (Generateur);

      --  Génère un grand nombre de configuration aléatoire
      Compteur_Nombre_Configurations_Aleatoire :
      for C in Interval_Nb_Conf_Genere_T loop

         --  Remplissage avec des bits aléatoire
         Generateur_Configuration :
         for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
            Generateur_De_Bit :
            declare
               B : Bit_T;
            begin
               B := Bit_Aleatoire.Random (Generateur);
               T.Bloc.Ecrire_Bit (A_Gauche, I, B);
               Attendu_Gauche (I) := B;
               B := Bit_Aleatoire.Random (Generateur);
               T.Bloc.Ecrire_Bit (A_Droite, I, B);
               Attendu_Droite (I) := B;
            end Generateur_De_Bit;
         end loop Generateur_Configuration;

         --  Vérification du contenu.
         Verificateur_Configuration :
         for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
            Verification_Bit_Par_Bit :
            declare
               Bit_Resulta, Bit_Attendu : Bit_IO_T;
            begin
               Bit_Resulta := (if T.Bloc.Lire_Bit (A_Gauche, I) then 1 else 0);
               Bit_Attendu := (if Attendu_Gauche (I) then 1 else 0);
               AUnit.Assertions.Assert
                  (Bit_Resulta = Bit_Attendu,
                  "Le bit Bloc GAUCHE " & I'Img &
                  " vaut : " & Bit_Resulta'Img &
                  " au lieu de " & Bit_Attendu'Img
                  );
               Bit_Resulta := (if T.Bloc.Lire_Bit (A_Droite, I) then 1 else 0);
               Bit_Attendu := (if Attendu_Droite (I) then 1 else 0);
               AUnit.Assertions.Assert
                  (Bit_Resulta = Bit_Attendu,
                  "Le bit Bloc DROITE " & I'Img &
                  " vaut : " & Bit_Resulta'Img &
                  " au lieu de " & Bit_Attendu'Img
                  );
            end Verification_Bit_Par_Bit;
         end loop Verificateur_Configuration;

      end loop Compteur_Nombre_Configurations_Aleatoire;

   end Test_Bits_Aleatoire_Par_Bloc;

   ---------------------------------------------------------------------------
   procedure Test_Bits_Aleatoire_1_Echange
      (T : in out Test_Fixt_T)
   is
      Attendu                 : Tableau_Bits_64_T;
      Attendu_Apres_Echange   : Tableau_Bits_64_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      Generateur : Bit_Aleatoire.Generator;
   begin

      Bit_Aleatoire.Reset (Generateur);

      --  Génère un grand nombre de configuration aléatoire
      Compteur_Nombre_Configurations_Aleatoire :
      for C in Interval_Nb_Conf_Genere_T loop

         AUnit.Assertions.Assert
            (T.Bloc.Decalage = 0,
            "Le decalage vaut " & T.Bloc.Decalage'Img &
            " au lieu de 0 apres 0 decalages."
            );

         --  Remplissage avec des bits aléatoire
         Generateur_Configuration :
         for I in Intervalle_T loop
            Generateur_De_Bit :
            declare
               B : Bit_T;
            begin
               B := Bit_Aleatoire.Random (Generateur);
               T.Bloc.Ecrire_Bit (I, B);
               Attendu (I) := B;
               if I > 32 then
                  Attendu_Apres_Echange (I - 32) := B;
               else
                  Attendu_Apres_Echange (I + 32) := B;
               end if;
            end Generateur_De_Bit;
         end loop Generateur_Configuration;

         --  Vérification du contenu.
         Verificateur_Configuration_0 :
         for I in Intervalle_T loop
            Verification_Bit_Par_Bit_0 :
            declare
               Bit_Resulta : constant Bit_IO_T :=
                  (if T.Bloc.Lire_Bit (I) then 1 else 0);
               Bit_Attendu : constant Bit_IO_T :=
                  (if Attendu (I) then 1 else 0);
            begin
               AUnit.Assertions.Assert
                  (Bit_Resulta = Bit_Attendu,
                  "Le bit " & I'Img &
                  " vaut : " & Bit_Resulta'Img &
                  " au lieu de " & Bit_Attendu'Img
                  );
            end Verification_Bit_Par_Bit_0;
         end loop Verificateur_Configuration_0;

         T.Bloc.Intervertir_Blocs;

         AUnit.Assertions.Assert
            (T.Bloc.Decalage = 1,
            "Le decalage vaut " & T.Bloc.Decalage'Img &
            " au lieu de 1 apres 1 decalages."
            );

         --  Vérification du contenu.
         Verificateur_Configuration_1 :
         for I in Intervalle_T loop
            Verification_Bit_Par_Bit_1 :
            declare
               Bit_Resulta : constant Bit_IO_T :=
                  (if T.Bloc.Lire_Bit (I) then 1 else 0);
               Bit_Attendu : constant Bit_IO_T :=
                  (if Attendu_Apres_Echange (I) then 1 else 0);
            begin
               AUnit.Assertions.Assert
                  (Bit_Resulta = Bit_Attendu,
                  "Le bit " & I'Img &
                  " vaut : " & Bit_Resulta'Img &
                  " au lieu de " & Bit_Attendu'Img &
                  " APRES 1 echange."
                  );
            end Verification_Bit_Par_Bit_1;
         end loop Verificateur_Configuration_1;

         --  Remise à zéro des décalages
         T.Bloc.Decalage := 0;

      end loop Compteur_Nombre_Configurations_Aleatoire;

   end Test_Bits_Aleatoire_1_Echange;

   ---------------------------------------------------------------------------
   procedure Test_Bits_Aleatoire_Par_Bloc_1_Echange
      (T : in out Test_Fixt_T)
   is
      Attendu_Gauche : Tableau_Bits_32_T;
      Attendu_Droite : Tableau_Bits_32_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      Generateur : Bit_Aleatoire.Generator;
   begin

      Bit_Aleatoire.Reset (Generateur);

      --  Génère un grand nombre de configuration aléatoire
      Compteur_Nombre_Configurations_Aleatoire :
      for C in Interval_Nb_Conf_Genere_T loop

         AUnit.Assertions.Assert
            (T.Bloc.Decalage = 0,
            "Le decalage vaut " & T.Bloc.Decalage'Img &
            " au lieu de 0 apres 0 decalages."
            );

         --  Remplissage avec des bits aléatoire
         Generateur_Configuration :
         for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
            Generateur_De_Bit :
            declare
               B : Bit_T;
            begin
               B := Bit_Aleatoire.Random (Generateur);
               T.Bloc.Ecrire_Bit (A_Gauche, I, B);
               Attendu_Gauche (I) := B;
               B := Bit_Aleatoire.Random (Generateur);
               T.Bloc.Ecrire_Bit (A_Droite, I, B);
               Attendu_Droite (I) := B;
            end Generateur_De_Bit;
         end loop Generateur_Configuration;

         --  Vérification du contenu.
         Verificateur_Configuration_0 :
         for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
            Verification_Bit_Par_Bit_0 :
            declare
               Bit_Resulta, Bit_Attendu : Bit_IO_T;
            begin
               Bit_Resulta := (if T.Bloc.Lire_Bit (A_Gauche, I) then 1 else 0);
               Bit_Attendu := (if Attendu_Gauche (I) then 1 else 0);
               AUnit.Assertions.Assert
                  (Bit_Resulta = Bit_Attendu,
                  "Le bit Bloc GAUCHE " & I'Img &
                  " vaut : " & Bit_Resulta'Img &
                  " au lieu de " & Bit_Attendu'Img
                  );
               Bit_Resulta := (if T.Bloc.Lire_Bit (A_Droite, I) then 1 else 0);
               Bit_Attendu := (if Attendu_Droite (I) then 1 else 0);
               AUnit.Assertions.Assert
                  (Bit_Resulta = Bit_Attendu,
                  "Le bit Bloc DROITE " & I'Img &
                  " vaut : " & Bit_Resulta'Img &
                  " au lieu de " & Bit_Attendu'Img
                  );
            end Verification_Bit_Par_Bit_0;
         end loop Verificateur_Configuration_0;

         T.Bloc.Intervertir_Blocs;

         AUnit.Assertions.Assert
            (T.Bloc.Decalage = 1,
            "Le decalage vaut " & T.Bloc.Decalage'Img &
            " au lieu de 1 apres 1 decalages."
            );

         --  Vérification du contenu.
         Verificateur_Configuration_1 :
         for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
            Verification_Bit_Par_Bit_1 :
            declare
               Bit_Resulta, Bit_Attendu : Bit_IO_T;
            begin
               Bit_Resulta := (if T.Bloc.Lire_Bit (A_Gauche, I) then 1 else 0);
               Bit_Attendu := (if Attendu_Droite (I) then 1 else 0);
               AUnit.Assertions.Assert
                  (Bit_Resulta = Bit_Attendu,
                  "Le bit Bloc GAUCHE " & I'Img &
                  " vaut : " & Bit_Resulta'Img &
                  " au lieu de " & Bit_Attendu'Img &
                  " APRES 1 echange."
                  );
               Bit_Resulta := (if T.Bloc.Lire_Bit (A_Droite, I) then 1 else 0);
               Bit_Attendu := (if Attendu_Gauche (I) then 1 else 0);
               AUnit.Assertions.Assert
                  (Bit_Resulta = Bit_Attendu,
                  "Le bit Bloc DROITE " & I'Img &
                  " vaut : " & Bit_Resulta'Img &
                  " au lieu de " & Bit_Attendu'Img &
                  " APRES 1 echange."
                  );
            end Verification_Bit_Par_Bit_1;
         end loop Verificateur_Configuration_1;

         --  Remise à zéro des décalages
         T.Bloc.Decalage := 0;

      end loop Compteur_Nombre_Configurations_Aleatoire;

   end Test_Bits_Aleatoire_Par_Bloc_1_Echange;

   ---------------------------------------------------------------------------
   procedure Test_Bits_Aleatoire_2_Echanges
      (T : in out Test_Fixt_T)
   is
      Attendu                 : Tableau_Bits_64_T;
      Attendu_Apres_Echange   : Tableau_Bits_64_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      Generateur : Bit_Aleatoire.Generator;
   begin

      Bit_Aleatoire.Reset (Generateur);

      --  Génère un grand nombre de configuration aléatoire
      Compteur_Nombre_Configurations_Aleatoire :
      for C in Interval_Nb_Conf_Genere_T loop

         AUnit.Assertions.Assert
            (T.Bloc.Decalage = 0,
            "Le decalage vaut " & T.Bloc.Decalage'Img &
            " au lieu de 0 apres 0 decalages."
            );

         --  Remplissage avec des bits aléatoire
         Generateur_Configuration :
         for I in Intervalle_T loop
            Generateur_De_Bit :
            declare
               B : constant Bit_T := Bit_Aleatoire.Random (Generateur);
            begin
               T.Bloc.Ecrire_Bit (I, B);
               Attendu (I) := B;
               if I > 32 then
                  Attendu_Apres_Echange (I - 32) := B;
               else
                  Attendu_Apres_Echange (I + 32) := B;
               end if;
            end Generateur_De_Bit;
         end loop Generateur_Configuration;

         --  Vérification du contenu.
         Verificateur_Configuration_0 :
         for I in Intervalle_T loop
            Verification_Bit_Par_Bit_0 :
            declare
               Bit_Resulta : constant Bit_IO_T :=
                  (if T.Bloc.Lire_Bit (I) then 1 else 0);
               Bit_Attendu : constant Bit_IO_T :=
                  (if Attendu (I) then 1 else 0);
            begin
               AUnit.Assertions.Assert
                  (Bit_Resulta = Bit_Attendu,
                  "Le bit " & I'Img &
                  " vaut : " & Bit_Resulta'Img &
                  " au lieu de " & Bit_Attendu'Img
                  );
            end Verification_Bit_Par_Bit_0;
         end loop Verificateur_Configuration_0;

         T.Bloc.Intervertir_Blocs;

         AUnit.Assertions.Assert
            (T.Bloc.Decalage = 1,
            "Le decalage vaut " & T.Bloc.Decalage'Img &
            " au lieu de 1 apres 1 decalages."
            );

         --  Vérification du contenu.
         Verificateur_Configuration_1 :
         for I in Intervalle_T loop
            Verification_Bit_Par_Bit_1 :
            declare
               Bit_Resulta : constant Bit_IO_T :=
                  (if T.Bloc.Lire_Bit (I) then 1 else 0);
               Bit_Attendu : constant Bit_IO_T :=
                  (if Attendu_Apres_Echange (I) then 1 else 0);
            begin
               AUnit.Assertions.Assert
                  (Bit_Resulta = Bit_Attendu,
                  "Le bit " & I'Img &
                  " vaut : " & Bit_Resulta'Img &
                  " au lieu de " & Bit_Attendu'Img &
                  " APRES 1 echange."
                  );
            end Verification_Bit_Par_Bit_1;
         end loop Verificateur_Configuration_1;

         T.Bloc.Intervertir_Blocs;

         AUnit.Assertions.Assert
            (T.Bloc.Decalage = 0,
            "Le decalage vaut " & T.Bloc.Decalage'Img &
            " au lieu de 0 apres 2 decalages."
            );

         --  Vérification du contenu.
         Verificateur_Configuration_2 :
         for I in Intervalle_T loop
            Verification_Bit_Par_Bit_2 :
            declare
               Bit_Resulta : constant Bit_IO_T :=
                  (if T.Bloc.Lire_Bit (I) then 1 else 0);
               Bit_Attendu : constant Bit_IO_T :=
                  (if Attendu (I) then 1 else 0);
            begin
               AUnit.Assertions.Assert
                  (Bit_Resulta = Bit_Attendu,
                  "Le bit " & I'Img &
                  " vaut : " & Bit_Resulta'Img &
                  " au lieu de " & Bit_Attendu'Img &
                  " APRES 2 echange."
                  );
            end Verification_Bit_Par_Bit_2;
         end loop Verificateur_Configuration_2;

         --  Remise à zéro des décalages
         T.Bloc.Decalage := 0;

      end loop Compteur_Nombre_Configurations_Aleatoire;

   end Test_Bits_Aleatoire_2_Echanges;

   ---------------------------------------------------------------------------
   procedure Test_Bits_Aleatoire_Par_Bloc_2_Echanges
      (T : in out Test_Fixt_T)
   is
      Attendu_Gauche : Tableau_Bits_32_T;
      Attendu_Droite : Tableau_Bits_32_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      Generateur : Bit_Aleatoire.Generator;
   begin

      Bit_Aleatoire.Reset (Generateur);

      --  Génère un grand nombre de configuration aléatoire
      Compteur_Nombre_Configurations_Aleatoire :
      for C in Interval_Nb_Conf_Genere_T loop

         AUnit.Assertions.Assert
            (T.Bloc.Decalage = 0,
            "Le decalage vaut " & T.Bloc.Decalage'Img &
            " au lieu de 0 apres 0 decalages."
            );

         --  Remplissage avec des bits aléatoire
         Generateur_Configuration :
         for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
            Generateur_De_Bit :
            declare
               B : Bit_T;
            begin
               B := Bit_Aleatoire.Random (Generateur);
               T.Bloc.Ecrire_Bit (A_Gauche, I, B);
               Attendu_Gauche (I) := B;
               B := Bit_Aleatoire.Random (Generateur);
               T.Bloc.Ecrire_Bit (A_Droite, I, B);
               Attendu_Droite (I) := B;
            end Generateur_De_Bit;
         end loop Generateur_Configuration;

         --  Vérification du contenu.
         Verificateur_Configuration_0 :
         for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
            Verification_Bit_Par_Bit_0 :
            declare
               Bit_Resulta, Bit_Attendu : Bit_IO_T;
            begin
               Bit_Resulta := (if T.Bloc.Lire_Bit (A_Gauche, I) then 1 else 0);
               Bit_Attendu := (if Attendu_Gauche (I) then 1 else 0);
               AUnit.Assertions.Assert
                  (Bit_Resulta = Bit_Attendu,
                  "Le bit Bloc GAUCHE " & I'Img &
                  " vaut : " & Bit_Resulta'Img &
                  " au lieu de " & Bit_Attendu'Img
                  );
               Bit_Resulta := (if T.Bloc.Lire_Bit (A_Droite, I) then 1 else 0);
               Bit_Attendu := (if Attendu_Droite (I) then 1 else 0);
               AUnit.Assertions.Assert
                  (Bit_Resulta = Bit_Attendu,
                  "Le bit Bloc DROITE " & I'Img &
                  " vaut : " & Bit_Resulta'Img &
                  " au lieu de " & Bit_Attendu'Img
                  );
            end Verification_Bit_Par_Bit_0;
         end loop Verificateur_Configuration_0;

         T.Bloc.Intervertir_Blocs;

         AUnit.Assertions.Assert
            (T.Bloc.Decalage = 1,
            "Le decalage vaut " & T.Bloc.Decalage'Img &
            " au lieu de 1 apres 1 decalages."
            );

         --  Vérification du contenu.
         Verificateur_Configuration_1 :
         for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
            Verification_Bit_Par_Bit_1 :
            declare
               Bit_Resulta, Bit_Attendu : Bit_IO_T;
            begin
               Bit_Resulta := (if T.Bloc.Lire_Bit (A_Gauche, I) then 1 else 0);
               Bit_Attendu := (if Attendu_Droite (I) then 1 else 0);
               AUnit.Assertions.Assert
                  (Bit_Resulta = Bit_Attendu,
                  "Le bit Bloc GAUCHE " & I'Img &
                  " vaut : " & Bit_Resulta'Img &
                  " au lieu de " & Bit_Attendu'Img &
                  " APRES 1 echange."
                  );
               Bit_Resulta := (if T.Bloc.Lire_Bit (A_Droite, I) then 1 else 0);
               Bit_Attendu := (if Attendu_Gauche (I) then 1 else 0);
               AUnit.Assertions.Assert
                  (Bit_Resulta = Bit_Attendu,
                  "Le bit Bloc DROITE " & I'Img &
                  " vaut : " & Bit_Resulta'Img &
                  " au lieu de " & Bit_Attendu'Img &
                  " APRES 1 echange."
                  );
            end Verification_Bit_Par_Bit_1;
         end loop Verificateur_Configuration_1;

         T.Bloc.Intervertir_Blocs;

         AUnit.Assertions.Assert
            (T.Bloc.Decalage = 0,
            "Le decalage vaut " & T.Bloc.Decalage'Img &
            " au lieu de 0 apres 2 decalages."
            );

         --  Vérification du contenu.
         Verificateur_Configuration_2 :
         for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
            Verification_Bit_Par_Bit_2 :
            declare
               Bit_Resulta, Bit_Attendu : Bit_IO_T;
            begin
               Bit_Resulta := (if T.Bloc.Lire_Bit (A_Gauche, I) then 1 else 0);
               Bit_Attendu := (if Attendu_Gauche (I) then 1 else 0);
               AUnit.Assertions.Assert
                  (Bit_Resulta = Bit_Attendu,
                  "Le bit Bloc GAUCHE " & I'Img &
                  " vaut : " & Bit_Resulta'Img &
                  " au lieu de " & Bit_Attendu'Img &
                  " APRES 2 echange."
                  );
               Bit_Resulta := (if T.Bloc.Lire_Bit (A_Droite, I) then 1 else 0);
               Bit_Attendu := (if Attendu_Droite (I) then 1 else 0);
               AUnit.Assertions.Assert
                  (Bit_Resulta = Bit_Attendu,
                  "Le bit Bloc DROITE " & I'Img &
                  " vaut : " & Bit_Resulta'Img &
                  " au lieu de " & Bit_Attendu'Img &
                  " APRES 2 echange."
                  );
            end Verification_Bit_Par_Bit_2;
         end loop Verificateur_Configuration_2;

         --  Remise à zéro des décalages
         T.Bloc.Decalage := 0;

      end loop Compteur_Nombre_Configurations_Aleatoire;

   end Test_Bits_Aleatoire_Par_Bloc_2_Echanges;

   ---------------------------------------------------------------------------
   procedure Test_Lecture_Bloc_32_Aleatoire
      (T : in out Test_Fixt_T)
   is
      Attendu_Gauche, Attendu_Droite : Tableau_Bits_32_T;
      Lu_Gauche, Lu_Droite : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      Generateur : Bit_Aleatoire.Generator;
   begin
      Bit_Aleatoire.Reset (Generateur);

      AUnit.Assertions.Assert
         (T.Bloc.Decalage = 0,
         "Le decalage vaut " & T.Bloc.Decalage'Img &
         " au lieu de 0 apres 0 decalages."
         );

      --  Remplissage avec des bits aléatoire
      for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
         Generateur_De_Bit :
         declare
            B : Bit_T;
         begin
            B := Bit_Aleatoire.Random (Generateur);
            T.Bloc.Ecrire_Bit (A_Gauche, I, B);
            Attendu_Gauche (I) := B;
            B := Bit_Aleatoire.Random (Generateur);
            T.Bloc.Ecrire_Bit (A_Droite, I, B);
            Attendu_Droite (I) := B;
         end Generateur_De_Bit;
      end loop;

      --  Vérification du contenu.
      Lu_Gauche := T.Bloc.Lire_Bloc (A_Gauche);
      Lu_Droite := T.Bloc.Lire_Bloc (A_Droite);
      for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
         Verification_Bit_Par_Bit_0 :
         declare
            Bit_Resulta, Bit_Attendu : Bit_IO_T;
         begin
            Bit_Resulta := (if Lu_Gauche.Lire_Bit (I) then 1 else 0);
            Bit_Attendu := (if Attendu_Gauche (I) then 1 else 0);
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit Bloc GAUCHE " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img
               );
            Bit_Resulta := (if Lu_Droite.Lire_Bit (I) then 1 else 0);
            Bit_Attendu := (if Attendu_Droite (I) then 1 else 0);
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit Bloc DROITE " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img
               );
         end Verification_Bit_Par_Bit_0;
      end loop;
   end Test_Lecture_Bloc_32_Aleatoire;

   ---------------------------------------------------------------------------
   procedure Test_Ecriture_Bloc_32_Aleatoire
      (T : in out Test_Fixt_T)
   is
      Attendu_Gauche, Attendu_Droite : Tableau_Bits_32_T;
      Ecrit_Gauche, Ecrit_Droite : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      Generateur : Bit_Aleatoire.Generator;
   begin
      Bit_Aleatoire.Reset (Generateur);

      AUnit.Assertions.Assert
         (T.Bloc.Decalage = 0,
         "Le decalage vaut " & T.Bloc.Decalage'Img &
         " au lieu de 0 apres 0 decalages."
         );

      --  Remplissage avec des bits aléatoire
      for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
         Generateur_De_Bit :
         declare
            B : Bit_T;
         begin
            B := Bit_Aleatoire.Random (Generateur);
            Ecrit_Gauche.Ecrire_Bit (I, B);
            Attendu_Gauche (I) := B;
            B := Bit_Aleatoire.Random (Generateur);
            Ecrit_Droite.Ecrire_Bit (I, B);
            Attendu_Droite (I) := B;
         end Generateur_De_Bit;
      end loop;

      T.Bloc.Ecrire_Bloc (A_Gauche, Ecrit_Gauche);
      T.Bloc.Ecrire_Bloc (A_Droite, Ecrit_Droite);

      --  Vérification du contenu.
      for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
         Verification_Bit_Par_Bit_0 :
         declare
            Bit_Resulta, Bit_Attendu : Bit_IO_T;
         begin
            Bit_Resulta := (if T.Bloc.Lire_Bit (A_Gauche, I) then 1 else 0);
            Bit_Attendu := (if Attendu_Gauche (I) then 1 else 0);
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit Bloc GAUCHE " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img
               );
            Bit_Resulta := (if T.Bloc.Lire_Bit (A_Droite, I) then 1 else 0);
            Bit_Attendu := (if Attendu_Droite (I) then 1 else 0);
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit Bloc DROITE " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img
               );
         end Verification_Bit_Par_Bit_0;
      end loop;
   end Test_Ecriture_Bloc_32_Aleatoire;

   ---------------------------------------------------------------------------
   procedure Test_Lecture_Bloc_32_Aleatoire_1_Echange
      (T : in out Test_Fixt_T)
   is
      Attendu_Gauche, Attendu_Droite : Tableau_Bits_32_T;
      Lu_Gauche, Lu_Droite : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      Generateur : Bit_Aleatoire.Generator;
   begin
      Bit_Aleatoire.Reset (Generateur);

      AUnit.Assertions.Assert
         (T.Bloc.Decalage = 0,
         "Le decalage vaut " & T.Bloc.Decalage'Img &
         " au lieu de 0 apres 0 decalages."
         );

      --  Remplissage avec des bits aléatoire
      for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
         Generateur_De_Bit :
         declare
            B : Bit_T;
         begin
            B := Bit_Aleatoire.Random (Generateur);
            T.Bloc.Ecrire_Bit (A_Gauche, I, B);
            Attendu_Gauche (I) := B;
            B := Bit_Aleatoire.Random (Generateur);
            T.Bloc.Ecrire_Bit (A_Droite, I, B);
            Attendu_Droite (I) := B;
         end Generateur_De_Bit;
      end loop;

      --  Vérification du contenu.
      Lu_Gauche := T.Bloc.Lire_Bloc (A_Gauche);
      Lu_Droite := T.Bloc.Lire_Bloc (A_Droite);
      for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
         Verification_Bit_Par_Bit_0 :
         declare
            Bit_Resulta, Bit_Attendu : Bit_IO_T;
         begin
            Bit_Resulta := (if Lu_Gauche.Lire_Bit (I) then 1 else 0);
            Bit_Attendu := (if Attendu_Gauche (I) then 1 else 0);
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit Bloc GAUCHE " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img
               );
            Bit_Resulta := (if Lu_Droite.Lire_Bit (I) then 1 else 0);
            Bit_Attendu := (if Attendu_Droite (I) then 1 else 0);
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit Bloc DROITE " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img
               );
         end Verification_Bit_Par_Bit_0;
      end loop;

      T.Bloc.Intervertir_Blocs;

      --  Vérification du contenu.
      Lu_Gauche := T.Bloc.Lire_Bloc (A_Gauche);
      Lu_Droite := T.Bloc.Lire_Bloc (A_Droite);
      for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
         Verification_Bit_Par_Bit_1 :
         declare
            Bit_Resulta, Bit_Attendu : Bit_IO_T;
         begin
            Bit_Resulta := (if Lu_Gauche.Lire_Bit (I) then 1 else 0);
            Bit_Attendu := (if Attendu_Droite (I) then 1 else 0);
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit Bloc GAUCHE " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img &
               " APRES 1 echange."
               );
            Bit_Resulta := (if Lu_Droite.Lire_Bit (I) then 1 else 0);
            Bit_Attendu := (if Attendu_Gauche (I) then 1 else 0);
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit Bloc DROITE " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img &
               " APRES 1 echange."
               );
         end Verification_Bit_Par_Bit_1;
      end loop;
   end Test_Lecture_Bloc_32_Aleatoire_1_Echange;

   ---------------------------------------------------------------------------
   procedure Test_Ecriture_Bloc_32_Aleatoire_1_Echange
      (T : in out Test_Fixt_T)
   is
      Attendu_Gauche, Attendu_Droite : Tableau_Bits_32_T;
      Ecrit_Gauche, Ecrit_Droite : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      Generateur : Bit_Aleatoire.Generator;
   begin
      Bit_Aleatoire.Reset (Generateur);

      AUnit.Assertions.Assert
         (T.Bloc.Decalage = 0,
         "Le decalage vaut " & T.Bloc.Decalage'Img &
         " au lieu de 0 apres 0 decalages."
         );

      --  Remplissage avec des bits aléatoire
      for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
         Generateur_De_Bit :
         declare
            B : Bit_T;
         begin
            B := Bit_Aleatoire.Random (Generateur);
            Ecrit_Gauche.Ecrire_Bit (I, B);
            Attendu_Gauche (I) := B;
            B := Bit_Aleatoire.Random (Generateur);
            Ecrit_Droite.Ecrire_Bit (I, B);
            Attendu_Droite (I) := B;
         end Generateur_De_Bit;
      end loop;

      T.Bloc.Ecrire_Bloc (A_Gauche, Ecrit_Gauche);
      T.Bloc.Ecrire_Bloc (A_Droite, Ecrit_Droite);

      --  Vérification du contenu.
      for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
         Verification_Bit_Par_Bit_0 :
         declare
            Bit_Resulta, Bit_Attendu : Bit_IO_T;
         begin
            Bit_Resulta := (if T.Bloc.Lire_Bit (A_Gauche, I) then 1 else 0);
            Bit_Attendu := (if Attendu_Gauche (I) then 1 else 0);
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit Bloc GAUCHE " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img
               );
            Bit_Resulta := (if T.Bloc.Lire_Bit (A_Droite, I) then 1 else 0);
            Bit_Attendu := (if Attendu_Droite (I) then 1 else 0);
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit Bloc DROITE " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img
               );
         end Verification_Bit_Par_Bit_0;
      end loop;

      T.Bloc.Intervertir_Blocs;

      --  Vérification du contenu.
      for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
         Verification_Bit_Par_Bit_1 :
         declare
            Bit_Resulta, Bit_Attendu : Bit_IO_T;
         begin
            Bit_Resulta := (if T.Bloc.Lire_Bit (A_Gauche, I) then 1 else 0);
            Bit_Attendu := (if Attendu_Droite (I) then 1 else 0);
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit Bloc GAUCHE " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img &
               " APRES 1 echange."
               );
            Bit_Resulta := (if T.Bloc.Lire_Bit (A_Droite, I) then 1 else 0);
            Bit_Attendu := (if Attendu_Gauche (I) then 1 else 0);
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit Bloc DROITE " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img &
               " APRES 1 echange."
               );
         end Verification_Bit_Par_Bit_1;
      end loop;

      T.Bloc.Ecrire_Bloc (A_Gauche, Ecrit_Gauche);
      T.Bloc.Ecrire_Bloc (A_Droite, Ecrit_Droite);

      --  Vérification du contenu.
      for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
         Verification_Bit_Par_Bit_1_Bis :
         declare
            Bit_Resulta, Bit_Attendu : Bit_IO_T;
         begin
            Bit_Resulta := (if T.Bloc.Lire_Bit (A_Gauche, I) then 1 else 0);
            Bit_Attendu := (if Attendu_Gauche (I) then 1 else 0);
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit Bloc GAUCHE " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img &
               " APRES 1 echange et apres ecriture des blocs."
               );
            Bit_Resulta := (if T.Bloc.Lire_Bit (A_Droite, I) then 1 else 0);
            Bit_Attendu := (if Attendu_Droite (I) then 1 else 0);
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit Bloc DROITE " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img &
               " APRES 1 echange et apres ecriture des blocs."
               );
         end Verification_Bit_Par_Bit_1_Bis;
      end loop;
   end Test_Ecriture_Bloc_32_Aleatoire_1_Echange;

   ---------------------------------------------------------------------------
   procedure Test_Lecture_Bloc_32_Aleatoire_2_Echange
      (T : in out Test_Fixt_T)
   is
      Attendu_Gauche, Attendu_Droite : Tableau_Bits_32_T;
      Lu_Gauche, Lu_Droite : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      Generateur : Bit_Aleatoire.Generator;
   begin
      Bit_Aleatoire.Reset (Generateur);

      AUnit.Assertions.Assert
         (T.Bloc.Decalage = 0,
         "Le decalage vaut " & T.Bloc.Decalage'Img &
         " au lieu de 0 apres 0 decalages."
         );

      --  Remplissage avec des bits aléatoire
      for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
         Generateur_De_Bit :
         declare
            B : Bit_T;
         begin
            B := Bit_Aleatoire.Random (Generateur);
            T.Bloc.Ecrire_Bit (A_Gauche, I, B);
            Attendu_Gauche (I) := B;
            B := Bit_Aleatoire.Random (Generateur);
            T.Bloc.Ecrire_Bit (A_Droite, I, B);
            Attendu_Droite (I) := B;
         end Generateur_De_Bit;
      end loop;

      --  Vérification du contenu.
      Lu_Gauche := T.Bloc.Lire_Bloc (A_Gauche);
      Lu_Droite := T.Bloc.Lire_Bloc (A_Droite);
      for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
         Verification_Bit_Par_Bit_0 :
         declare
            Bit_Resulta, Bit_Attendu : Bit_IO_T;
         begin
            Bit_Resulta := (if Lu_Gauche.Lire_Bit (I) then 1 else 0);
            Bit_Attendu := (if Attendu_Gauche (I) then 1 else 0);
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit Bloc GAUCHE " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img
               );
            Bit_Resulta := (if Lu_Droite.Lire_Bit (I) then 1 else 0);
            Bit_Attendu := (if Attendu_Droite (I) then 1 else 0);
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit Bloc DROITE " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img
               );
         end Verification_Bit_Par_Bit_0;
      end loop;

      T.Bloc.Intervertir_Blocs;

      --  Vérification du contenu.
      Lu_Gauche := T.Bloc.Lire_Bloc (A_Gauche);
      Lu_Droite := T.Bloc.Lire_Bloc (A_Droite);
      for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
         Verification_Bit_Par_Bit_1 :
         declare
            Bit_Resulta, Bit_Attendu : Bit_IO_T;
         begin
            Bit_Resulta := (if Lu_Gauche.Lire_Bit (I) then 1 else 0);
            Bit_Attendu := (if Attendu_Droite (I) then 1 else 0);
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit Bloc GAUCHE " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img &
               " APRES 1 echange."
               );
            Bit_Resulta := (if Lu_Droite.Lire_Bit (I) then 1 else 0);
            Bit_Attendu := (if Attendu_Gauche (I) then 1 else 0);
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit Bloc DROITE " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img &
               " APRES 1 echange."
               );
         end Verification_Bit_Par_Bit_1;
      end loop;

      T.Bloc.Intervertir_Blocs;

      --  Vérification du contenu.
      Lu_Gauche := T.Bloc.Lire_Bloc (A_Gauche);
      Lu_Droite := T.Bloc.Lire_Bloc (A_Droite);
      for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
         Verification_Bit_Par_Bit_2 :
         declare
            Bit_Resulta, Bit_Attendu : Bit_IO_T;
         begin
            Bit_Resulta := (if Lu_Gauche.Lire_Bit (I) then 1 else 0);
            Bit_Attendu := (if Attendu_Gauche (I) then 1 else 0);
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit Bloc GAUCHE " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img &
               " APRES 2 echange."
               );
            Bit_Resulta := (if Lu_Droite.Lire_Bit (I) then 1 else 0);
            Bit_Attendu := (if Attendu_Droite (I) then 1 else 0);
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit Bloc DROITE " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img &
               " APRES 2 echange."
               );
         end Verification_Bit_Par_Bit_2;
      end loop;
   end Test_Lecture_Bloc_32_Aleatoire_2_Echange;

   ---------------------------------------------------------------------------
   procedure Test_Ecriture_Bloc_32_Aleatoire_2_Echange
      (T : in out Test_Fixt_T)
   is
      Attendu_Gauche, Attendu_Droite : Tableau_Bits_32_T;
      Ecrit_Gauche, Ecrit_Droite : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      Generateur : Bit_Aleatoire.Generator;
   begin
      Bit_Aleatoire.Reset (Generateur);

      AUnit.Assertions.Assert
         (T.Bloc.Decalage = 0,
         "Le decalage vaut " & T.Bloc.Decalage'Img &
         " au lieu de 0 apres 0 decalages."
         );

      --  Remplissage avec des bits aléatoire
      for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
         Generateur_De_Bit :
         declare
            B : Bit_T;
         begin
            B := Bit_Aleatoire.Random (Generateur);
            Ecrit_Gauche.Ecrire_Bit (I, B);
            Attendu_Gauche (I) := B;
            B := Bit_Aleatoire.Random (Generateur);
            Ecrit_Droite.Ecrire_Bit (I, B);
            Attendu_Droite (I) := B;
         end Generateur_De_Bit;
      end loop;

      T.Bloc.Ecrire_Bloc (A_Gauche, Ecrit_Gauche);
      T.Bloc.Ecrire_Bloc (A_Droite, Ecrit_Droite);

      --  Vérification du contenu.
      for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
         Verification_Bit_Par_Bit_0 :
         declare
            Bit_Resulta, Bit_Attendu : Bit_IO_T;
         begin
            Bit_Resulta := (if T.Bloc.Lire_Bit (A_Gauche, I) then 1 else 0);
            Bit_Attendu := (if Attendu_Gauche (I) then 1 else 0);
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit Bloc GAUCHE " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img
               );
            Bit_Resulta := (if T.Bloc.Lire_Bit (A_Droite, I) then 1 else 0);
            Bit_Attendu := (if Attendu_Droite (I) then 1 else 0);
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit Bloc DROITE " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img
               );
         end Verification_Bit_Par_Bit_0;
      end loop;

      T.Bloc.Intervertir_Blocs;

      --  Vérification du contenu.
      for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
         Verification_Bit_Par_Bit_1 :
         declare
            Bit_Resulta, Bit_Attendu : Bit_IO_T;
         begin
            Bit_Resulta := (if T.Bloc.Lire_Bit (A_Gauche, I) then 1 else 0);
            Bit_Attendu := (if Attendu_Droite (I) then 1 else 0);
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit Bloc GAUCHE " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img &
               " APRES 1 echange."
               );
            Bit_Resulta := (if T.Bloc.Lire_Bit (A_Droite, I) then 1 else 0);
            Bit_Attendu := (if Attendu_Gauche (I) then 1 else 0);
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit Bloc DROITE " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img &
               " APRES 1 echange."
               );
         end Verification_Bit_Par_Bit_1;
      end loop;

      T.Bloc.Ecrire_Bloc (A_Gauche, Ecrit_Gauche);
      T.Bloc.Ecrire_Bloc (A_Droite, Ecrit_Droite);

      --  Vérification du contenu.
      for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
         Verification_Bit_Par_Bit_1_Bis :
         declare
            Bit_Resulta, Bit_Attendu : Bit_IO_T;
         begin
            Bit_Resulta := (if T.Bloc.Lire_Bit (A_Gauche, I) then 1 else 0);
            Bit_Attendu := (if Attendu_Gauche (I) then 1 else 0);
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit Bloc GAUCHE " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img &
               " APRES 1 echange et apres ecriture des blocs."
               );
            Bit_Resulta := (if T.Bloc.Lire_Bit (A_Droite, I) then 1 else 0);
            Bit_Attendu := (if Attendu_Droite (I) then 1 else 0);
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit Bloc DROITE " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img &
               " APRES 1 echange et apres ecriture des blocs."
               );
         end Verification_Bit_Par_Bit_1_Bis;
      end loop;

      T.Bloc.Intervertir_Blocs;

      --  Vérification du contenu.
      for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
         Verification_Bit_Par_Bit_2 :
         declare
            Bit_Resulta, Bit_Attendu : Bit_IO_T;
         begin
            Bit_Resulta := (if T.Bloc.Lire_Bit (A_Gauche, I) then 1 else 0);
            Bit_Attendu := (if Attendu_Droite (I) then 1 else 0);
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit Bloc GAUCHE " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img &
               " APRES 2 echange."
               );
            Bit_Resulta := (if T.Bloc.Lire_Bit (A_Droite, I) then 1 else 0);
            Bit_Attendu := (if Attendu_Gauche (I) then 1 else 0);
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit Bloc DROITE " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img &
               " APRES 2 echange."
               );
         end Verification_Bit_Par_Bit_2;
      end loop;

      T.Bloc.Ecrire_Bloc (A_Gauche, Ecrit_Gauche);
      T.Bloc.Ecrire_Bloc (A_Droite, Ecrit_Droite);

      --  Vérification du contenu.
      for I in Des_P.Bloc_P.Bloc_32_P.Intervalle_T loop
         Verification_Bit_Par_Bit_2_Bis :
         declare
            Bit_Resulta, Bit_Attendu : Bit_IO_T;
         begin
            Bit_Resulta := (if T.Bloc.Lire_Bit (A_Gauche, I) then 1 else 0);
            Bit_Attendu := (if Attendu_Gauche (I) then 1 else 0);
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit Bloc GAUCHE " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img &
               " APRES 2 echange et apres ecriture des blocs."
               );
            Bit_Resulta := (if T.Bloc.Lire_Bit (A_Droite, I) then 1 else 0);
            Bit_Attendu := (if Attendu_Droite (I) then 1 else 0);
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit Bloc DROITE " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img &
               " APRES 2 echange et apres ecriture des blocs."
               );
         end Verification_Bit_Par_Bit_2_Bis;
      end loop;
   end Test_Ecriture_Bloc_32_Aleatoire_2_Echange;

end Des_P.Bloc_P.Bloc_64_P.Test_P;
