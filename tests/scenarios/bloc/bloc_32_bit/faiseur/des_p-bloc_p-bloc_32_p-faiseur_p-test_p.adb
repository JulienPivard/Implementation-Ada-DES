with AUnit.Assertions;
with Des_P.Bloc_P.Bloc_48_P;

package body Des_P.Bloc_P.Bloc_32_P.Faiseur_P.Test_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      C : Faiseur_Bloc_T;
   begin
      C.Preparer_Nouveau_Bloc;
      T.Constructeur := C;
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
      B : constant Bit_IO_T := 0;
      Valeur_Bit : Bit_IO_T;
   begin
      for I in Intervalle_T loop
         Valeur_Bit := (if T.Constructeur.Bloc.Lire_Bit (I) then 1 else 0);
         AUnit.Assertions.Assert
            (Valeur_Bit = B,
            "Le bit " & I'Img &
            " vaut : " & Valeur_Bit'Img &
            " au lieu de 0"
            );
      end loop;
   end Test_Preparation;

   ---------------------------------------------------------------------------
   procedure Test_Construction_Avec_Brut
      (T : in out Test_Fixt_T)
   is
      Bit_Resulta, Bit_Attendu : Bit_IO_T;
   begin
      T.Constructeur.Construire_Bloc (Brut_Attendu);
      for I in Intervalle_T loop
         Bit_Resulta := (if T.Constructeur.Bloc.Lire_Bit (I) then 1 else 0);
         Bit_Attendu := (if Resultat_Attendu (I) then 1 else 0);
         AUnit.Assertions.Assert
            (Bit_Resulta = Bit_Attendu,
            "Le bit " & I'Img &
            " vaut : " & Bit_Resulta'Img &
            " au lieu de " & Bit_Attendu'Img
            );
      end loop;
   end Test_Construction_Avec_Brut;

   ---------------------------------------------------------------------------
   procedure Test_Construction_Avec_Bloc_32
      (T : in out Test_Fixt_T)
   is
      Bit_Resulta, Bit_Attendu : Bit_IO_T;
      B : Bloc_32_T;
      Res_Attendu : constant array (Intervalle_T) of Bit_T :=
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
      T.Constructeur.Construire_Bloc (Brut_Attendu);
      for I in Intervalle_T loop
         Bit_Resulta := (if T.Constructeur.Bloc.Lire_Bit (I) then 1 else 0);
         Bit_Attendu := (if Resultat_Attendu (I) then 1 else 0);
         AUnit.Assertions.Assert
            (Bit_Resulta = Bit_Attendu,
            "Le bit " & I'Img &
            " vaut : " & Bit_Resulta'Img &
            " au lieu de " & Bit_Attendu'Img
            );
      end loop;
      B := T.Constructeur.Recuperer_Bloc;

      T.Constructeur.Preparer_Nouveau_Bloc;
      T.Constructeur.Construire_Bloc (B);
      for I in Intervalle_T loop
         Bit_Resulta := (if T.Constructeur.Bloc.Lire_Bit (I) then 1 else 0);
         Bit_Attendu := (if Res_Attendu (I) then 1 else 0);
         AUnit.Assertions.Assert
            (Bit_Resulta = Bit_Attendu,
            "Le bit " & I'Img &
            " vaut : " & Bit_Resulta'Img &
            " au lieu de " & Bit_Attendu'Img
            );
      end loop;
   end Test_Construction_Avec_Bloc_32;

   ---------------------------------------------------------------------------
   procedure Test_Construction_Avec_Bloc_48
      (T : in out Test_Fixt_T)
   is
      Bit_Resulta, Bit_Attendu : Bit_IO_T;
      Brut : Des_P.Bloc_P.Bloc_48_P.Bloc_48_T;
      Res_Attendu : Bloc_32_T;
   begin
      Res_Attendu.Bits :=
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
      Brut.Ecrire_Bit (1, False);
      Brut.Ecrire_Bit (2, True);
      Brut.Ecrire_Bit (3, True);
      Brut.Ecrire_Bit (4, True);
      Brut.Ecrire_Bit (5, True);
      Brut.Ecrire_Bit (6, False);    -- 0 1111 0

      Brut.Ecrire_Bit (7, True);
      Brut.Ecrire_Bit (8, False);
      Brut.Ecrire_Bit (9, True);
      Brut.Ecrire_Bit (10, True);
      Brut.Ecrire_Bit (11, False);
      Brut.Ecrire_Bit (12, False);   -- 1 0110 0

      Brut.Ecrire_Bit (13, False);
      Brut.Ecrire_Bit (14, False);
      Brut.Ecrire_Bit (15, True);
      Brut.Ecrire_Bit (16, True);
      Brut.Ecrire_Bit (17, True);
      Brut.Ecrire_Bit (18, True);  --  0 0111 1

      Brut.Ecrire_Bit (19, True);
      Brut.Ecrire_Bit (20, True);
      Brut.Ecrire_Bit (21, True);
      Brut.Ecrire_Bit (22, True);
      Brut.Ecrire_Bit (23, False);
      Brut.Ecrire_Bit (24, True);  --  1 1110 1

      Brut.Ecrire_Bit (25, False);
      Brut.Ecrire_Bit (26, True);
      Brut.Ecrire_Bit (27, True);
      Brut.Ecrire_Bit (28, True);
      Brut.Ecrire_Bit (29, True);
      Brut.Ecrire_Bit (30, False);    -- 0 1111 0

      Brut.Ecrire_Bit (31, True);
      Brut.Ecrire_Bit (32, False);
      Brut.Ecrire_Bit (33, True);
      Brut.Ecrire_Bit (34, True);
      Brut.Ecrire_Bit (35, False);
      Brut.Ecrire_Bit (36, False);   -- 1 0110 0

      Brut.Ecrire_Bit (37, False);
      Brut.Ecrire_Bit (38, False);
      Brut.Ecrire_Bit (39, True);
      Brut.Ecrire_Bit (40, True);
      Brut.Ecrire_Bit (41, True);
      Brut.Ecrire_Bit (42, True);  --  0 0111 1

      Brut.Ecrire_Bit (43, True);
      Brut.Ecrire_Bit (44, True);
      Brut.Ecrire_Bit (45, True);
      Brut.Ecrire_Bit (46, True);
      Brut.Ecrire_Bit (47, False);
      Brut.Ecrire_Bit (48, True);  --  1 1110 1

      T.Constructeur.Construire_Bloc (Brut);
      for I in Intervalle_T loop
         Bit_Resulta := (if T.Constructeur.Bloc.Lire_Bit (I) then 1 else 0);
         Bit_Attendu := (if Res_Attendu.Lire_Bit (I) then 1 else 0);
         AUnit.Assertions.Assert
            (Bit_Resulta = Bit_Attendu,
            "Le bit " & I'Img &
            " vaut : " & Bit_Resulta'Img &
            " au lieu de " & Bit_Attendu'Img
            );
      end loop;
   end Test_Construction_Avec_Bloc_48;

   ---------------------------------------------------------------------------
   procedure Test_Recuperation
      (T : in out Test_Fixt_T)
   is
      Bloc_Resultat : Bloc_32_T;
      Bit_Resulta, Bit_Attendu : Bit_IO_T;
   begin
      T.Constructeur.Construire_Bloc (Brut_Attendu);
      Bloc_Resultat := T.Constructeur.Recuperer_Bloc;
      for I in Intervalle_T loop
         Bit_Resulta := (if Bloc_Resultat.Lire_Bit (I) then 1 else 0);
         Bit_Attendu := (if Resultat_Attendu (I) then 1 else 0);
         AUnit.Assertions.Assert
            (Bit_Resulta = Bit_Attendu,
            "Le bit " & I'Img &
            " vaut : " & Bit_Resulta'Img &
            " au lieu de " & Bit_Attendu'Img
            );
      end loop;
   end Test_Recuperation;

   ---------------------------------------------------------------------------
   procedure Test_Transformation_Brut
      (T : in out Test_Fixt_T)
   is
      Bit_Resulta, Bit_Attendu : Bit_IO_T;
      Bloc_Resultat : Bloc_32_T;
      Brut_Recupere : Bloc_32_Brut_T;
   begin
      T.Constructeur.Construire_Bloc (Brut_Attendu);
      Bloc_Resultat := T.Constructeur.Recuperer_Bloc;
      for I in Intervalle_T loop
         Bit_Resulta := (if Bloc_Resultat.Lire_Bit (I) then 1 else 0);
         Bit_Attendu := (if Resultat_Attendu (I) then 1 else 0);
         AUnit.Assertions.Assert
            (Bit_Resulta = Bit_Attendu,
            "Le bit " & I'Img &
            " vaut : " & Bit_Resulta'Img &
            " au lieu de " & Bit_Attendu'Img
            );
      end loop;
      Brut_Recupere := T.Constructeur.Transformer_En_Brut (Bloc_Resultat);
      AUnit.Assertions.Assert
         (Brut_Recupere = Brut_Attendu,
         "Le Brut recuprer vaut : " & Brut_Recupere'Img &
         " au lieu de " & Brut_Attendu'Img
         );
   end Test_Transformation_Brut;

end Des_P.Bloc_P.Bloc_32_P.Faiseur_P.Test_P;
