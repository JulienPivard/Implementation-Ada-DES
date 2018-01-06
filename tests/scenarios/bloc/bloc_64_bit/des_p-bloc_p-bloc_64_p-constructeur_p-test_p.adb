with AUnit.Assertions;

package body Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Test_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      c : Constructeur_Bloc_64_T;
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
   procedure Test_Preparation (T : in out Test_Fixt_T) is
      b : constant Bit_T := False;
      valeur_bit : Bit_IO_T;
   begin
      for I in Intervalle_Bloc_64_T'Range loop
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
      T.constructeur.Construire_Bloc (brut_attendu);
      for I in Intervalle_Bloc_64_T'Range loop
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
      bloc_resultat : Bloc_64_T;
      bit_resulta, bit_attendu : Bit_IO_T;
   begin
      T.constructeur.Construire_Bloc (brut_attendu);
      bloc_resultat := T.constructeur.Recuperer_Bloc;
      for I in Intervalle_Bloc_64_T'Range loop
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

end Des_P.Bloc_P.Bloc_64_P.Constructeur_P.Test_P;
