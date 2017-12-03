with AUnit.Assertions;

package body Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Constructeur_56_P.Test_P is

   --  La clef de 64 bits:
   --  1111 0000 1111 0000 1111 0000 1111 0000
   --  1    5    9    13   17   21   25   29
   --  1111 0000 1111 0000 1111 0000 1111 0000
   --  33   37   41   45   49   53   57   61
   champ_bits_de_depart : constant
   Des_P.Clef_P.Clef_64_Abs_P.Clef_Simplifie_P.Tableau_Bits_T :=
      (1 .. 4 | 9 .. 12 | 17 .. 20 | 25 .. 28 | 33 .. 36 |
      41 .. 44 | 49 .. 52 | 57 .. 60 => 1, others => 0);

   --  La bits clef de 56 bits attendu après construction avec la
   --  clef de 64 bits ci-dessus.
   --  1111 1111 1111 1111 1111 1111 1111
   --  0000 0000 0000 0000 0000 0000 1111
   resultat_attendu : constant array
   (Intervalle_Clef_56_T range Intervalle_Clef_56_T'Range) of Bit_T :=
      (
         1, 1, 1, 1, 1, 1, 1,
         1, 1, 1, 1, 1, 1, 1,
         1, 1, 1, 1, 1, 1, 1,
         1, 1, 1, 1, 1, 1, 1,
         0, 0, 0, 0, 0, 0, 0,
         0, 0, 0, 0, 0, 0, 0,
         0, 0, 0, 0, 0, 0, 0,
         0, 0, 0, 1, 1, 1, 1
      );

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      constr : constant access Constructeur_Clef_56_T :=
         new Constructeur_Clef_56_T;
      clef : Clef_Simplifie_T;
   begin
      clef.Init (champ_bits_de_depart, constr);
      T.clef_64 := clef;
      T.constructeur := constr;
   end Set_Up;

   ---------------------------------------------------------------------------
   overriding
   procedure Tear_Down (T : in out Test_Fixt_T) is
   begin
      T.constructeur := null;
   end Tear_Down;

   ---------------------------------------------------------------------------
   procedure Test_Preparation (T : in out Test_Fixt_T) is
      bit_attendu : constant Bit_T := 0;
      bit_lu : Bit_T;
   begin
      T.constructeur.all.Preparer_Nouvelle_Clef_56;
      for I in Intervalle_Clef_56_T'Range loop
         bit_lu := T.constructeur.all.Clef_56.Lire_Bit (I);
         AUnit.Assertions.Assert
         (
            bit_lu = bit_attendu,
            "Le bit " & I'Img &
            " vaut " & bit_lu'Img &
            " au lieu de " & bit_attendu'Img
         );
      end loop;
   end Test_Preparation;

   ---------------------------------------------------------------------------
   procedure Test_Construire (T : in out Test_Fixt_T) is
      bit_lu : Bit_T;
      bit_attendu : Bit_T;
   begin
      T.constructeur.all.Preparer_Nouvelle_Clef_56;
      T.constructeur.all.Construire_Clef_56 (T.clef_64);
      for I in Intervalle_Clef_56_T'Range loop
         bit_lu := T.constructeur.all.Clef_56.Lire_Bit (I);
         bit_attendu := resultat_attendu (I);
         AUnit.Assertions.Assert
         (
            bit_lu = bit_attendu,
            "Le bit " & I'Img &
            " vaut " & bit_lu'Img &
            " au lieu de " & bit_attendu'Img
         );
      end loop;
      null;
   end Test_Construire;

   ---------------------------------------------------------------------------
   procedure Test_Recuperation (T : in out Test_Fixt_T) is
      clef_construite : Clef_56_T;
      bit_lu : Bit_T;
      bit_attendu : Bit_T;
   begin
      T.constructeur.all.Preparer_Nouvelle_Clef_56;
      T.constructeur.all.Construire_Clef_56 (T.clef_64);
      clef_construite := T.constructeur.all.Recuperer_Clef_56;
      for I in Intervalle_Clef_56_T'Range loop
         bit_lu := clef_construite.Lire_Bit (I);
         bit_attendu := resultat_attendu (I);
         AUnit.Assertions.Assert
         (
            bit_lu = bit_attendu,
            "Le bit " & I'Img &
            " vaut " & bit_lu'Img &
            " au lieu de " & bit_attendu'Img
         );
      end loop;
   end Test_Recuperation;

end Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Constructeur_56_P.Test_P;
