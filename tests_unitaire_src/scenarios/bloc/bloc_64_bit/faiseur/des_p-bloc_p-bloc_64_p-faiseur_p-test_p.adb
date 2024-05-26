with AUnit.Assertions;

package body Des_P.Bloc_P.Bloc_64_P.Faiseur_P.Test_P is

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
   procedure Test_Preparation (T : in out Test_Fixt_T) is
      B : constant Bit_T := False;
      Valeur_Bit : Bit_IO_T;
   begin
      for I in Intervalle_T loop
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
      T.Constructeur.Construire_Bloc (Brut_Attendu);
      for I in Intervalle_T loop
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
      Bloc_Resultat : Bloc_64_T;
      Bit_Resulta, Bit_Attendu : Bit_IO_T;
   begin
      T.Constructeur.Construire_Bloc (Brut_Attendu);
      Bloc_Resultat := T.Constructeur.Recuperer_Bloc;
      for I in Intervalle_T loop
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

   ---------------------------------------------------------------------------
   procedure Test_Transformation_Brut (T : in out Test_Fixt_T) is
      Bit_Resulta, Bit_Attendu : Bit_IO_T;
      Bloc_Resultat : Bloc_64_T;
      Brut_Recupere : Bloc_64_Brut_T;
   begin
      T.Constructeur.Construire_Bloc (Brut_Attendu);
      Bloc_Resultat := T.Constructeur.Recuperer_Bloc;
      for I in Intervalle_T loop
         Bit_Resulta := (if Bloc_Resultat.Lire_Bit (I) then 1 else 0);
         Bit_Attendu := (if Resultat_Attendu (I) then 1 else 0);
         AUnit.Assertions.Assert
            (Bloc_Resultat.Lire_Bit (I) = Resultat_Attendu (I),
            "Le bit " & I'Img &
            " vaut : " & Bit_Resulta'Img &
            " au lieu de " & Bit_Attendu'Img
            );
      end loop;
      Brut_Recupere := T.Constructeur.Transformer_En_Brut (Bloc_Resultat);
      AUnit.Assertions.Assert
         (Brut_Recupere = Brut_Attendu,
         "Le brut recuprer vaut : " & Brut_Recupere'Img &
         " au lieu de " & Brut_Attendu'Img
         );
   end Test_Transformation_Brut;

end Des_P.Bloc_P.Bloc_64_P.Faiseur_P.Test_P;
