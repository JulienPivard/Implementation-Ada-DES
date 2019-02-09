with AUnit.Assertions;

with Des_P.Clef_P.Clef_48_I_P;

package body Des_P.Clef_P.Clef_48_P.Faiseur_P.Test_P is

   --  La clef de 56 bits:
   --  1111 0000 1111 0000 1111 0000 1111 0000 1111 0000 1111 0000 1111 0000
   Champ_Bits_De_Depart : constant
   Des_P.Clef_P.Clef_56_Simplifie_P.Champ_De_Bits_T :=
      (
         Intervalle_1_T | Intervalle_2_T | Intervalle_3_T |
         Intervalle_4_T | Intervalle_5_T | Intervalle_6_T |
         Intervalle_7_T => False,
         others => True
      );

   --  La clef de 56 bits:
   --  1111 0000 1111 0000 1111 0000 1111 0000 1111 0000 1111 0000 1111 0000
   --  Donne la sous clef suivante :
   --  0110 1011 0001 0111 1000 1101 1100 0000 1010 1100 1001 1100
   Resultat_Attendu : constant Tableau_Bits_T :=
      (
         True, False, False, True, False, True,
         False, False, True, True, True, False,
         True, False, False, False, False, True,
         True, True, False, False, True, False,
         False, False, True, True, True, True,
         True, True, False, True, False, True,
         False, False, True, True, False, True,
         True, False, False, False, True, True
      );

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      Clef : Des_P.Clef_P.Clef_56_Simplifie_P.Clef_S_T;
   begin
      Clef.Init (Champ_Bits_De_Depart);
      T.Clef_56 := Clef;
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
      Bit_Attendu : constant Bit_T := False;
   begin
      T.Constructeur.Preparer_Nouvelle_Clef;
      for I in Des_P.Clef_P.Clef_48_I_P.Intervalle_T loop
         declare
            Bit_Lu : constant Bit_T := T.Constructeur.Clef.Lire_Bit (I);
         begin
            AUnit.Assertions.Assert
            (Bit_Lu = Bit_Attendu,
            "Le bit " & I'Img &
            " vaut " & Bit_Lu'Img &
            " au lieu de " & Bit_Attendu'Img);
         end;
      end loop;
   end Test_Preparation;

   ---------------------------------------------------------------------------
   procedure Test_Construire (T : in out Test_Fixt_T) is
   begin
      T.Constructeur.Preparer_Nouvelle_Clef;
      T.Constructeur.Construire_Clef (T.Clef_56);
      for I in Des_P.Clef_P.Clef_48_I_P.Intervalle_T loop
         declare
            Bit_Lu : constant Bit_T := T.Constructeur.Clef.Lire_Bit (I);
            Bit_Attendu : constant Bit_T := Resultat_Attendu (I);
         begin
            AUnit.Assertions.Assert
            (Bit_Lu = Bit_Attendu,
            "Le bit " & I'Img &
            " vaut " & Bit_Lu'Img &
            " au lieu de " & Bit_Attendu'Img);
         end;
      end loop;
   end Test_Construire;

   ---------------------------------------------------------------------------
   procedure Test_Recuperation (T : in out Test_Fixt_T) is
      Clef_Construite : Clef_T;
   begin
      T.Constructeur.Preparer_Nouvelle_Clef;
      T.Constructeur.Construire_Clef (T.Clef_56);
      Clef_Construite := T.Constructeur.Recuperer_Clef;
      for I in Des_P.Clef_P.Clef_48_I_P.Intervalle_T loop
         declare
            Bit_Lu : constant Bit_T := Clef_Construite.Lire_Bit (I);
            Bit_Attendu : constant Bit_T := Resultat_Attendu (I);
         begin
            AUnit.Assertions.Assert
            (Bit_Lu = Bit_Attendu,
            "Le bit " & I'Img &
            " vaut " & Bit_Lu'Img &
            " au lieu de " & Bit_Attendu'Img);
         end;
      end loop;
   end Test_Recuperation;

end Des_P.Clef_P.Clef_48_P.Faiseur_P.Test_P;
