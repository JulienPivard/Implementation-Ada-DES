with AUnit.Assertions;

with Des_P.Clef_P.Clef_56_I_P;

package body Des_P.Clef_P.Clef_56_P.Constructeur_P.Test_P is

   --  La clef de 64 bits:
   --  1111 0000 1111 0000 1111 0000 1111 0000
   --  1    5    9    13   17   21   25   29
   --  1111 0000 1111 0000 1111 0000 1111 0000
   --  33   37   41   45   49   53   57   61
   champ_bits_de_depart : constant
   Des_P.Clef_P.Clef_64_Simplifie_P.Tableau_Bits_T :=
      (1 .. 4 | 9 .. 12 | 17 .. 20 | 25 .. 28 | 33 .. 36 |
      41 .. 44 | 49 .. 52 | 57 .. 60 => False, others => True);

   --  La bits clef de 56 bits attendu après construction avec la
   --  clef de 64 bits ci-dessus.
   --  1111 1111 1111 1111 1111 1111 1111
   --  0000 0000 0000 0000 0000 0000 1111
   resultat_attendu : constant array
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
      constr : Constructeur_Clef_T;
      clef : Des_P.Clef_P.Clef_64_Simplifie_P.Clef_S_T;
   begin
      clef.Init (champ_bits_de_depart);
      T.clef_64 := clef;
      T.constructeur := constr;
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
      for I in Des_P.Clef_P.Clef_56_I_P.Intervalle_T'Range loop
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
      T.constructeur.Construire_Clef (T.clef_64);
      for I in Des_P.Clef_P.Clef_56_I_P.Intervalle_T'Range loop
         declare
            bit_attendu : constant Bit_T := resultat_attendu (I);
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
   end Test_Construire;

   ---------------------------------------------------------------------------
   procedure Test_Recuperation (T : in out Test_Fixt_T) is
      clef_construite : Clef_T;
   begin
      T.constructeur.Preparer_Nouvelle_Clef;
      T.constructeur.Construire_Clef (T.clef_64);
      clef_construite := T.constructeur.Recuperer_Clef;
      for I in Des_P.Clef_P.Clef_56_I_P.Intervalle_T'Range loop
         declare
            bit_attendu : constant Bit_T := resultat_attendu (I);
            bit_lu : constant Bit_T := clef_construite.Lire_Bit (I);
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

end Des_P.Clef_P.Clef_56_P.Constructeur_P.Test_P;
