with AUnit.Assertions;

package body Des_P.Bloc_P.Bloc_48_P.Faiseur_P.Test_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      use type Des_P.Bloc_P.Bloc_32_P.Intervalle_T;

      C : Faiseur_Bloc_T;
      B : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;
      I : Des_P.Bloc_P.Bloc_32_P.Intervalle_T :=
         Des_P.Bloc_P.Bloc_32_P.Intervalle_T'First;
   begin
      C.Preparer_Nouveau_Bloc;
      T.Constructeur := C;
      --  1110 0111 1111 0110
      --  1110 0111 1111 0110
      Construit_Bloc_32 :
      loop
         Init_Premier_Intervalle :
         for J in Intervalle_1_T loop
            B.Ecrire_Bit (I, True);
            I := Des_P.Bloc_P.Bloc_32_P.Intervalle_T'Succ (I);
         end loop Init_Premier_Intervalle;

         B.Ecrire_Bit (I, False);
         I := Des_P.Bloc_P.Bloc_32_P.Intervalle_T'Succ (I);

         B.Ecrire_Bit (I, False);
         I := Des_P.Bloc_P.Bloc_32_P.Intervalle_T'Succ (I);

         Init_Second_Intervalle :
         for J in Intervalle_2_T loop
            B.Ecrire_Bit (I, True);
            I := Des_P.Bloc_P.Bloc_32_P.Intervalle_T'Succ (I);
         end loop Init_Second_Intervalle;

         B.Ecrire_Bit (I, False);
         I := Des_P.Bloc_P.Bloc_32_P.Intervalle_T'Succ (I);

         Init_Troisieme_Intervalle :
         for J in Intervalle_3_T loop
            B.Ecrire_Bit (I, True);
            I := Des_P.Bloc_P.Bloc_32_P.Intervalle_T'Succ (I);
         end loop Init_Troisieme_Intervalle;

         B.Ecrire_Bit (I, False);
         exit Construit_Bloc_32 when
            I = Des_P.Bloc_P.Bloc_32_P.Intervalle_T'Last;
         I := Des_P.Bloc_P.Bloc_32_P.Intervalle_T'Succ (I);

      end loop Construit_Bloc_32;
      T.Brut := B;
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
   procedure Test_Preparation (T : in out Test_Fixt_T) is
      B : constant Bit_T := False;
      Valeur_Bit : Bit_IO_T;
   begin
      for I in Des_P.Bloc_P.Bloc_48_I_P.Intervalle_T loop
         Valeur_Bit := (if T.Constructeur.Bloc.Lire_Bit (I) then 1 else 0);
         AUnit.Assertions.Assert
            (T.Constructeur.Bloc.Lire_Bit (I) = B,
            "Le bit " & I'Img &
            " vaut : " & Valeur_Bit'Img &
            " au lieu de 0"
            );
      end loop;
   end Test_Preparation;

   ---------------------------------------------------------------------------
   procedure Test_Construction (T : in out Test_Fixt_T) is
      Bit_Resulta, Bit_Attendu : Bit_IO_T;
   begin
      T.Constructeur.Construire_Bloc (T.Brut);
      for I in Des_P.Bloc_P.Bloc_48_I_P.Intervalle_T loop
         Bit_Resulta := (if T.Constructeur.Bloc.Lire_Bit (I) then 1 else 0);
         Bit_Attendu := (if Resultat_Attendu (I) then 1 else 0);
         AUnit.Assertions.Assert
            (T.Constructeur.Bloc.Lire_Bit (I) = Resultat_Attendu (I),
            "Le bit " & I'Img &
            " vaut : " & Bit_Resulta'Img &
            " au lieu de " & Bit_Attendu'Img
            );
      end loop;
   end Test_Construction;

   ---------------------------------------------------------------------------
   procedure Test_Recuperation (T : in out Test_Fixt_T) is
      Bloc_Resultat : Bloc_48_T;
      Bit_Resulta, Bit_Attendu : Bit_IO_T;
   begin
      T.Constructeur.Construire_Bloc (T.Brut);
      Bloc_Resultat := T.Constructeur.Recuperer_Bloc;
      for I in Des_P.Bloc_P.Bloc_48_I_P.Intervalle_T loop
         Bit_Resulta := (if Bloc_Resultat.Lire_Bit (I) then 1 else 0);
         Bit_Attendu := (if Resultat_Attendu (I) then 1 else 0);
         AUnit.Assertions.Assert
            (Bloc_Resultat.Lire_Bit (I) = Resultat_Attendu (I),
            "Le bit " & I'Img &
            " vaut : " & Bit_Resulta'Img &
            " au lieu de " & Bit_Attendu'Img
            );
      end loop;
   end Test_Recuperation;

end Des_P.Bloc_P.Bloc_48_P.Faiseur_P.Test_P;
