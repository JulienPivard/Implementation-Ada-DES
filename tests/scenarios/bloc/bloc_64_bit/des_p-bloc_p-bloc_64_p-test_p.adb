with AUnit.Assertions;

with Ada.Numerics.Discrete_Random;

with Des_P.Bloc_P.Bloc_32_P;
use  Des_P.Bloc_P.Bloc_32_P;

package body Des_P.Bloc_P.Bloc_64_P.Test_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      b : Bloc_64_T;
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
      b : constant Bit_IO_T := 0;
      valeur_bit : Bit_IO_T;
   begin
      AUnit.Assertions.Assert
         (T.bloc.Decalage = 0,
         "Le decalage vaut " & T.bloc.Decalage'Img &
         " au lieu de 0 apres 0 decalages."
         );
      for I in Intervalle_Bloc_64_T'Range loop
         valeur_bit := (if T.bloc.Lire_Bit (I) then 1 else 0);
         AUnit.Assertions.Assert
            (valeur_bit = b,
            "Le bit " & I'Img &
            " vaut : " & valeur_bit'Img &
            " au lieu de 0"
            );
      end loop;
   end Test_Initialisation;

   ---------------------------------------------------------------------------
   procedure Test_Bits_Aleatoire
      (T : in out Test_Fixt_T)
   is
      b : Bit_T;
      attendu : array (Intervalle_Bloc_64_T) of Bit_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      generateur : Bit_Aleatoire.Generator;
      bit_resulta, bit_attendu : Bit_IO_T;
   begin

      Bit_Aleatoire.Reset (generateur);

      --  Remplissage avec des bits aléatoire
      for I in Intervalle_Bloc_64_T'Range loop
         b := Bit_Aleatoire.Random (generateur);
         T.bloc.Ecrire_Bit (I, b);
         attendu (I) := b;
      end loop;

      --  Vérification du contenu.
      for I in Intervalle_Bloc_64_T'Range loop
         bit_resulta := (if T.bloc.Lire_Bit (I) then 1 else 0);
         bit_attendu := (if attendu (I) then 1 else 0);
         AUnit.Assertions.Assert
            (bit_resulta = bit_attendu,
            "Le bit " & I'Img &
            " vaut : " & bit_resulta'Img &
            " au lieu de " & bit_attendu'Img
            );
      end loop;

   end Test_Bits_Aleatoire;

   ---------------------------------------------------------------------------
   procedure Test_Bits_Aleatoire_Par_Bloc
      (T : in out Test_Fixt_T)
   is
      b : Bit_T;
      attendu_gauche : array (Intervalle_Bloc_32_T) of Bit_T;
      attendu_droite : array (Intervalle_Bloc_32_T) of Bit_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      generateur : Bit_Aleatoire.Generator;
      bit_resulta, bit_attendu : Bit_IO_T;
   begin

      Bit_Aleatoire.Reset (generateur);

      --  Remplissage avec des bits aléatoire
      for I in Intervalle_Bloc_32_T'Range loop
         b := Bit_Aleatoire.Random (generateur);
         T.bloc.Ecrire_Bit (Gauche, I, b);
         attendu_gauche (I) := b;
         b := Bit_Aleatoire.Random (generateur);
         T.bloc.Ecrire_Bit (Droite, I, b);
         attendu_droite (I) := b;
      end loop;

      --  Vérification du contenu.
      for I in Intervalle_Bloc_32_T'Range loop
         bit_resulta := (if T.bloc.Lire_Bit (Gauche, I) then 1 else 0);
         bit_attendu := (if attendu_gauche (I) then 1 else 0);
         AUnit.Assertions.Assert
            (bit_resulta = bit_attendu,
            "Le bit bloc GAUCHE " & I'Img &
            " vaut : " & bit_resulta'Img &
            " au lieu de " & bit_attendu'Img
            );
         bit_resulta := (if T.bloc.Lire_Bit (Droite, I) then 1 else 0);
         bit_attendu := (if attendu_droite (I) then 1 else 0);
         AUnit.Assertions.Assert
            (bit_resulta = bit_attendu,
            "Le bit bloc DROITE " & I'Img &
            " vaut : " & bit_resulta'Img &
            " au lieu de " & bit_attendu'Img
            );
      end loop;

   end Test_Bits_Aleatoire_Par_Bloc;

   ---------------------------------------------------------------------------
   procedure Test_Bits_Aleatoire_1_Echange
      (T : in out Test_Fixt_T)
   is
      b : Bit_T;
      attendu : array (Intervalle_Bloc_64_T) of Bit_T;
      attendu_apres_echange : array (Intervalle_Bloc_64_T) of Bit_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      generateur : Bit_Aleatoire.Generator;
      bit_resulta, bit_attendu : Bit_IO_T;
   begin

      Bit_Aleatoire.Reset (generateur);

      AUnit.Assertions.Assert
         (T.bloc.Decalage = 0,
         "Le decalage vaut " & T.bloc.Decalage'Img &
         " au lieu de 0 apres 0 decalages."
         );

      --  Remplissage avec des bits aléatoire
      for I in Intervalle_Bloc_64_T'Range loop
         b := Bit_Aleatoire.Random (generateur);
         T.bloc.Ecrire_Bit (I, b);
         attendu (I) := b;
         if I > 32 then
            attendu_apres_echange (I - 32) := b;
         else
            attendu_apres_echange (I + 32) := b;
         end if;
      end loop;

      --  Vérification du contenu.
      for I in Intervalle_Bloc_64_T'Range loop
         bit_resulta := (if T.bloc.Lire_Bit (I) then 1 else 0);
         bit_attendu := (if attendu (I) then 1 else 0);
         AUnit.Assertions.Assert
            (bit_resulta = bit_attendu,
            "Le bit " & I'Img &
            " vaut : " & bit_resulta'Img &
            " au lieu de " & bit_attendu'Img
            );
      end loop;

      T.bloc.Intervertir_Blocs;

      AUnit.Assertions.Assert
         (T.bloc.Decalage = 1,
         "Le decalage vaut " & T.bloc.Decalage'Img &
         " au lieu de 1 apres 1 decalages."
         );

      --  Vérification du contenu.
      for I in Intervalle_Bloc_64_T'Range loop
         bit_resulta := (if T.bloc.Lire_Bit (I) then 1 else 0);
         bit_attendu := (if attendu_apres_echange (I) then 1 else 0);
         AUnit.Assertions.Assert
            (bit_resulta = bit_attendu,
            "Le bit " & I'Img &
            " vaut : " & bit_resulta'Img &
            " au lieu de " & bit_attendu'Img &
            " APRES 1 echange."
            );
      end loop;

   end Test_Bits_Aleatoire_1_Echange;

   ---------------------------------------------------------------------------
   procedure Test_Bits_Aleatoire_Par_Bloc_1_Echange
      (T : in out Test_Fixt_T)
   is
      b : Bit_T;
      attendu_gauche : array (Intervalle_Bloc_32_T) of Bit_T;
      attendu_droite : array (Intervalle_Bloc_32_T) of Bit_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      generateur : Bit_Aleatoire.Generator;
      bit_resulta, bit_attendu : Bit_IO_T;
   begin

      Bit_Aleatoire.Reset (generateur);

      AUnit.Assertions.Assert
         (T.bloc.Decalage = 0,
         "Le decalage vaut " & T.bloc.Decalage'Img &
         " au lieu de 0 apres 0 decalages."
         );

      --  Remplissage avec des bits aléatoire
      for I in Intervalle_Bloc_32_T'Range loop
         b := Bit_Aleatoire.Random (generateur);
         T.bloc.Ecrire_Bit (Gauche, I, b);
         attendu_gauche (I) := b;
         b := Bit_Aleatoire.Random (generateur);
         T.bloc.Ecrire_Bit (Droite, I, b);
         attendu_droite (I) := b;
      end loop;

      --  Vérification du contenu.
      for I in Intervalle_Bloc_32_T'Range loop
         bit_resulta := (if T.bloc.Lire_Bit (Gauche, I) then 1 else 0);
         bit_attendu := (if attendu_gauche (I) then 1 else 0);
         AUnit.Assertions.Assert
            (bit_resulta = bit_attendu,
            "Le bit bloc GAUCHE " & I'Img &
            " vaut : " & bit_resulta'Img &
            " au lieu de " & bit_attendu'Img
            );
         bit_resulta := (if T.bloc.Lire_Bit (Droite, I) then 1 else 0);
         bit_attendu := (if attendu_droite (I) then 1 else 0);
         AUnit.Assertions.Assert
            (bit_resulta = bit_attendu,
            "Le bit bloc DROITE " & I'Img &
            " vaut : " & bit_resulta'Img &
            " au lieu de " & bit_attendu'Img
            );
      end loop;

      T.bloc.Intervertir_Blocs;

      AUnit.Assertions.Assert
         (T.bloc.Decalage = 1,
         "Le decalage vaut " & T.bloc.Decalage'Img &
         " au lieu de 1 apres 1 decalages."
         );

      --  Vérification du contenu.
      for I in Intervalle_Bloc_32_T'Range loop
         bit_resulta := (if T.bloc.Lire_Bit (Gauche, I) then 1 else 0);
         bit_attendu := (if attendu_droite (I) then 1 else 0);
         AUnit.Assertions.Assert
            (bit_resulta = bit_attendu,
            "Le bit bloc GAUCHE " & I'Img &
            " vaut : " & bit_resulta'Img &
            " au lieu de " & bit_attendu'Img &
            " APRES 1 echange."
            );
         bit_resulta := (if T.bloc.Lire_Bit (Droite, I) then 1 else 0);
         bit_attendu := (if attendu_gauche (I) then 1 else 0);
         AUnit.Assertions.Assert
            (bit_resulta = bit_attendu,
            "Le bit bloc DROITE " & I'Img &
            " vaut : " & bit_resulta'Img &
            " au lieu de " & bit_attendu'Img &
            " APRES 1 echange."
            );
      end loop;

   end Test_Bits_Aleatoire_Par_Bloc_1_Echange;

   ---------------------------------------------------------------------------
   procedure Test_Bits_Aleatoire_2_Echanges
      (T : in out Test_Fixt_T)
   is
      b : Bit_T;
      attendu : array (Intervalle_Bloc_64_T) of Bit_T;
      attendu_apres_echange : array (Intervalle_Bloc_64_T) of Bit_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      generateur : Bit_Aleatoire.Generator;
      bit_resulta, bit_attendu : Bit_IO_T;
   begin

      Bit_Aleatoire.Reset (generateur);

      AUnit.Assertions.Assert
         (T.bloc.Decalage = 0,
         "Le decalage vaut " & T.bloc.Decalage'Img &
         " au lieu de 0 apres 0 decalages."
         );

      --  Remplissage avec des bits aléatoire
      for I in Intervalle_Bloc_64_T'Range loop
         b := Bit_Aleatoire.Random (generateur);
         T.bloc.Ecrire_Bit (I, b);
         attendu (I) := b;
         if I > 32 then
            attendu_apres_echange (I - 32) := b;
         else
            attendu_apres_echange (I + 32) := b;
         end if;
      end loop;

      --  Vérification du contenu.
      for I in Intervalle_Bloc_64_T'Range loop
         bit_resulta := (if T.bloc.Lire_Bit (I) then 1 else 0);
         bit_attendu := (if attendu (I) then 1 else 0);
         AUnit.Assertions.Assert
            (bit_resulta = bit_attendu,
            "Le bit " & I'Img &
            " vaut : " & bit_resulta'Img &
            " au lieu de " & bit_attendu'Img
            );
      end loop;

      T.bloc.Intervertir_Blocs;

      AUnit.Assertions.Assert
         (T.bloc.Decalage = 1,
         "Le decalage vaut " & T.bloc.Decalage'Img &
         " au lieu de 1 apres 1 decalages."
         );

      --  Vérification du contenu.
      for I in Intervalle_Bloc_64_T'Range loop
         bit_resulta := (if T.bloc.Lire_Bit (I) then 1 else 0);
         bit_attendu := (if attendu_apres_echange (I) then 1 else 0);
         AUnit.Assertions.Assert
            (bit_resulta = bit_attendu,
            "Le bit " & I'Img &
            " vaut : " & bit_resulta'Img &
            " au lieu de " & bit_attendu'Img &
            " APRES 1 echange."
            );
      end loop;

      T.bloc.Intervertir_Blocs;

      AUnit.Assertions.Assert
         (T.bloc.Decalage = 0,
         "Le decalage vaut " & T.bloc.Decalage'Img &
         " au lieu de 0 apres 2 decalages."
         );

      --  Vérification du contenu.
      for I in Intervalle_Bloc_64_T'Range loop
         bit_resulta := (if T.bloc.Lire_Bit (I) then 1 else 0);
         bit_attendu := (if attendu (I) then 1 else 0);
         AUnit.Assertions.Assert
            (bit_resulta = bit_attendu,
            "Le bit " & I'Img &
            " vaut : " & bit_resulta'Img &
            " au lieu de " & bit_attendu'Img &
            " APRES 2 echange."
            );
      end loop;

   end Test_Bits_Aleatoire_2_Echanges;

   ---------------------------------------------------------------------------
   procedure Test_Bits_Aleatoire_Par_Bloc_2_Echanges
      (T : in out Test_Fixt_T)
   is
      b : Bit_T;
      attendu_gauche : array (Intervalle_Bloc_32_T) of Bit_T;
      attendu_droite : array (Intervalle_Bloc_32_T) of Bit_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      generateur : Bit_Aleatoire.Generator;
      bit_resulta, bit_attendu : Bit_IO_T;
   begin

      Bit_Aleatoire.Reset (generateur);

      AUnit.Assertions.Assert
         (T.bloc.Decalage = 0,
         "Le decalage vaut " & T.bloc.Decalage'Img &
         " au lieu de 0 apres 0 decalages."
         );

      --  Remplissage avec des bits aléatoire
      for I in Intervalle_Bloc_32_T'Range loop
         b := Bit_Aleatoire.Random (generateur);
         T.bloc.Ecrire_Bit (Gauche, I, b);
         attendu_gauche (I) := b;
         b := Bit_Aleatoire.Random (generateur);
         T.bloc.Ecrire_Bit (Droite, I, b);
         attendu_droite (I) := b;
      end loop;

      --  Vérification du contenu.
      for I in Intervalle_Bloc_32_T'Range loop
         bit_resulta := (if T.bloc.Lire_Bit (Gauche, I) then 1 else 0);
         bit_attendu := (if attendu_gauche (I) then 1 else 0);
         AUnit.Assertions.Assert
            (bit_resulta = bit_attendu,
            "Le bit bloc GAUCHE " & I'Img &
            " vaut : " & bit_resulta'Img &
            " au lieu de " & bit_attendu'Img
            );
         bit_resulta := (if T.bloc.Lire_Bit (Droite, I) then 1 else 0);
         bit_attendu := (if attendu_droite (I) then 1 else 0);
         AUnit.Assertions.Assert
            (bit_resulta = bit_attendu,
            "Le bit bloc DROITE " & I'Img &
            " vaut : " & bit_resulta'Img &
            " au lieu de " & bit_attendu'Img
            );
      end loop;

      T.bloc.Intervertir_Blocs;

      AUnit.Assertions.Assert
         (T.bloc.Decalage = 1,
         "Le decalage vaut " & T.bloc.Decalage'Img &
         " au lieu de 1 apres 1 decalages."
         );

      --  Vérification du contenu.
      for I in Intervalle_Bloc_32_T'Range loop
         bit_resulta := (if T.bloc.Lire_Bit (Gauche, I) then 1 else 0);
         bit_attendu := (if attendu_droite (I) then 1 else 0);
         AUnit.Assertions.Assert
            (bit_resulta = bit_attendu,
            "Le bit bloc GAUCHE " & I'Img &
            " vaut : " & bit_resulta'Img &
            " au lieu de " & bit_attendu'Img &
            " APRES 1 echange."
            );
         bit_resulta := (if T.bloc.Lire_Bit (Droite, I) then 1 else 0);
         bit_attendu := (if attendu_gauche (I) then 1 else 0);
         AUnit.Assertions.Assert
            (bit_resulta = bit_attendu,
            "Le bit bloc DROITE " & I'Img &
            " vaut : " & bit_resulta'Img &
            " au lieu de " & bit_attendu'Img &
            " APRES 1 echange."
            );
      end loop;

      T.bloc.Intervertir_Blocs;

      AUnit.Assertions.Assert
         (T.bloc.Decalage = 0,
         "Le decalage vaut " & T.bloc.Decalage'Img &
         " au lieu de 0 apres 2 decalages."
         );

      --  Vérification du contenu.
      for I in Intervalle_Bloc_32_T'Range loop
         bit_resulta := (if T.bloc.Lire_Bit (Gauche, I) then 1 else 0);
         bit_attendu := (if attendu_gauche (I) then 1 else 0);
         AUnit.Assertions.Assert
            (bit_resulta = bit_attendu,
            "Le bit bloc GAUCHE " & I'Img &
            " vaut : " & bit_resulta'Img &
            " au lieu de " & bit_attendu'Img &
            " APRES 2 echange."
            );
         bit_resulta := (if T.bloc.Lire_Bit (Droite, I) then 1 else 0);
         bit_attendu := (if attendu_droite (I) then 1 else 0);
         AUnit.Assertions.Assert
            (bit_resulta = bit_attendu,
            "Le bit bloc DROITE " & I'Img &
            " vaut : " & bit_resulta'Img &
            " au lieu de " & bit_attendu'Img &
            " APRES 2 echange."
            );
      end loop;

   end Test_Bits_Aleatoire_Par_Bloc_2_Echanges;

end Des_P.Bloc_P.Bloc_64_P.Test_P;
