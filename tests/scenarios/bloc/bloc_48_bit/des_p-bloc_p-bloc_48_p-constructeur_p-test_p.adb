with AUnit.Assertions;

package body Des_P.Bloc_P.Bloc_48_P.Constructeur_P.Test_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      use Des_P.Bloc_P.Bloc_32_P;
      c : Constructeur_Bloc_48_T;
      b : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;
      I : Des_P.Bloc_P.Bloc_32_P.Intervalle_T :=
         Des_P.Bloc_P.Bloc_32_P.Intervalle_T'First;
   begin
      c.Preparer_Nouveau_Bloc;
      T.constructeur := c;
      Construit_Bloc_32 :
      --  1110 0111 1111 0110
      --  1110 0111 1111 0110
      loop
         for J in 1 .. 3 loop
            b.Ecrire_Bit (I, True);
            I := Des_P.Bloc_P.Bloc_32_P.Intervalle_T'Succ (I);
         end loop;

         b.Ecrire_Bit (I, False);
         I := Des_P.Bloc_P.Bloc_32_P.Intervalle_T'Succ (I);

         b.Ecrire_Bit (I, False);
         I := Des_P.Bloc_P.Bloc_32_P.Intervalle_T'Succ (I);

         for J in 1 .. 7 loop
            b.Ecrire_Bit (I, True);
            I := Des_P.Bloc_P.Bloc_32_P.Intervalle_T'Succ (I);
         end loop;

         b.Ecrire_Bit (I, False);
         I := Des_P.Bloc_P.Bloc_32_P.Intervalle_T'Succ (I);

         for J in 1 .. 2 loop
            b.Ecrire_Bit (I, True);
            I := Des_P.Bloc_P.Bloc_32_P.Intervalle_T'Succ (I);
         end loop;

         b.Ecrire_Bit (I, False);
         exit Construit_Bloc_32 when
            I = Des_P.Bloc_P.Bloc_32_P.Intervalle_T'Last;
         I := Des_P.Bloc_P.Bloc_32_P.Intervalle_T'Succ (I);

      end loop Construit_Bloc_32;
      T.brut := b;
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
      b : constant Bit_T := False;
      valeur_bit : Bit_IO_T;
   begin
      for I in Des_P.Bloc_P.Bloc_48_I_P.Intervalle_T'Range loop
         valeur_bit := (if T.constructeur.Bloc.Lire_Bit (I) then 1 else 0);
         AUnit.Assertions.Assert
            (T.constructeur.Bloc.Lire_Bit (I) = b,
            "Le bit " & I'Img &
            " vaut : " & valeur_bit'Img &
            " au lieu de 0"
            );
      end loop;
   end Test_Preparation;

   ---------------------------------------------------------------------------
   procedure Test_Construction (T : in out Test_Fixt_T) is
      bit_resulta, bit_attendu : Bit_IO_T;
   begin
      T.constructeur.Construire_Bloc (T.brut);
      for I in Des_P.Bloc_P.Bloc_48_I_P.Intervalle_T'Range loop
         bit_resulta := (if T.constructeur.Bloc.Lire_Bit (I) then 1 else 0);
         bit_attendu := (if resultat_attendu (I) then 1 else 0);
         AUnit.Assertions.Assert
            (T.constructeur.Bloc.Lire_Bit (I) = resultat_attendu (I),
            "Le bit " & I'Img &
            " vaut : " & bit_resulta'Img &
            " au lieu de " & bit_attendu'Img
            );
      end loop;
   end Test_Construction;

   ---------------------------------------------------------------------------
   procedure Test_Recuperation (T : in out Test_Fixt_T) is
      bloc_resultat : Bloc_48_T;
      bit_resulta, bit_attendu : Bit_IO_T;
   begin
      T.constructeur.Construire_Bloc (T.brut);
      bloc_resultat := T.constructeur.Recuperer_Bloc;
      for I in Des_P.Bloc_P.Bloc_48_I_P.Intervalle_T'Range loop
         bit_resulta := (if bloc_resultat.Lire_Bit (I) then 1 else 0);
         bit_attendu := (if resultat_attendu (I) then 1 else 0);
         AUnit.Assertions.Assert
            (bloc_resultat.Lire_Bit (I) = resultat_attendu (I),
            "Le bit " & I'Img &
            " vaut : " & bit_resulta'Img &
            " au lieu de " & bit_attendu'Img
            );
      end loop;
   end Test_Recuperation;

end Des_P.Bloc_P.Bloc_48_P.Constructeur_P.Test_P;
