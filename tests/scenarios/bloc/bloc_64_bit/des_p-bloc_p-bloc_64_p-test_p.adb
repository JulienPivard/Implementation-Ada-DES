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
      b : constant Bit_T := 0;
   begin
      AUnit.Assertions.Assert
         (T.bloc.Decalage = 0,
         "Le decalage vaut " & T.bloc.Decalage'Img &
         " au lieu de 0 apres 0 decalages."
         );
      for I in Intervalle_Bloc_64_T'Range loop
         AUnit.Assertions.Assert
            (T.bloc.Lire_Bit (I) = b,
            "Le bit " & I'Img &
            " vaut : " & T.bloc.Lire_Bit (I)'Img &
            " au lieu de " & b'Img
            );
      end loop;
   end Test_Initialisation;

   ---------------------------------------------------------------------------
   procedure Test_Bits_Aleatoire
      (T : in out Test_Fixt_T)
   is
      b : Bit_T;
      attendu : array
         (Intervalle_Bloc_64_T range Intervalle_Bloc_64_T'Range)
         of Bit_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      generateur : Bit_Aleatoire.Generator;
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
         AUnit.Assertions.Assert
            (T.bloc.Lire_Bit (I) = attendu (I),
            "Le bit " & I'Img &
            " vaut : " & T.bloc.Lire_Bit (I)'Img &
            " au lieu de " & attendu (I)'Img
            );
      end loop;

   end Test_Bits_Aleatoire;

   ---------------------------------------------------------------------------
   procedure Test_Bits_Aleatoire_Par_Bloc
      (T : in out Test_Fixt_T)
   is
      b : Bit_T;
      attendu_gauche : array
         (Intervalle_Bloc_32_T range Intervalle_Bloc_32_T'Range)
         of Bit_T;
      attendu_droite : array
         (Intervalle_Bloc_32_T range Intervalle_Bloc_32_T'Range)
         of Bit_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      generateur : Bit_Aleatoire.Generator;
   begin

      Bit_Aleatoire.Reset (generateur);

      --  Remplissage avec des bits aléatoire
      for I in Intervalle_Bloc_32_T'Range loop
         b := Bit_Aleatoire.Random (generateur);
         T.bloc.Ecrire_Bit_Bloc (Gauche, I, b);
         attendu_gauche (I) := b;
         b := Bit_Aleatoire.Random (generateur);
         T.bloc.Ecrire_Bit_Bloc (Droite, I, b);
         attendu_droite (I) := b;
      end loop;

      --  Vérification du contenu.
      for I in Intervalle_Bloc_32_T'Range loop
         AUnit.Assertions.Assert
            (T.bloc.Lire_Bit_Bloc (Gauche, I) = attendu_gauche (I),
            "Le bit bloc GAUCHE " & I'Img &
            " vaut : " & T.bloc.Lire_Bit_Bloc (Gauche, I)'Img &
            " au lieu de " & attendu_gauche (I)'Img
            );
         AUnit.Assertions.Assert
            (T.bloc.Lire_Bit_Bloc (Droite, I) = attendu_droite (I),
            "Le bit bloc DROITE " & I'Img &
            " vaut : " & T.bloc.Lire_Bit_Bloc (Droite, I)'Img &
            " au lieu de " & attendu_droite (I)'Img
            );
      end loop;

   end Test_Bits_Aleatoire_Par_Bloc;

   ---------------------------------------------------------------------------
   procedure Test_Bits_Aleatoire_1_Echange
      (T : in out Test_Fixt_T)
   is
      b : Bit_T;
      attendu : array
         (Intervalle_Bloc_64_T range Intervalle_Bloc_64_T'Range)
         of Bit_T;
      attendu_apres_echange : array
         (Intervalle_Bloc_64_T range Intervalle_Bloc_64_T'Range)
         of Bit_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      generateur : Bit_Aleatoire.Generator;
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
         AUnit.Assertions.Assert
            (T.bloc.Lire_Bit (I) = attendu (I),
            "Le bit " & I'Img &
            " vaut : " & T.bloc.Lire_Bit (I)'Img &
            " au lieu de " & attendu (I)'Img
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
         AUnit.Assertions.Assert
            (T.bloc.Lire_Bit (I) = attendu_apres_echange (I),
            "Le bit " & I'Img &
            " vaut : " & T.bloc.Lire_Bit (I)'Img &
            " au lieu de " & attendu_apres_echange (I)'Img &
            " APRES 1 echange."
            );
      end loop;

   end Test_Bits_Aleatoire_1_Echange;

   ---------------------------------------------------------------------------
   procedure Test_Bits_Aleatoire_Par_Bloc_1_Echange
      (T : in out Test_Fixt_T)
   is
      b : Bit_T;
      attendu_gauche : array
         (Intervalle_Bloc_32_T range Intervalle_Bloc_32_T'Range)
         of Bit_T;
      attendu_droite : array
         (Intervalle_Bloc_32_T range Intervalle_Bloc_32_T'Range)
         of Bit_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      generateur : Bit_Aleatoire.Generator;
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
         T.bloc.Ecrire_Bit_Bloc (Gauche, I, b);
         attendu_gauche (I) := b;
         b := Bit_Aleatoire.Random (generateur);
         T.bloc.Ecrire_Bit_Bloc (Droite, I, b);
         attendu_droite (I) := b;
      end loop;

      --  Vérification du contenu.
      for I in Intervalle_Bloc_32_T'Range loop
         AUnit.Assertions.Assert
            (T.bloc.Lire_Bit_Bloc (Gauche, I) = attendu_gauche (I),
            "Le bit bloc GAUCHE " & I'Img &
            " vaut : " & T.bloc.Lire_Bit_Bloc (Gauche, I)'Img &
            " au lieu de " & attendu_gauche (I)'Img
            );
         AUnit.Assertions.Assert
            (T.bloc.Lire_Bit_Bloc (Droite, I) = attendu_droite (I),
            "Le bit bloc DROITE " & I'Img &
            " vaut : " & T.bloc.Lire_Bit_Bloc (Droite, I)'Img &
            " au lieu de " & attendu_droite (I)'Img
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
         AUnit.Assertions.Assert
            (T.bloc.Lire_Bit_Bloc (Gauche, I) = attendu_droite (I),
            "Le bit bloc GAUCHE " & I'Img &
            " vaut : " & T.bloc.Lire_Bit_Bloc (Gauche, I)'Img &
            " au lieu de " & attendu_droite (I)'Img &
            " APRES 1 echange."
            );
         AUnit.Assertions.Assert
            (T.bloc.Lire_Bit_Bloc (Droite, I) = attendu_gauche (I),
            "Le bit bloc DROITE " & I'Img &
            " vaut : " & T.bloc.Lire_Bit_Bloc (Droite, I)'Img &
            " au lieu de " & attendu_gauche (I)'Img &
            " APRES 1 echange."
            );
      end loop;

   end Test_Bits_Aleatoire_Par_Bloc_1_Echange;

   ---------------------------------------------------------------------------
   procedure Test_Bits_Aleatoire_2_Echanges
      (T : in out Test_Fixt_T)
   is
      b : Bit_T;
      attendu : array
         (Intervalle_Bloc_64_T range Intervalle_Bloc_64_T'Range)
         of Bit_T;
      attendu_apres_echange : array
         (Intervalle_Bloc_64_T range Intervalle_Bloc_64_T'Range)
         of Bit_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      generateur : Bit_Aleatoire.Generator;
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
         AUnit.Assertions.Assert
            (T.bloc.Lire_Bit (I) = attendu (I),
            "Le bit " & I'Img &
            " vaut : " & T.bloc.Lire_Bit (I)'Img &
            " au lieu de " & attendu (I)'Img
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
         AUnit.Assertions.Assert
            (T.bloc.Lire_Bit (I) = attendu_apres_echange (I),
            "Le bit " & I'Img &
            " vaut : " & T.bloc.Lire_Bit (I)'Img &
            " au lieu de " & attendu_apres_echange (I)'Img &
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
         AUnit.Assertions.Assert
            (T.bloc.Lire_Bit (I) = attendu (I),
            "Le bit " & I'Img &
            " vaut : " & T.bloc.Lire_Bit (I)'Img &
            " au lieu de " & attendu (I)'Img
            );
      end loop;

   end Test_Bits_Aleatoire_2_Echanges;

   ---------------------------------------------------------------------------
   procedure Test_Bits_Aleatoire_Par_Bloc_2_Echanges
      (T : in out Test_Fixt_T)
   is
      b : Bit_T;
      attendu_gauche : array
         (Intervalle_Bloc_32_T range Intervalle_Bloc_32_T'Range)
         of Bit_T;
      attendu_droite : array
         (Intervalle_Bloc_32_T range Intervalle_Bloc_32_T'Range)
         of Bit_T;
      package Bit_Aleatoire is new Ada.Numerics.Discrete_Random (Bit_T);
      generateur : Bit_Aleatoire.Generator;
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
         T.bloc.Ecrire_Bit_Bloc (Gauche, I, b);
         attendu_gauche (I) := b;
         b := Bit_Aleatoire.Random (generateur);
         T.bloc.Ecrire_Bit_Bloc (Droite, I, b);
         attendu_droite (I) := b;
      end loop;

      --  Vérification du contenu.
      for I in Intervalle_Bloc_32_T'Range loop
         AUnit.Assertions.Assert
            (T.bloc.Lire_Bit_Bloc (Gauche, I) = attendu_gauche (I),
            "Le bit bloc GAUCHE " & I'Img &
            " vaut : " & T.bloc.Lire_Bit_Bloc (Gauche, I)'Img &
            " au lieu de " & attendu_gauche (I)'Img
            );
         AUnit.Assertions.Assert
            (T.bloc.Lire_Bit_Bloc (Droite, I) = attendu_droite (I),
            "Le bit bloc DROITE " & I'Img &
            " vaut : " & T.bloc.Lire_Bit_Bloc (Droite, I)'Img &
            " au lieu de " & attendu_droite (I)'Img
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
         AUnit.Assertions.Assert
            (T.bloc.Lire_Bit_Bloc (Gauche, I) = attendu_droite (I),
            "Le bit bloc GAUCHE " & I'Img &
            " vaut : " & T.bloc.Lire_Bit_Bloc (Gauche, I)'Img &
            " au lieu de " & attendu_droite (I)'Img &
            " APRES 1 echange."
            );
         AUnit.Assertions.Assert
            (T.bloc.Lire_Bit_Bloc (Droite, I) = attendu_gauche (I),
            "Le bit bloc DROITE " & I'Img &
            " vaut : " & T.bloc.Lire_Bit_Bloc (Droite, I)'Img &
            " au lieu de " & attendu_gauche (I)'Img &
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
         AUnit.Assertions.Assert
            (T.bloc.Lire_Bit_Bloc (Gauche, I) = attendu_gauche (I),
            "Le bit bloc GAUCHE " & I'Img &
            " vaut : " & T.bloc.Lire_Bit_Bloc (Gauche, I)'Img &
            " au lieu de " & attendu_gauche (I)'Img &
            " APRES 2 echanges."
            );
         AUnit.Assertions.Assert
            (T.bloc.Lire_Bit_Bloc (Droite, I) = attendu_droite (I),
            "Le bit bloc DROITE " & I'Img &
            " vaut : " & T.bloc.Lire_Bit_Bloc (Droite, I)'Img &
            " au lieu de " & attendu_droite (I)'Img &
            " APRES 2 echanges."
            );
      end loop;

   end Test_Bits_Aleatoire_Par_Bloc_2_Echanges;

end Des_P.Bloc_P.Bloc_64_P.Test_P;
