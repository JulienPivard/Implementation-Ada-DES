with AUnit.Assertions;

package body Des_P.Bloc_32_P.Constructeur_P.Test_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      c : Constructeur_Bloc_32_T;
   begin
      c.Preparer_Nouveau_Bloc_32 (brut_attendu);
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
      b : constant Bit_T := 0;
   begin
      AUnit.Assertions.Assert
         (T.constructeur.Brut = brut_attendu,
         "Le brut de 32 bits ne vaut pas la bonne valeur."
         );
      for I in Interval_Bloc_32_T'Range loop
         AUnit.Assertions.Assert
            (T.constructeur.Bloc.Lire_Bit (I) = b,
            "Le bit " & I'Img &
            " vaut : " & T.constructeur.Bloc.Lire_Bit (I)'Img &
            " au lieu de 0"
            );
      end loop;
   end Test_Preparation;

   ---------------------------------------------------------------------------
   procedure Test_Construction (T : in out Test_Fixt_T) is
   begin
      T.constructeur.Construire_Bloc;
      AUnit.Assertions.Assert
         (T.constructeur.Brut = brut_attendu,
         "Le brut de 32 bits a été modifié durant la construction."
         );
      for I in Interval_Bloc_32_T'Range loop
         AUnit.Assertions.Assert
            (T.constructeur.Bloc.Lire_Bit (I) = resultat_attendu (I),
            "Le bit " & I'Img &
            " vaut : " & T.constructeur.Bloc.Lire_Bit (I)'Img &
            " au lieu de " & resultat_attendu (I)'Img
            );
      end loop;
   end Test_Construction;

   ---------------------------------------------------------------------------
   procedure Test_Recuperation (T : in out Test_Fixt_T) is
      bloc_resultat : Bloc_32_T;
   begin
      T.constructeur.Construire_Bloc;
      AUnit.Assertions.Assert
         (T.constructeur.Brut = brut_attendu,
         "Le brut de 32 bits a été modifié durant la construction."
         );
      bloc_resultat := T.constructeur.Recuperer_Bloc_32;
      for I in Interval_Bloc_32_T'Range loop
         AUnit.Assertions.Assert
            (bloc_resultat.Lire_Bit (I) = resultat_attendu (I),
            "Le bit " & I'Img &
            " vaut : " & bloc_resultat.Lire_Bit (I)'Img &
            " au lieu de " & resultat_attendu (I)'Img
            );
      end loop;
   end Test_Recuperation;

end Des_P.Bloc_32_P.Constructeur_P.Test_P;
