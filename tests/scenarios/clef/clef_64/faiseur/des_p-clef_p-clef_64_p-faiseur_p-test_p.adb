with AUnit.Assertions;

with Des_P.Clef_P.Clef_64_I_P;

package body Des_P.Clef_P.Clef_64_P.Faiseur_P.Test_P is

   Clef_Brut_64 : constant
   Des_P.Clef_P.Clef_64_I_P.Faiseur_I_P.Clef_64_Brut_T :=
   2#11110000_11110000_11110000_11110000_11110000_11110000_11110000_11110000#;

   --  La clef de 64 bits:
   --  1111 0000 1111 0000 1111 0000 1111 0000
   --  1    5    9    13   17   21   25   29
   --  1111 0000 1111 0000 1111 0000 1111 0000
   --  33   37   41   45   49   53   57   61
   Resultat_Attendu : constant Tableau_Bits_T :=
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
      Constr : Faiseur_Clef_T;
   begin
      T.Constructeur := Constr;
   end Set_Up;

   ---------------------------------------------------------------------------
   overriding
   procedure Tear_Down
      (T : in out Test_Fixt_T)
   is
      Constr : Faiseur_Clef_T;
   begin
      T.Constructeur := Constr;
   end Tear_Down;

   ---------------------------------------------------------------------------
   --                              scénarios                                --
   ---------------------------------------------------------------------------
   ---------------------------------------------------------------------------
   procedure Test_Preparation (T : in out Test_Fixt_T) is
      Bit_Attendu : constant Bit_T := False;
   begin
      T.Constructeur.Preparer_Nouvelle_Clef;
      for I in Des_P.Clef_P.Clef_64_I_P.Intervalle_T loop
         Verification_Bit :
         declare
            Bit_Lu : constant Bit_T := T.Constructeur.Clef.Lire_Bit (I);
         begin
            AUnit.Assertions.Assert
            (
               Bit_Lu = Bit_Attendu,
               "Le bit " & I'Img &
               " vaut " & Bit_Lu'Img &
               " au lieu de " & Bit_Attendu'Img
            );
         end Verification_Bit;
      end loop;
   end Test_Preparation;

   ---------------------------------------------------------------------------
   procedure Test_Construire (T : in out Test_Fixt_T) is
   begin
      T.Constructeur.Preparer_Nouvelle_Clef;
      T.Constructeur.Construire_Clef (Clef_Brut_64);
      for I in Des_P.Clef_P.Clef_64_I_P.Intervalle_T loop
         Verification_Bit :
         declare
            Bit_Lu : constant Bit_T := T.Constructeur.Clef.Lire_Bit (I);
            Bit_Attendu : constant Bit_T := Resultat_Attendu (I);
         begin
            AUnit.Assertions.Assert
            (
               Bit_Lu = Bit_Attendu,
               "Le bit " & I'Img &
               " vaut " & Bit_Lu'Img &
               " au lieu de " & Bit_Attendu'Img
            );
         end Verification_Bit;
      end loop;
   end Test_Construire;

   ---------------------------------------------------------------------------
   procedure Test_Recuperation (T : in out Test_Fixt_T) is
      Clef_Construite : Clef_T;
   begin
      T.Constructeur.Preparer_Nouvelle_Clef;
      T.Constructeur.Construire_Clef (Clef_Brut_64);
      Clef_Construite := T.Constructeur.Recuperer_Clef;
      for I in Des_P.Clef_P.Clef_64_I_P.Intervalle_T loop
         Verification_Bit :
         declare
            Bit_Lu : constant Bit_T := Clef_Construite.Lire_Bit (I);
            Bit_Attendu : constant Bit_T := Resultat_Attendu (I);
         begin
            AUnit.Assertions.Assert
            (
               Bit_Lu = Bit_Attendu,
               "Le bit " & I'Img &
               " vaut " & Bit_Lu'Img &
               " au lieu de " & Bit_Attendu'Img
            );
         end Verification_Bit;
      end loop;
   end Test_Recuperation;

end Des_P.Clef_P.Clef_64_P.Faiseur_P.Test_P;
