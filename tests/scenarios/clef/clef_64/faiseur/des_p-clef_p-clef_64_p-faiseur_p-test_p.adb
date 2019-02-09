with AUnit.Assertions;

with Des_P.Clef_P.Clef_64_I_P;

package body Des_P.Clef_P.Clef_64_P.Faiseur_P.Test_P is

   clef_brut_64 : constant
   Des_P.Clef_P.Clef_64_I_P.Faiseur_I_P.Clef_64_Brut_T :=
   2#11110000_11110000_11110000_11110000_11110000_11110000_11110000_11110000#;

   --  La clef de 64 bits:
   --  1111 0000 1111 0000 1111 0000 1111 0000
   --  1    5    9    13   17   21   25   29
   --  1111 0000 1111 0000 1111 0000 1111 0000
   --  33   37   41   45   49   53   57   61
   resultat_attendu : constant Tableau_Bits_T :=
      (
         Intervalle_1_T | Intervalle_2_T | Intervalle_3_T |
         Intervalle_4_T | Intervalle_5_T | Intervalle_6_T |
         Intervalle_7_T | Intervalle_8_T => False,
         others => True
      );

   overriding
   procedure Set_Up
      (T : in out Test_Fixt_T)
   is
      constr : Faiseur_Clef_T;
   begin
      T.constructeur := constr;
   end Set_Up;

   ---------------------------------------------------------------------------
   overriding
   procedure Tear_Down
      (T : in out Test_Fixt_T)
   is
      constr : Faiseur_Clef_T;
   begin
      T.constructeur := constr;
   end Tear_Down;

   ---------------------------------------------------------------------------
   --                              scénarios                                --
   ---------------------------------------------------------------------------
   ---------------------------------------------------------------------------
   procedure Test_Preparation (T : in out Test_Fixt_T) is
      bit_attendu : constant Bit_T := False;
   begin
      T.constructeur.Preparer_Nouvelle_Clef;
      for I in Des_P.Clef_P.Clef_64_I_P.Intervalle_T loop
         declare
            bit_lu : constant Bit_T := T.constructeur.Clef.Lire_Bit (I);
         begin
            AUnit.Assertions.Assert
            (
               bit_lu = bit_attendu,
               "Le bit " & I'Img &
               " vaut " & bit_lu'Img &
               " au lieu de " & bit_attendu'Img
            );
         end;
      end loop;
   end Test_Preparation;

   ---------------------------------------------------------------------------
   procedure Test_Construire (T : in out Test_Fixt_T) is
   begin
      T.constructeur.Preparer_Nouvelle_Clef;
      T.constructeur.Construire_Clef (clef_brut_64);
      for I in Des_P.Clef_P.Clef_64_I_P.Intervalle_T loop
         declare
            bit_lu : constant Bit_T := T.constructeur.Clef.Lire_Bit (I);
            bit_attendu : constant Bit_T := resultat_attendu (I);
         begin
            AUnit.Assertions.Assert
            (
               bit_lu = bit_attendu,
               "Le bit " & I'Img &
               " vaut " & bit_lu'Img &
               " au lieu de " & bit_attendu'Img
            );
         end;
      end loop;
   end Test_Construire;

   ---------------------------------------------------------------------------
   procedure Test_Recuperation (T : in out Test_Fixt_T) is
      clef_construite : Clef_T;
   begin
      T.constructeur.Preparer_Nouvelle_Clef;
      T.constructeur.Construire_Clef (clef_brut_64);
      clef_construite := T.constructeur.Recuperer_Clef;
      for I in Des_P.Clef_P.Clef_64_I_P.Intervalle_T loop
         declare
            bit_lu : constant Bit_T := clef_construite.Lire_Bit (I);
            bit_attendu : constant Bit_T := resultat_attendu (I);
         begin
            AUnit.Assertions.Assert
            (
               bit_lu = bit_attendu,
               "Le bit " & I'Img &
               " vaut " & bit_lu'Img &
               " au lieu de " & bit_attendu'Img
            );
         end;
      end loop;
   end Test_Recuperation;

end Des_P.Clef_P.Clef_64_P.Faiseur_P.Test_P;
