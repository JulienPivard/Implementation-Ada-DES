with AUnit.Assertions;

with Des_P.Clef_P.Clef_56_I_P;

package body Des_P.Clef_P.Clef_56_P.Faiseur_P.Test_P is

   --  La Clef de 64 bits:
   --  1111 0000 1111 0000 1111 0000 1111 0000
   --  1    5    9    13   17   21   25   29
   --  1111 0000 1111 0000 1111 0000 1111 0000
   --  33   37   41   45   49   53   57   61
   Champ_Bits_De_Depart : constant
   Des_P.Clef_P.Clef_64_Simplifie_P.Tableau_Bits_T :=
      (
         Intervalle_1_T | Intervalle_2_T | Intervalle_3_T |
         Intervalle_4_T | Intervalle_5_T | Intervalle_6_T |
         Intervalle_7_T | Intervalle_8_T => False,
         others => True
      );

   --  La bits Clef de 56 bits attendu après construction avec la
   --  Clef de 64 bits ci-dessus.
   --  1111 1111 1111 1111 1111 1111 1111
   --  0000 0000 0000 0000 0000 0000 1111
   Resultat_Attendu : constant array
      (Des_P.Clef_P.Clef_56_I_P.Intervalle_T)
      of Bit_T :=
         (
            False, False, False, False, False, False, False,
            False, False, False, False, False, False, False,
            False, False, False, False, False, False, False,
            False, False, False, False, False, False, False,
            True, True, True, True, True, True, True,
            True, True, True, True, True, True, True,
            True, True, True, True, True, True, True,
            True, True, True, False, False, False, False
         );

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      Constr : Faiseur_Clef_T;
      Clef : Des_P.Clef_P.Clef_64_Simplifie_P.Clef_S_T;
   begin
      Clef.Init (Champ_Bits_De_Depart);
      T.Clef_64 := Clef;
      T.Constructeur := Constr;
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
      for I in Des_P.Clef_P.Clef_56_I_P.Intervalle_T loop
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
      T.Constructeur.Construire_Clef (T.Clef_64);
      for I in Des_P.Clef_P.Clef_56_I_P.Intervalle_T loop
         Verification_Bit :
         declare
            Bit_Attendu : constant Bit_T := Resultat_Attendu (I);
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
   end Test_Construire;

   ---------------------------------------------------------------------------
   procedure Test_Recuperation (T : in out Test_Fixt_T) is
      Clef_Construite : Clef_T;
   begin
      T.Constructeur.Preparer_Nouvelle_Clef;
      T.Constructeur.Construire_Clef (T.Clef_64);
      Clef_Construite := T.Constructeur.Recuperer_Clef;
      for I in Des_P.Clef_P.Clef_56_I_P.Intervalle_T loop
         Verification_Bit :
         declare
            Bit_Attendu : constant Bit_T := Resultat_Attendu (I);
            Bit_Lu : constant Bit_T := Clef_Construite.Lire_Bit (I);
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

end Des_P.Clef_P.Clef_56_P.Faiseur_P.Test_P;
