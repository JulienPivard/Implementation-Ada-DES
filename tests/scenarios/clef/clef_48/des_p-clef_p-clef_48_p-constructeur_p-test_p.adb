with AUnit.Assertions;

with Des_P.Clef_P.Clef_48_I_P;

package body Des_P.Clef_P.Clef_48_P.Constructeur_P.Test_P is

   --  La clef de 56 bits:
   --  1111 0000 1111 0000 1111 0000 1111 0000 1111 0000 1111 0000 1111 0000
   champ_bits_de_depart : constant
   Des_P.Clef_P.Clef_56_Simplifie_P.Champ_De_Bits_T :=
      (1 .. 4 | 9 .. 12 | 17 .. 20 | 25 .. 28 | 33 .. 36 |
      41 .. 44 | 49 .. 52 => False, others => True);

   --  La clef de 56 bits:
   --  1111 0000 1111 0000 1111 0000 1111 0000 1111 0000 1111 0000 1111 0000
   --  Donne la sous clef suivante :
   --  0110 1011 0001 0111 1000 1101 1100 0000 1010 1100 1001 1100
   resultat_attendu : constant Tableau_Bits_T :=
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
      clef : Des_P.Clef_P.Clef_56_Simplifie_P.Clef_S_T;
   begin
      clef.Init (champ_bits_de_depart);
      T.clef_56 := clef;
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
      bit_attendu : constant Bit_T := False;
   begin
      T.constructeur.Preparer_Nouvelle_Clef;
      for I in Des_P.Clef_P.Clef_48_I_P.Intervalle_T'Range loop
         declare
            bit_lu : constant Bit_T := T.constructeur.Clef.Lire_Bit (I);
         begin
            AUnit.Assertions.Assert
            (bit_lu = bit_attendu,
            "Le bit " & I'Img &
            " vaut " & bit_lu'Img &
            " au lieu de " & bit_attendu'Img);
         end;
      end loop;
   end Test_Preparation;

   ---------------------------------------------------------------------------
   procedure Test_Construire (T : in out Test_Fixt_T) is
   begin
      T.constructeur.Preparer_Nouvelle_Clef;
      T.constructeur.Construire_Clef (T.clef_56);
      for I in Des_P.Clef_P.Clef_48_I_P.Intervalle_T'Range loop
         declare
            bit_lu : constant Bit_T := T.constructeur.Clef.Lire_Bit (I);
            bit_attendu : constant Bit_T := resultat_attendu (I);
         begin
            AUnit.Assertions.Assert
            (bit_lu = bit_attendu,
            "Le bit " & I'Img &
            " vaut " & bit_lu'Img &
            " au lieu de " & bit_attendu'Img);
         end;
      end loop;
   end Test_Construire;

   ---------------------------------------------------------------------------
   procedure Test_Recuperation (T : in out Test_Fixt_T) is
      clef_construite : Clef_T;
   begin
      T.constructeur.Preparer_Nouvelle_Clef;
      T.constructeur.Construire_Clef (T.clef_56);
      clef_construite := T.constructeur.Recuperer_Clef;
      for I in Des_P.Clef_P.Clef_48_I_P.Intervalle_T'Range loop
         declare
            bit_lu : constant Bit_T := clef_construite.Lire_Bit (I);
            bit_attendu : constant Bit_T := resultat_attendu (I);
         begin
            AUnit.Assertions.Assert
            (bit_lu = bit_attendu,
            "Le bit " & I'Img &
            " vaut " & bit_lu'Img &
            " au lieu de " & bit_attendu'Img);
         end;
      end loop;
   end Test_Recuperation;

end Des_P.Clef_P.Clef_48_P.Constructeur_P.Test_P;
