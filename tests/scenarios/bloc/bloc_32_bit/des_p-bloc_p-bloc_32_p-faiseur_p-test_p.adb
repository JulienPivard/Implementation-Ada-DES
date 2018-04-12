with AUnit.Assertions;

package body Des_P.Bloc_P.Bloc_32_P.Faiseur_P.Test_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      c : Faiseur_Bloc_T;
   begin
      c.Preparer_Nouveau_Bloc;
      T.constructeur := c;
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
   ---------------------------------------------------------------------------
   procedure Test_Preparation
      (T : in out Test_Fixt_T)
   is
      b : constant Bit_IO_T := 0;
      valeur_bit : Bit_IO_T;
   begin
      for I in Intervalle_T'Range loop
         valeur_bit := (if T.constructeur.Bloc.Lire_Bit (I) then 1 else 0);
         AUnit.Assertions.Assert
            (valeur_bit = b,
            "Le bit " & I'Img &
            " vaut : " & valeur_bit'Img &
            " au lieu de 0"
            );
      end loop;
   end Test_Preparation;

   ---------------------------------------------------------------------------
   procedure Test_Construction_Avec_Brut
      (T : in out Test_Fixt_T)
   is
      bit_resulta, bit_attendu : Bit_IO_T;
   begin
      T.constructeur.Construire_Bloc (brut_attendu);
      for I in Intervalle_T'Range loop
         bit_resulta := (if T.constructeur.Bloc.Lire_Bit (I) then 1 else 0);
         bit_attendu := (if resultat_attendu (I) then 1 else 0);
         AUnit.Assertions.Assert
            (bit_resulta = bit_attendu,
            "Le bit " & I'Img &
            " vaut : " & bit_resulta'Img &
            " au lieu de " & bit_attendu'Img
            );
      end loop;
   end Test_Construction_Avec_Brut;

   ---------------------------------------------------------------------------
   procedure Test_Construction_Avec_Bloc_32
      (T : in out Test_Fixt_T)
   is
      bit_resulta, bit_attendu : Bit_IO_T;
      b : Bloc_32_T;
      res_attendu : constant array (Intervalle_T) of Bit_T :=
         (
            False, False, True, False,
            False, True, True, True,
            True, False, False, True,
            False, True, False, True,
            True, False, False, False,
            False, True, True, True,
            True, False, False, False,
            False, True, True, True
         );
   begin
      T.constructeur.Construire_Bloc (brut_attendu);
      for I in Intervalle_T'Range loop
         bit_resulta := (if T.constructeur.Bloc.Lire_Bit (I) then 1 else 0);
         bit_attendu := (if resultat_attendu (I) then 1 else 0);
         AUnit.Assertions.Assert
            (bit_resulta = bit_attendu,
            "Le bit " & I'Img &
            " vaut : " & bit_resulta'Img &
            " au lieu de " & bit_attendu'Img
            );
      end loop;
      b := T.constructeur.Recuperer_Bloc;

      T.constructeur.Preparer_Nouveau_Bloc;
      T.constructeur.Construire_Bloc (b);
      for I in Intervalle_T'Range loop
         bit_resulta := (if T.constructeur.Bloc.Lire_Bit (I) then 1 else 0);
         bit_attendu := (if res_attendu (I) then 1 else 0);
         AUnit.Assertions.Assert
            (bit_resulta = bit_attendu,
            "Le bit " & I'Img &
            " vaut : " & bit_resulta'Img &
            " au lieu de " & bit_attendu'Img
            );
      end loop;
   end Test_Construction_Avec_Bloc_32;

   ---------------------------------------------------------------------------
   procedure Test_Construction_Avec_Bloc_48
      (T : in out Test_Fixt_T)
   is
      bit_resulta, bit_attendu : Bit_IO_T;
      brut : Des_P.Bloc_P.Bloc_48_P.Bloc_48_T;
      res_attendu : Bloc_32_T;
   begin
      res_attendu.Bits :=
         (
            True, True, True, False,
            False, False, False, True,
            False, True, True, True,
            False, False, False, True,
            True, False, False, True,
            True, False, False, True,
            True, False, False, True,
            True, False, True, True
         );
      brut.Ecrire_Bit (1, False);
      brut.Ecrire_Bit (2, True);
      brut.Ecrire_Bit (3, True);
      brut.Ecrire_Bit (4, True);
      brut.Ecrire_Bit (5, True);
      brut.Ecrire_Bit (6, False);    -- 0 1111 0

      brut.Ecrire_Bit (7, True);
      brut.Ecrire_Bit (8, False);
      brut.Ecrire_Bit (9, True);
      brut.Ecrire_Bit (10, True);
      brut.Ecrire_Bit (11, False);
      brut.Ecrire_Bit (12, False);   -- 1 0110 0

      brut.Ecrire_Bit (13, False);
      brut.Ecrire_Bit (14, False);
      brut.Ecrire_Bit (15, True);
      brut.Ecrire_Bit (16, True);
      brut.Ecrire_Bit (17, True);
      brut.Ecrire_Bit (18, True);  --  0 0111 1

      brut.Ecrire_Bit (19, True);
      brut.Ecrire_Bit (20, True);
      brut.Ecrire_Bit (21, True);
      brut.Ecrire_Bit (22, True);
      brut.Ecrire_Bit (23, False);
      brut.Ecrire_Bit (24, True);  --  1 1110 1

      brut.Ecrire_Bit (25, False);
      brut.Ecrire_Bit (26, True);
      brut.Ecrire_Bit (27, True);
      brut.Ecrire_Bit (28, True);
      brut.Ecrire_Bit (29, True);
      brut.Ecrire_Bit (30, False);    -- 0 1111 0

      brut.Ecrire_Bit (31, True);
      brut.Ecrire_Bit (32, False);
      brut.Ecrire_Bit (33, True);
      brut.Ecrire_Bit (34, True);
      brut.Ecrire_Bit (35, False);
      brut.Ecrire_Bit (36, False);   -- 1 0110 0

      brut.Ecrire_Bit (37, False);
      brut.Ecrire_Bit (38, False);
      brut.Ecrire_Bit (39, True);
      brut.Ecrire_Bit (40, True);
      brut.Ecrire_Bit (41, True);
      brut.Ecrire_Bit (42, True);  --  0 0111 1

      brut.Ecrire_Bit (43, True);
      brut.Ecrire_Bit (44, True);
      brut.Ecrire_Bit (45, True);
      brut.Ecrire_Bit (46, True);
      brut.Ecrire_Bit (47, False);
      brut.Ecrire_Bit (48, True);  --  1 1110 1

      T.constructeur.Construire_Bloc (brut);
      for I in Intervalle_T'Range loop
         bit_resulta := (if T.constructeur.Bloc.Lire_Bit (I) then 1 else 0);
         bit_attendu := (if res_attendu.Lire_Bit (I) then 1 else 0);
         AUnit.Assertions.Assert
            (bit_resulta = bit_attendu,
            "Le bit " & I'Img &
            " vaut : " & bit_resulta'Img &
            " au lieu de " & bit_attendu'Img
            );
      end loop;
   end Test_Construction_Avec_Bloc_48;

   ---------------------------------------------------------------------------
   procedure Test_Recuperation
      (T : in out Test_Fixt_T)
   is
      bloc_resultat : Bloc_32_T;
      bit_resulta, bit_attendu : Bit_IO_T;
   begin
      T.constructeur.Construire_Bloc (brut_attendu);
      bloc_resultat := T.constructeur.Recuperer_Bloc;
      for I in Intervalle_T'Range loop
         bit_resulta := (if bloc_resultat.Lire_Bit (I) then 1 else 0);
         bit_attendu := (if resultat_attendu (I) then 1 else 0);
         AUnit.Assertions.Assert
            (bit_resulta = bit_attendu,
            "Le bit " & I'Img &
            " vaut : " & bit_resulta'Img &
            " au lieu de " & bit_attendu'Img
            );
      end loop;
   end Test_Recuperation;

   ---------------------------------------------------------------------------
   procedure Test_Transformation_Brut
      (T : in out Test_Fixt_T)
   is
      bit_resulta, bit_attendu : Bit_IO_T;
      bloc_resultat : Bloc_32_T;
      brut_recupere : Bloc_32_Brut_T;
   begin
      T.constructeur.Construire_Bloc (brut_attendu);
      bloc_resultat := T.constructeur.Recuperer_Bloc;
      for I in Intervalle_T'Range loop
         bit_resulta := (if bloc_resultat.Lire_Bit (I) then 1 else 0);
         bit_attendu := (if resultat_attendu (I) then 1 else 0);
         AUnit.Assertions.Assert
            (bit_resulta = bit_attendu,
            "Le bit " & I'Img &
            " vaut : " & bit_resulta'Img &
            " au lieu de " & bit_attendu'Img
            );
      end loop;
      brut_recupere := T.constructeur.Transformer_En_Brut (bloc_resultat);
      AUnit.Assertions.Assert
         (brut_recupere = brut_attendu,
         "Le brut recuprer vaut : " & brut_recupere'Img &
         " au lieu de " & brut_attendu'Img
         );
   end Test_Transformation_Brut;

end Des_P.Bloc_P.Bloc_32_P.Faiseur_P.Test_P;
